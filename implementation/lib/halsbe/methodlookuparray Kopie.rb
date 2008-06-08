require 'pp'
require 'enumerator'

class MLA
	ReferenceSize = 4

	attr_reader :address_size, :lookup, :map

	def initialize(map)
		map = map.sort
		lookup = [0]
		map.each { |k,v|
			lookup << k.length + lookup.last + ReferenceSize
		}

		@address_size = 2
		@lookup       = lookup.pack("S*")
		@map          = map.map { |k,v| [v,k].pack("IA*") }.join("")
	end
	
	def empty?
		@map.empty?
	end
	
	def [](name)
		size    = @lookup.length.div(@address_size)
		l_idx   = 0
		r_idx   = size-1
		
		while(l_idx < r_idx)
			index       = l_idx + ((r_idx - l_idx) >> 1) # avoid overflow (only in D)
			key, value  = at(index)
			if key < name then
				l_idx = index + 1
			else
				r_idx = index
			end
		end
		key, value  = at(l_idx)
		if l_idx < size && key == name then
			value
		else
			nil
		end
	end
	
	def at(index)
		offset, length = @lookup[index*@address_size, @address_size*2].unpack("SS")
		@map[offset, length-offset].unpack("IA*").reverse
	end
end

if __FILE__ == $0 then
	$count = Hash.new(0)
	i=0
	str_im = String.instance_methods.sort.map { |e| [e, (i+=1)] }
	mla = MLA.new(str_im)
	class Fixnum
		%w[
			old_lshift <<
			old_rshift >>
			old_plus +
			old_minus -
			old_multiply *
			old_divide /
			old_int_divide div
			old_cmp <=>
			old_zero? zero?
			old_equal ==
		].each_slice(2) { |a,b|
			eval("alias #{a} #{b}\ndef #{b}(*args); $count['#{b}']=$count['#{b}'].old_plus(1); #{a}(*args); end")
		}
	end

	def tcmp(a,b)
		p [a, b, a <=> b]
	end
	class String
		def ==(other)
			return false unless size == other.size
			unpack("C*").zip(other.unpack("C*")) { |a,b| return false unless a == b }
			true
		end

		def <=>(other)
			ocmp = size.old_cmp(other.size)
			case ocmp
				when 0, -1
					unpack("C*").zip(other.unpack("C*")) { |x,y|
						cmp = x <=> y
						return cmp unless cmp == 0
					}
				when 1
					other.unpack("C*").zip(unpack("C*")) { |y,x|
						cmp = x <=> y
						return cmp unless cmp == 0
					}
			end
			ocmp
		end
	end
	
	$count = Hash.new(0)
	$count["words"] = str_im.length
	str_im.each { |m,v|
		raise "#{m} should have value #{v} but has #{mla[m]}" unless mla[m] == v
	}
	pp $count
end

__END__
		index   = (l_idx + r_idx) >> 1
		offset  = 0 # smallest offset within name
		l_off   = 0 # left offset within name
		r_off   = 0 # right offset within name
		max_off = name.length
		
		return nil if empty?

		until l_idx == r_idx
			key, value  = at(index)
			p [key, value, index, l_idx, r_idx]
			current     = offset
			max_current = max_off > key.length ? key.length : max_off
			cmp         = 0

			loop do
				break if current >= max_current
				cmp = key[current] <=> name[current]
				if cmp.zero? and current < max_current
					current += 1
				else
					break
				end
			end
			case cmp
				when 1 # go towards smaller indices
					r_off  = current
					offset = l_off < r_off ? l_off : r_off
					r_idx  = index-1
					index  = (l_idx + r_idx) >> 1
				when -1 # go towards bigger indices
					l_off  = current
					offset = l_off < r_off ? l_off : r_off
					l_idx  = index+1
					index  = (l_idx + r_idx) >> 1
				else
					case key.length <=> name.length
						when 1 # go towards smaller indices
							r_off  = current
							offset = l_off < r_off ? l_off : r_off
							r_idx  = index-1
							index  = (l_idx + r_idx) >> 1
						when -1 # go towards bigger indices
							l_off  = current
							offset = l_off < r_off ? l_off : r_off
							l_idx  = index+1
							index  = (l_idx + r_idx) >> 1
						else
							return value
					end # case
			end # case
		end 

		key, value  = at(index)
		p [key, value, index, l_idx, r_idx]
		current     = offset
		max_current = max_off > key.length ? key.length : max_off
		cmp         = 0

		loop do
			break if current >= max_current
			cmp = key[current] <=> name[current]
			if cmp.zero? and current < max_current
				current += 1
			else
				break
			end
		end

		return value if cmp.zero? and key.length <=> name.length
		nil
	end
