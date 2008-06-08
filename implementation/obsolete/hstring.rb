class HString < RubyHClass
	h_instance_method(:printable, []) do |hself|
		hself
	end
	
	attr_reader :string

	def initialize(string)
		@string = string
	end
end
