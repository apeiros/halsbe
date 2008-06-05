module Halsbe
	class AST
		class Node
			class DocComment < Node
				attr_reader :pre, :text, :post
				def initialize(string, offset, length, processor, pre, text, post)
					super(string, offset, length, processor)
					@pre  = pre
					@text = text
					@post = post
				end
			end
		end
	end
end
