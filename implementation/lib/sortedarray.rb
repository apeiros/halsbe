# def ld; load("sortedarray.rb"); end; ld

# an array that keeps sort order
# almost all methods work exactly like those of Array
# methods mixed in via Enumerable may return an Array,
# methods defined by Array are overriden to return a SortedArray
class SortedArray < Array
	alias sort_array sort! unless instance_methods.include?("sort_array")
	alias revert_array reverse! unless instance_methods.include?("revert_array")
	alias insert_at insert unless instance_methods.include?("insert_at")
	protected :sort_array, :revert_array, :insert_at

	# the default sorting, it is { |a,b| a <=> b }
	DefaultSorting = proc { |a,b| a <=> b }
	
	# keeps sort_by and sort of left-hand SortedArray
	%w(& - concat reject select).each { |method_name|
		eval("def #{method_name}(*args, &block) dup.replace(super) end")
	}
	
	# following inherited methods return a SortedArray already but might
	# change sort order
	%w(* + |).each { |method_name|
		eval("def #{method_name}(*args, &block) SortedArray.new(@order, @sort_by, *super(*args, &block), &@sort) end")
	}
	
	# following inherited methods keep the SortedArray, but might
	# change sort order
	%w(map! flatten!).each { |method_name|
		eval("def #{method_name}(*args, &block) super; resort; end")
	}
	
	def self.[](*items, &block)
		new(&block).replace(items).send(:resort)
	end

	def initialize(sort_order=:ascending, sort_by=nil, *items, &sort)
		@order = case sort_order
			when  1, :ascending:   1
			when -1, :descending: -1
			else raise ArgumentError, "Invalid sort order, must be :ascending or :descending, but is #{sort_order.inspect}"
		end

		@sort_by, @sort = sort_by, sort || DefaultSorting
		replace(items)
		resort
	end

	def initialize_copy(original)
		@sort    = original.sort_proc
		@sort_by = original.sort_by_proc
	end
	
	def order
		@order == 1 ? :ascending : :descending
	end
	
	# constructor-helper
	# SortedArray[1,2,3].with_sorting(:ascending, proc { |x| -x }) { |a,b| a <=> b }
	def with_sorting(sort_order, sort_by=nil, &sort)
		self.order=sort_order
		@sort    = sort || DefaultSorting
		@sort_by = sort_by
		self
	end
	
	def order=(sort_order)
		if sort_order != order then
			@order = case sort_order
				when  1, :ascending:   1
				when -1, :descending: -1
				else raise ArgumentError, "Invalid sort order, must be :ascending or :descending, but is #{sort_order.inspect}"
			end
			revert_array
		end
	end

	def push(*arguments)
		arguments.each { |argument|
			found = last_index(argument)
			insert_at(found[0] ? found[1]+1 : found[1] || length, argument)
		}
		self
	end
	alias << push

	def []=(*arguments)
		values = arguments.pop
		at     = if arguments.first.kind_of?(Range) then
			arguments.first
		elsif arguments.first < 0 then
			length+arguments.first
		else
			arguments.first
		end
		slice!(*arguments)
		insert(at,*values) if values
	end

	def include?(value)
		binary_search(value)
	end

	# only partially useful. allows to insert at a specific index
	# between elements with the same sorting index - else it works like
	# push or unshift
	# examples:
	#    Person = Struct.new(:name, :age)
	#    x = SortedArray[Person["Adam", 20], Person["Eva", 20]].sort_by! { |person| person.age }
	#    x.insert(1, Person["Peter", 20])
	#    x # => SortedArray[#<Person name="Adam", age=20>, #<Person name="Peter", age=20>, #<Person name="Eva", age=20>]
	#    x.push(Person["Joe", 25], Person["Jane", 18])
	#    # => ...[<Jane, 18>, <Adam, 20>, <Peter, 20>, <Eva, 20>, <Joe, 25>] # simplified
	#    x.insert(0, Person["Clark", 20]) # like unshift
	#    # => [<Jane, 18>, <Clark, 20>, <Adam, 20>, <Peter, 20>, <Eva, 20>, <Joe, 25>]
	#    x.insert(20, Person["Louis", 20]) # like push
	#    # => [<Jane, 18>, <Clark, 20>, <Adam, 20>, <Peter, 20>, <Eva, 20>, <Louis, 20>, <Joe, 25>]
	def insert(at, *objects)
		objects.each { |object|
			found    = last_index(object)
			position = if found[0] then
				if at > found[1] then
					found[1]+1
				else
					found2 = first_index(object)
					if found2[1] < at then
						at
					else
						found2[1]
					end
				end
			else
				found[1] || length
			end
			insert_at(position, object)
			at += 1 if position < at
		}
		self
	end
	
	def inspect
		"SortedArray(#{@order.inspect})"+super
	end
	
	def reverse
		dup.reverse!
	end
	
	# returns the new sorted self
	def reverse!
		@order *= -1
		resort
	end
	
	def sort(&sort)
		raise ArgumentError, "No block given" unless sort
		SortedArray.new(@order, @sort_by, *self, &sort)
	end
	
	def sort!(&block)
		@sort = block
		resort
		self
	end
	
	def sort_proc
		@sort
	end
	
	def sort_by(&sort_by)
		raise ArgumentError, "No block given" unless sort_by
		SortedArray.new(@order, sort_by, *self, &@sort)
	end
	
	def sort_by!(&block)
		@sort_by = block
		resort
		self
	end
	
	def sort_by_proc
		@sort_by
	end
	
	def unshift(*arguments)
		arguments.each { |argument|
			found = first_index(argument)
			insert_at(found[0] ? found[1] : (found[1] || -1)+1, argument)
		}
		self
	end
	
	# returns smallest index of a value <=> object
	def index(object)
		return nil if empty? # edgecase
		found = first_index(object)
		return found[0] ? found[1] : nil
	end
	
	# finds the first index of the object or the closest smaller one
	# if you want the closest by distance, here a sample code to achieve that:
	#   index  = array.closest(object)
	#   value1 = array.at(index)
	#   if value1 <=> object != 0 then
	#     value2 = array.at(index+1) # the next element must be bigger than object
	#     index  = (object-value2).abs > (object-value1).abs ? index : index+1
	#   end
	def closest(object)
		return nil if empty? # edgecase
		first_index(object)[1]
	end
	
	# finds the last index of the object
	def rindex(object)
		return nil if empty? # edgecase
		found = last_index(object)
		return found[0] ? found[1] : nil
	end
	
	# finds the last index of the object or the closest bigger one
	def rclosest(object)
		return nil if empty? # edgecase
		last_index(object)[1]
	end
	
	protected
	# sort_by applied to a and b
	def cmp1(a,b)
		@order*@sort.call(*(@sort_by ? [@sort_by.call(a), @sort_by.call(b)] : [a, b]))
	end
	# sort_by already used on b
	def cmp2(a,b)
		@order*@sort.call(*(@sort_by ? [@sort_by.call(a), b] : [a, b]))
	end

	# requires non-empty sortedarray
	# returns [found_equal, index]
	# if found: index is the first index in the array the value occures
	# if not found: index is the last index of the next smaller value
	# FIXME: should it return [nil, nil] if object < at(0)?
	def first_index(object, min=0, max=length-1)
		return [nil, nil] if empty?
		object, found = @sort_by ? @sort_by.call(object) : object, nil
		return [nil, max] if cmp2(at(max), object) == -1
		return [nil, nil] if cmp2(at(min), object) ==  1
		left,right = min,max
		while(left<right)
			case cmp2(at(index=left+(right-left).div(2)), object)
				when -1: left = index+1
				when  0: right = index-1; found = true
				when  1: right = index-1
				else raise "Inalid returnvalue"
			end
		end
		right = min if right < min
		case cmp2(at(index=left+(right-left).div(2)), object)
			when -1: found ? [found, index+1] : [found, index]
			when  0: [true, index]
			when  1: [found, index-1]
			else raise "Inalid returnvalue"
		end
	end
	
	# requires non-empty sortedarray
	# returns [found_equal, index]
	# if found: index is the last index in the array the value occures
	# if not found: index is the first index of the next bigger value
	# FIXME: should it return [nil, nil] if object > last?
	def last_index(object, min=0, max=length-1)
		return [nil, nil] if empty?
		object, found = @sort_by ? @sort_by.call(object) : object, nil
		return [nil, nil] if cmp2(at(max), object) == -1
		return [nil, min] if cmp2(at(min), object) ==  1
		left,right = min,max
		while(left<right)
			case cmp2(at(index=left+(right-left).div(2)), object)
				when -1: left = index+1
				when  0: left = index+1; found = true
				when  1: right = index-1
				else raise "Inalid returnvalue"
			end
		end
		left = max if left > max
		case cmp2(at(index=left+(right-left).div(2)), object)
			when -1: [found, index+1]
			when  0: [true, index]
			when  1: found ? [found, index-1] : [found, index]
			else raise "Inalid returnvalue"
		end
	end

	def binary_search(object, left=0, right=length-1)
		return nil if empty? # edgecase
		object = @sort_by ? @sort_by.call(object) : object
		until(right==(index=(right+left).div(2)))
			value = at(index)
			case cmp2(value,object)
				when 1:  right = index-1
				when -1: left  = index+1
				else return index
			end
		end
		nil
	end
	
	def resort
		if @sort_by then
			sort_array { |a,b| @order*@sort.call(@sort_by.call(a),@sort_by.call(b)) }
		else
			sort_array(&@sort)
			revert_array if @order == -1
		end
		self
	end
end

