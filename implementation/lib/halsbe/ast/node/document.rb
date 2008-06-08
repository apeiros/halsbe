module Halsbe
	class AST
		class Node
			class Document < Node
				def metadata
					@nodes.first
				end
				
				def code
					@nodes.at(1)
				end
				
				def inline_data
					@nodes.last
				end
			end
		end
	end
end
