module Halsbe
	class VM
		
		# TODO
		# * Use trees for memory fragments collections
		# * implement all the resize/grow/shrink functions properly
		class Memory
			class OutOfMemory < Exception; end

			Fragment  = Struct.new(:free, :start, :end, :size) unless const_defined? :Fragment
			class Fragment
				def inspect
					sprintf "<Fragment %s %d-%d %d%s>",
						free ? 'free' : 'used',
						start,
						self.end,
						size,
						'bytes'
				end
			end

			MinGrowLog = 12
			MinGrow    = 1 << MinGrowLog     # 4KB
			MaxGrow    = 1 << (MinGrowLog*2) # 16MB
			Zero       = ("\000"*MinGrow).freeze
			
			attr_reader :memory, :free_size, :fragments, :free, :used

			def initialize(size=MinGrow<<1)
				@memory    = Zero*(size>>MinGrowLog) # the whole memory
				@free_size = @memory.size            # the amount of free space (used for grow/shrink calcs)
				@fragments = [                       # memory fragments
					Fragment.new(true, 0, @free_size-1, @free_size),
				]
				@by_start  = @fragments.dup
				@free      = @fragments.dup
				@used      = []
			end
			
			def total_size
				@memory.size
			end
			
			def used_size
				@memory.size-@free_size
			end

			# Allocate a new memory fragment for use
			# Automatically grows the memory if possible
			# * size: the size to allocate
			# * grow_type:
			#   * :fixed:   never changes its size
			#   * :grows:   will grow in one direction
			#   * :both:    will grow in both directions
			#   * :unknown: grow behaviour is unknown
			# * grow:
			# * front_grow: 
			def allocate(size, grow_type=:unknown, grow=nil, front_grow=nil)
				raise OutOfMemory unless found = @free.find { |fragment| fragment.size >= size }
				return found if found.size == size
				frag1 = Fragment.new(false, found.start, found.start+size-1, size)
				frag2 = Fragment.new(true, found.start+size, found.end, found.size-size)
				@free.delete(found)
				@fragments.delete(found)
				@free << frag2
				@used << frag1
				@fragments.push(frag1, frag2)
				@free_size -= size
				update_free
				update_used
				update_fragments
				frag1
			rescue OutOfMemory
				if @free_size > size && @free_size > (@memory.size >> 4) then
					defragment
				else
					grow() until @free_size > size
				end
				retry
			end
			
			# tries to resize the fragment or creates a new one,
			# returns the fragment to use
			# the new size may be smaller or bigger than the current size
			# also see #grow and #shrink
			def fragment_resize(fragment, to_size)
				case to_size <=> fragment.size
					when 0 # nothing
						fragment
					when -1
						fragment_shrink(fragment, to_size)
					when 1
						fragment_grow(fragment, to_size)
				end
			end
			
			# tries to grow the memory to the desired size
			# returns the fragment to use
			# the new size MUST be bigger than or equal to the current size
			def fragment_grow(fragment, to_size)
				newfrag = allocate(size)
				move(fragment.start, newfrag.start, fragment.size)
				fragment_release(fragment)
				newfrag
			end
			
			# tries to shrink the memory to the desired size
			# returns the fragment to use
			# the new size MUST be smaller than or equal to the current size
			def fragment_shrink(fragment, to_size)
				fragment.end    = fragment.start+to_size
				next_frag       = fragment_next(fragment)
				next_frag.start = fragment.end if next_frag
				fragment
			end

			def fragment_front_resize(fragment, front, to_size)
				case to_size <=> fragment.size
					when 0 # nothing
						fragment
					when -1
						fragment_front_shrink(fragment, to_size)
					when 1
						fragment_front_grow(fragment, to_size)
				end
			end
			
			def fragment_front_grow(fragment, to_size)
				new_frag = allocate(to_size)
				move(fragment.start, new_frag.end-fragment.size, fragment.size)
				fragment_release(fragment)
				new_frag
			end
			
			# Resize the given fragment to to_size where to_size MUST BE <= fragment.size
			# Resizes from the front, 
			def fragment_front_shrink(fragment, to_size)
				fragment.start = fragment.end-to_size
				prev_frag      = fragment_previous(fragment)
				prev_frag.end  = fragment.start if prev_frag
				fragment
			end
			
			# Get the fragment locally previous to the given fragment
			# Or: get the other_fragment for which: other_fragment.end+1 == fragment.start
			def fragment_previous(fragment)
				idx = @fragments.index(fragment)
				idx.zero? ? nil : @fragments.at(idx-1)
			end
			
			# Get the fragment locally next to the given fragment
			# Or: get the other_fragment for which: fragment.end+1 == other_fragment.start
			def fragment_next(fragment)
				idx = @fragments.index(fragment)+1
				idx == @fragments.length ? nil : @fragments.at(idx)
			end
			
			# Release a used fragment, so it becomes free memory again
			def fragment_release(fragment)
				raise "Can't release an already free fragment" if fragment.free
				before = fragment_prev(fragment)
				after  = fragment_next(fragment)
				@free_size += fragment.size
				@used.delete(fragment)
				if before.free then
					if after.free then
						@free.delete(before)
						@free.delete(after)
						newfrag = Fragment.new(true, before.start, after.end, fragment.size+before.size+after.size)
						@free << newfrag
					else
						@free.delete(before)
						newfrag = Fragment.new(true, before.start, fragment.end, fragment.size+before.size)
						@free << newfrag
					end
				elsif after.free
					@free.delete(after)
					newfrag = Fragment.new(true, fragment.start, after.end, fragment.size+after.size)
					@free << newfrag
				else
					fragment.free = true
					@free << fragment
				end
				update_free
				nil
			end
			
			def move(from, to, size)
				@memory[to, size] = @memory[from, size]
			end

			def defragment
				raise "not implemented"
			end
		
			def grow
				frag = @free.last.end+1 == @memory.size ? @free.pop : Fragment.new(true, @memory.size, @memory.size, 0)
				grow_size   = grow_size()
				zeros       = Zero*grow_size.div(MinGrow)
				@free_size += grow_size
				frag.size  += grow_size
				frag.end   += grow_size
				@free << frag
				@memory << zeros
			end
			
			# half the current size, but between MinGrow and MaxGrow
			def grow_size
				try = ((@memory.size >> 1) >> MinGrowLog) << MinGrowLog # half the current size
				if try < MinGrow then
					MinGrow
				elsif try > MaxGrow then
					MaxGrow
				else
					try
				end
			end
			
			def shrink
				# I'm lazy right now
			end
			
			## those will be obsolete once we have trees
			def update_free
				@free.replace(@free.sort_by { |fragment| fragment.start })
			end
			
			def update_used
				@used.replace(@used.sort_by { |fragment| fragment.start })
			end
			
			def update_fragments
				@fragments.replace(@fragments.sort_by { |fragment| fragment.start })
			end
			
			def inspect
				sprintf "<Memory %dKB/%dKB (%.1f%%)>",
					used_size  >> 10,
					total_size >> 10,
					(100.0*used_size)/total_size
			end
		end
	end
end

__END__
start, end, size
- schnelles auffinden des nächst grösseren wertes (t > x mit min(t-x))
- schnelle detektion aneinanderliegender segmente (a.start == b.end)
- 

memory_resize
memory_grow
memory_shrink
memory_front_resize
memory_front_grow
memory_front_shrink
memory_size
memory_move
memory_copy
memory_freeze
memory_range
memory_slice
memory_at
memory_grows
memory_freeze
memory_release
