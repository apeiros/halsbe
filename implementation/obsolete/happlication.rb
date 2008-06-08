class HApplication < RubyHClass
	h_instance_method(:print_line, [[:str, HString.new("")]]) do |hself, argument|
		#puts *arguments.map { |arg| arg.invoke(:printable, []).string }
		puts argument.invoke(:printable, []).string
	end

	h_instance_method(:get_line, []) do |hself|
		HString.new(gets)
	end
end
