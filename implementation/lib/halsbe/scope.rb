class Scope < Array
	def initialize(names)
		super(names.length)
		self.replace(names)
		@names     = {}
		(0...length).zip(self) { |v,k| @names[k] = v }
	end
	
	def 
	
	def index_of(name)
		@names[name]
	end
	
	def value_of(name)
		at(@names[name])
	end
	
	def name_of(index)
		@names.index(index)
	end
end
