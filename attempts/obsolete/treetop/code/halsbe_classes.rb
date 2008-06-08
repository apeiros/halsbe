require 'treetop'

class AST
	class Node < Array
		Tab   = "  ".freeze #"\n".freeze
		Slice = 1..-1.freeze
		alias name first
		
		attr_reader :syntax_node
		
		def initialize(syntax_node, name, *elements)
			@syntax_node = syntax_node
		end
		
		def text
			@syntax_node.text_value
		end

		def inspect
			indented_inspect.chop
		end
		
		def rest
			self[Slice]
		end
		
		def indented_inspect(indent=0)
			ind = Tab*indent
			"#{ind}[#{name.inspect},\n#{rest.map { |node| node.indented_inspect(indent+1).join("\n,")}\n#{ind}],"
		end
	end

	attr_reader :process
	def initialize
		@root    = Node.new
		@process = @root
	end
	
	def <<(node)
		@process << node
	end
end

class Treetop::Runtime::SyntaxNode
	def generate_ast(@ast)
	end
end

class Document < Treetop::Runtime::SyntaxNode
	def meta_data
		nil
	end
	
	def code
		nil
	end
	
	def inline_data
		""
	end

	def tokenized
		meta_data.tokenized + code.tokenized
	end

	def ast
		code.ast if code
	end
end

class MetaData < Treetop::Runtime::SyntaxNode
	def shebang
		nil
	end

	def tokenized
		tokens = []
		tokens << "Shebang: #{shebang.text_value.inspect}" if shebang
		meta_tuple.elements.each { |e|
			tokens.push(
				"MetaKey: #{e.meta_key.text_value.inspect}",
				'Text: ": "',
				"MetaValue: #{e.meta_value.text_value.inspect}"
			)
		} if meta_tuple
		tokens
	end

	def to_hash
		data = {}
		meta_tuple.elements.each { |e|
			data[e.meta_key.text_value] = e.meta_value.text_value
		}
		data
	end
end

class Code < Treetop::Runtime::SyntaxNode
	def initialize(*a)
		super
		@ast = AST.new
		elements.map { |e| e.generate_ast(@ast) }
	end

	def tokenized
		[]
	end
end

class EmptyLine < Treetop::Runtime::SyntaxNode
end

class Whitespace < Treetop::Runtime::SyntaxNode
end

class DocComment < Treetop::Runtime::SyntaxNode
	def comment_text
		comment_text_nodes.text_value.chomp
	end
	
	def generate_ast(ast)
		ast << AST::Node.new(self, :doc_comment, comment_text)
	end
end

class Chain < Treetop::Runtime::SyntaxNode
	def generate_ast(ast)
		ast << AST::Node.new(self, :chain)
		elements.each { |e| e.generate_ast(ast.last) }
	end
end

class Value < Treetop::Runtime::SyntaxNode
end

class Statement < Treetop::Runtime::SyntaxNode
	def expressions
	end

	def generate_ast(ast)
		ast << AST::Node.new(self, :statement)
		elements.each { |e| e.generate_ast(ast.last) }]
	end
end

class Argument < Treetop::Runtime::SyntaxNode
end

class ArgumentList < Treetop::Runtime::SyntaxNode
	def ast
		[:required_call, receiver.ast, call.methodname.ast, [:arguments]]
	end
end

class RequiredCall < Treetop::Runtime::SyntaxNode
	def ast
		[:required_call, methodname.ast, [:arguments]]
	end
end

class OptionalCall < Treetop::Runtime::SyntaxNode
	def ast
		[:optional_call, methodname.ast, [:arguments]]
	end
end

class Bareword < Treetop::Runtime::SyntaxNode
	def ast
		[:bareword, text_value]
	end
end

class Constant < Treetop::Runtime::SyntaxNode
	def ast
		[:constant, text_value[1..-1]]
	end
end


class InstanceVariable < Treetop::Runtime::SyntaxNode
end

class LocalVariable < Treetop::Runtime::SyntaxNode
end

class BoundVariable < Treetop::Runtime::SyntaxNode
end

class SecondaryLiteral < Treetop::Runtime::SyntaxNode
	attr_reader :value

	def initialize(*args)
		super
		@value = data
	end
	
	def data
		nil
	end
	
	def type
		nil
	end

	def generate_ast
		[:value, text_value]
	end
end
