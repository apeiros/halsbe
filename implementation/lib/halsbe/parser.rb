require 'strscan'
require 'halsbe/ast/node'
require 'halsbe/parser/controlstructures'
require 'halsbe/parser/document'
require 'halsbe/parser/expressions'
require 'halsbe/parser/metadata'
require 'halsbe/parser/primaryliterals'
require 'halsbe/parser/secondaryliterals'

class Object
	def i(label=nil)
		if label then
			p([label, block_given? ? yield(self) : self])
		else
			p(block_given? ? yield(self) : self)
		end
		self
	end
end

module Halsbe
	class Parser
		class Incomplete < RuntimeError; end

		Infinity = 1/0.0

		include ControlStructures
		include Document
		include Expressions
		include MetaData
		include PrimaryLiterals
		include SecondaryLiterals
		
		attr_accessor :root
		attr_reader :scanner
		
		def self.file(path)
			new(File.read(path), path)
		end
		
		def initialize(string, file=nil)
			@verbose     = false
			@file        = (file || "(eval)").freeze
			@string      = string.freeze
			@scanner     = StringScanner.new(@string)
			@line        = 1
			@doc_nesting = 0 # for /- ... -/ multiline docs
			@indent      = [0] # for indent awareness
			@root        = AST::Node::Document.new(@string, 0, @string.length, nil)
			@current     = @root
			@try         = []
			@try_current = [@root]
		end
		
		def out(*args)
			p args
			true
		end
		
		def out_scanner(chars=20, *args)
			if args.empty? then
				p @scanner.rest[0,chars]
			else
				p [@scanner.rest[0,chars], *args]
			end
			true
		end
		
		def verbose
			old_verbose = @verbose
			@verbose    = true
			yield
		ensure
			@verbose = old_verbose
		end
		
		def parse
			document
			raise Incomplete unless @scanner.eos?
		end

		
		# allows you to try a series of scans and node-tree manipulations,
		# will revert if failed. Your block must a conditionally false value
		# if the status should be reverted
		# example:
		#   try {
		#     @scanner.scan(/foo/) &&
		#     @scanner.scan(/bar/)
		#   }
		def try(min=1, max=nil)
			overall   = true
			min     ||= 1
			max     ||= 1
			max       = Infinity if max < 0
			i         = 0
			while i < max
				pos           = @scanner.pos
				@try_current << []
				@try         << @try_current.last
				@indent      << @indent.last
				success       = yield
				result        = @try.pop
				@try_current.pop
		
				if success then
					result.each { |node| append_node(node) }
					@indent[-1] = @indent.pop
				else
					@scanner.pos = pos
					@indent.pop
					break
				end
	
				i += 1
			end
			i < min ? false : overall
		end
		
		def optional(&block)
			try(0,1,&block)
		end
		
		def scan_newline
			singleline_comment
			return true if @scanner.eos?
			@line += 1 if append_scan(/\n/, :Newline, nil)
		end
		
		# scans *only* spaces, appends them as Spacing node
		def scan_spacing
			append_scan(/\x20+/, :Spacing, nil)
		end
		
		# scans tabs and spaces, appends them as Spacing node
		def scan_whitespace
			append_scan(/[\t\x20]+/, :Spacing, nil)
		end
		
		# increments the required indent, always returns a conditionally true value
		def increment_indent
			@indent[-1] += 1
		end
		
		# decrements the required indent, always returns a conditionally true value
		def decrement_indent
			@indent[-1] -= 1
		end

		def scan_indent
			pos = @scanner.pos
			if indent = @scanner.scan(/\t{#{@indent.last}}(?!\t)/)
				node = AST::Node::Indent.new(@string, pos, indent.size, nil)
			end
		end
		
		def append_node(node)
			@try_current.last << node
		end
		
		def append(node, *args)
			try {
				node = AST::Node.const_get(node).new(@string, @scanner.pos, nil, *args)
				append_node node
				set_current node
				if yield then
					node.terminate(@scanner.pos)
					true
				else
					false
				end
			}
		end
		
		def append_scan(pattern, node, *args)
			pos = @scanner.pos
			p [@scanner.rest[0,20], node, pattern] if @verbose
			if text = @scanner.scan(pattern) then
				append_node(AST::Node.const_get(node).new(@string, pos, text.length, *args))
				true
			else
				false
			end
		rescue => e
			puts "Experiencing problems appending node #{node}"
			raise
		end
		
		def append_scan_with_captures(pattern, node, num_matches, *args)
			pos = @scanner.pos
			if text = @scanner.scan(pattern) then
				captures = (1..num_matches).map { |i| @scanner[i] } # no StringScanner#captures =(
				append_node(AST::Node.const_get(node).new(@string, pos, text.length, *(args+captures)))
				true
			else
				false
			end
		end
		
		def current
			@try_current.last
		end

		# set the current node
		# the current node is the node append_node operates on
		def current=(node)
			@try_current[-1] = node
		end
		alias set_current current=
		
		def pretty
			@root.pretty
		end
	end
end
