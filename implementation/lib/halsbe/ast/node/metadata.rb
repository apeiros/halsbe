module Halsbe
	class AST
		class Node
			class MetaData < Node
				def shebang
					@nodes.first
				end
				
				def [](key)
					found = @nodes[1..-1].find { |node| node.key.node_text == key }
					found && node.value.node_text
				end
				
				def to_hash
					hash = {}
					@nodes[1..-1].each { |node| hash[node.key.node_text] = node.value.node_text }
					hash
				end
			end
		end
	end
end
