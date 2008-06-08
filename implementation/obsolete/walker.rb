require 'halsbe/rubyhclass'
require 'halsbe/rubyhmethod'
require 'halsbe/literals'
require 'halsbe/core'


module Halsbe
	class Walker
		def initialize(ast, constants)
			@ast       = ast
			@constants = constants
		end
		
		def run
			evaluate(0, *@ast)
		end
		
		def evaluate(level, frame)
			case frame
				when nil
					nil
				when Frames::Block
					frame.statements.each { |statement|
						evaluate(level+1, statement)
					}
				when Frames::Call
					receiver, method, arguments = *args
					evaluate(level+1, frame.receiver).invoke(frame.method_name, frame.arguments.map { |name, arg|
						[evaluate(level+1, name), evaluate(level+1, arg)]
					})
				when Frames::Literal
					frame.data
				when Frames::Constant
					@constants[frame.name]
				else
					raise "Unkown op #{op}"
			end
		end
	end
end

if __FILE__ == $0
	hello_world_ast = [:statement,
 [[:call,
   [:constant, "Application"],
   :print_line,
   [[nil, [:string_literal, "Hello World"]]]]]]
	Halsbe::Walker.new(hello_world_ast, Halsbe::Core).run
end
