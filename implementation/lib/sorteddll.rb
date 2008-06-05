# Sorted Double Linked List
class DLL
	Node = Struct.new(:before, :after, :value)
	MinNode = Struct.new(:before, :after, :value)
	MaxNode = Struct.new(:before, :after, :value)

	class MinNode
		def value=(val)
			oldval = value()
			if oldval > val then
				after = after()
				while after and after < val
					after.before = before()
					self.after   = after.after
					after.after  = self
					self.before  = after
				end
			elsif oldval < val then
				before = before()
				while before and before > val
					before.after  = after()
					self.before   = before.before
					before.before = self
					self.after    = before
				end
			end
			super(val)
		end
	end

	attr_reader :first_node
	attr_reader :last_node

	def initialize(node=Node)
		@first_node = nil
		@last_node  = nil
		@node       = node
	end
	
	def push(*values)
		case values.length
			when 0 # nothing happens
			when 1
				self << values.first
			else
				curr = @node.new(@last_node, nil, values.shift)
				node = nil
				if @last_node then
					@last_node.after = curr
				else
					@first_node = curr
				end
				for value in values
					node = @node.new(curr, nil, value)
					curr.after = node
					curr = node
				end
				@last_node = node
		end
		self
	end
	
	def <<(value)
		node = @node.new(@last_node, nil, value)
		if @last_node then
			@last_node.after = node
			@last_node = node
		else
			@first_node = @last_node = node
		end
		self
	end

	def pop
		return nil unless @last_node
		node  = @last_node
		@last_node = @last_node.before
		@last_node.after = nil
		node.value
	end
	
	def shift
		return nil unless @first_node
		node  = @first_node
		@first_node = @first_node.after
		@first_node.before = nil
		node.value
	end
	
	def each
		return self unless node = @first_node
		begin
			yield node.value
		end while node = node.after
		self
	end
	
	def join(sep=$\)
		return "" unless curr = @first_node
		out = "#{curr.value}"
		out << "#{sep}#{curr.value}" while curr = curr.after
		out
	end

	def inspect
		"#<%s [%s]>" %  [self.class, join(", ")]
	end
end
