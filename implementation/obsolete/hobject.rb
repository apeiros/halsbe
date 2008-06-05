class HObject
	attr_reader :ivars

	def initialize(hclass)
		@hclass = hclass
		@ivars  = {}
	end
	
	def invoke(name, arguments)
		@hclass.invoke(name, self, arguments)
	end
end