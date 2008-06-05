class Array
	def pretty(n)
		idt = "  "*n
		"#{idt}[\n"+map { |e| e.pretty(n+1) }.join(",\n")+"\n#{idt}]"
	end
end

module Halsbe
	class AST
		class Node

			attr_reader :processor
			attr_reader :string
			attr_reader :offset
			attr_reader :length
			attr_reader :nodes

			def initialize(string, offset, length, processor)
				@processor = processor
				@string    = string
				@offset    = offset
				@length    = length
				@nodes     = []
			end
			
			# sets the @length of the Node to at_pos-@offset
			def terminate(at_pos)
				@length = at_pos - @offset
			end
			
			# append a node
			def <<(node)
				@nodes << node
			end
			
			# example (removes noop-nodes from the tree):
			#   node.reject! { |node| node.processor.nil? }
			def reject!(&block)
				@nodes.reject!(&block)
				@nodes.each { |node| node.reject!(&block) }
				self
			end
			
			def node_text
				@string[@offset, length]
			end
			
			def inspect
				txt = node_text
				txt[5..-6] = "..." if txt.length > 15
				cls = self.class.name[/[^:]*$/]
				"<#{cls}(#{@offset},#{@length}) #{txt.inspect}>"
			end
			
			def pretty(indent=0)
				idt = "  "*indent
				if @nodes.empty? then
					idt+inspect
				else
					txt = node_text
					txt[5..-6] = "..." if txt.length > 15
					cls = self.class.name[/[^:]*$/]
					"#{idt}<#{cls}(#{@offset},#{@length}) #{txt.inspect}\n" \
					"#{@nodes.map{|node|node.pretty(indent+1)}.join(",\n")}\n#{idt}>"
				end
			end
		end
	end
end

Dir.glob(File.dirname(File.expand_path(__FILE__))+"/node/*.rb") { |file|
	require "halsbe/ast/node/#{File.basename(file)}"
}

__END__

"literal", value
"variable_local", identifier
"variable_bound", identifier, ?
"variable_instance", identifier, object_id
"variable_namespaced", identifier, ?
"begin", body_statements, rescue_statements, else_statements, ensure_statements
"raise", exception_class, [*expressions]
"statement", [*expressions] # value is the value of the last expression executed
"conditional", [*conditions]
	"if", condition, statement
	"unless", condition, statement
"while", condition, statement, else_statement
"until", condition, statement, else_statement
"once_while", condition, statement
"once_until", condition, statement
"maxfor", destlist, sourcelist, statement, else_statement
"minfor", destlist, sourcelist, statement, else_statement
