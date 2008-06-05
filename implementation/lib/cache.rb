class Cache
	CounterItem = Struct.new(:object_id, :count, :index)
	TableItem   = Struct.new(:object, :counter)
	def initialize
		@items   = {}
		@counter = []
	end
	
	def <<(obj)
		ci = CounterItem.new(obj.object_id, 0, @counter.length)
		@items[obj.object_id] = ci
		@counter << ci
	end
	
	def access(obj)
		ci        = @items[obj.object_id]
		ci.count += 1
		index     = ci.index-1
		nci       = @counter[index]
		begin
			break if index.zero?
			
		while nci = @counter[index-=1]
	end
end
