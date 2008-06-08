class MinHeap
	attr_reader :heap

	def initialize(size)
		@heap    = [nil]
	end
	
	def pop
		value         = @heap.at(1)
		index         = 1
		child_index   = nil
		child_index_a = 2
		child_index_b = 3
		child_a       = @heap.at(child_index_a)
		child_b       = @heap.at(child_index_b)
		while child_a or child_b
			if child_a then
				if child_b then
					if child_a < child_b then # switch a with parent (== index)
					else
					end
				else # only child_a
				end
			else # only child_b
			end
			child_a       = @heap.at(child_index_a)
			child_b       = @heap.at(child_index_b)
			child_index_a = child_index
			child_index_b = child_index_a+1
		end
	end
	
	def insert(*values)
		values.each { |value| self << value }
	end
	
	def <<(value)
		index  = @heap.size
		parent = index >> 1
		parval = @heap.at(parent)
		@heap << value
		until parent.zero? or parval <= value
			@heap[parent] = value
			@heap[index]  = parval
			index  = parent
			parent = parent >> 1
			parval = @heap.at(parent)
		end
		self
	end
	
	def parent(index)
		@heap.at(index >> 1)
	end
	
	def children(index)
		@heap[index << 1, 2]
	end

	def parent_index(own_index)
		own_index >> 1
	end
	
	def child_indices(index)
		a = index << 1
		[a, a+1]
	end
end
