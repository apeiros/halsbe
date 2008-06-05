module Halsbe
	class AST
		class Node
			class MetaDataPair < Node
				def key
					@nodes.first.node_text
				end
				
				def value
					@nodes.last.node_text
				end
			end
		end
	end
end
