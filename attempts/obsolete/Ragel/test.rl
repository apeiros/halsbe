%%{
	machine halsbe;

	alphtype int;

	variable p    @pos;
	variable pe   @pe;
	variable cs   @cs;
	variable eof  @eof;
	variable data @data;

	action test {
		@mark.test = @pos
		puts "Test at #{position}"
	}
	action testa {
		puts "Test A at #{position}"
	}
	action testb {
		puts "Test B at #{position}"
	}
	action testc {
		puts "Test C at #{position}"
	}
	action test2 {
		puts "Test, #{@data[@mark.test...@pos]}"
	}
	
	action newline_notok {
		@line += 1
		@off   = @pos+1
	}
	action newline {
		secure(:newline) {
			@tokens << Token::Newline.new(
				@line,
				char,
				@pos,
				1
			)
		}
		@line += 1
		@off   = @pos+1
	}
	action shebang_start {
		@mark.shebang = @pos
	}
	action shebang_end {
		secure(:shebang) {
			start    = @mark.shebang
			length   = @pos-start
			@shebang = @data[start, length]
			@tokens << Token::Shebang.new(
				@line,
				char,
				start,
				length
			)
		}
	}
	action meta_key_start {
		@mark.meta_key = @pos
	}
	action meta_key_end {
		secure(:meta_key) {
			start     = @mark.meta_key
			length    = @pos-start
			@meta_key = @data[start, length]
			@tokens << Token::MetaKey.new(
				@line,
				char,
				start,
				length
			)
		}
	}
	action meta_value_start {
		@mark.meta_value = @pos
	}
	action meta_value_end {
		secure(:meta_value) {
			start  = @mark.meta_value
			length = @pos-start
			@meta[@meta_key] = @data[start, length]
			@tokens << Token::MetaValue.new(
				@line,
				char,
				start,
				length
			)
		}
	}
	action meta_separator_end {
		secure(:meta_separator) {
			@tokens << Token::MetaSeparator.new(
				@line,
				char,
				@pos-3,
				3
			)
		}
	}

	action doc_comment_sep_end {
		secure(:doc_comment_sep) {
			@tokens << Token::DocCommentSep.new(
				@line,
				char,
				@pos-3,
				3
			)
		}
	}
	action doc_comment_start {
		@mark.doc_comment = @pos
	}
	action doc_comment_end {
		secure(:doc_comment) {
			start  = @mark.doc_comment
			length = @pos-start
			@tokens << Token::DocComment.new(
				@line,
				char,
				start,
				length
			)
		}
	}


	action sl_comment_sep {
		secure(:sl_comment_sep) {
			@tokens << Token::SLCommentSep.new(
				@line,
				char,
				@pos-2,
				2
			)
		}
	}
	action sl_comment_start {
		@mark.sl_comment = @pos
	}
	action sl_comment_end {
		secure(:sl_comment) {
			start  = @mark.sl_comment
			length = @pos-start
			@tokens << Token::SLComment.new(
				@line,
				char,
				start,
				length
			)
		}
	}


	action whitespace_start {
		@mark.whitespace = @pos
	}
	action whitespace_end {
		secure(:whitespace) {
			@tokens << Token::Whitespace.new(
				@line,
				char,
				@mark.whitespace,
				@pos-@mark.whitespace
			) if @mark.whitespace
			@mark.whitespace = nil
		}
	}

	action assign_end {
		secure(:assign) {
			@tokens << Token::Assign.new(
				@line,
				char,
				@pos-1,
				1
			)
		}
	}


	action identifier_start {
		@mark.identifier ||= @pos
	}
	action identifier_abort {
		@mark.identifier = nil
	}
	action identifier_end {
		secure(:identifier) {
			@tokens << Token::Identifier.new(
				@line,
				char,
				@mark.identifier,
				@pos-@mark.identifier
			)
		}
	}

	action literal_start {
		@mark.literal = @pos
	}
	action string_literal_end {
		secure(:string_literal) {
			start = @mark.literal
			@tokens << Token::StringLiteral.new(
				@line,
				char,
				start,
				length = @pos-start
			)
			@stack.last << Literal.new(HString.new(@data[start+2, length-3]))
		}
	}
	action integer_end {
		secure(:integer) {
			start = @mark.literal
			@tokens << Token::Integer.new(
				@line,
				char,
				start,
				length = @pos-start
			)
			@stack.last << [:integer, @data[start, length]]
		}
	}
	action float_end {
		secure(:float) {
			start = @mark.literal
			@tokens << Token::Float.new(
				@line,
				char,
				start,
				length = @pos-start
			)
			@stack.last << [:float, @data[start, length]]
		}
	}
	action rational_end {
		secure(:rational) {
			start = @mark.literal
			@tokens << Token::Rational.new(
				@line,
				char,
				start,
				length = @pos-start
			)
			@stack.last << [:rational, @data[start, length]]
		}
	}
	action complex_end {
		secure(:complex) {
			start = @mark.literal
			@tokens << Token::Complex.new(
				@line,
				char,
				start,
				length = @pos-start
			)
			@stack.last << [:complex, @data[start, length]]
		}
	}
	action decimal_end {
		secure(:decimal) {
			start = @mark.literal
			@tokens << Token::Decimal.new(
				@line,
				char,
				start,
				length = @pos-start
			)
			@stack.last << [:decimal, @data[start, length]]
		}
	}


	action constant_start {
		@mark.constant = @pos
	}
	action constant_end {
		secure(:constant) {
			@tokens << Token::Constant.new(
				@line,
				char,
				@mark.constant,
				length = @pos-@mark.constant
			)
			@stack.last << [:constant, @data[@mark.constant, length]]
		}
	}
	action chain_method_start {
		@tokens << Token::ChainMethod.new(
			@line,
			char,
			@pos,
			1
		)
	}

	action unnamed_argument_value {
		@stack.last << [nil, @stack.last.pop]
	}
	action named_argument_name {
		@stack.last << [@data[@pos, length]]
		@stack << []
	}
	action named_argument_value {
		@stack.last << @stack.pop
		@stack.pop
	}
	action arguments_abort {
		#puts "abort arguments #{position}"
	}
	action arguments_end {
		secure(:identifier) {
			@tokens << Token::Arguments.new(
				@line,
				char,
				@mark.arguments,
				@pos-@mark.arguments
			)
		}
	}
	
	action method_call_create {
		@stack.last << [:call, @stack.last.pop, nil, []]
		@stack << @stack.last.last
	}
	action method_call_name {
		@stack.last[2] = last_token_data.to_sym
		@stack << @stack.last.last # arguments on top of the stack
	}
	action method_call_arguments_end {
		@stack.pop
	}
	action method_call_end {
		@stack.pop
	}

	action negative {
		@mark.negative = true
	}
	action numeric_clear {
		@mark.negative = nil
	}
	action assign_to {
		@stack.last << [:assign, last_token_data]
		@stack << @stack.last.last
	}
	action assign_done {
		@stack.pop
	}
	
	newline           = "\n" @newline;
	newline_notok     = "\n" @newline_notok;
	align_notok       = " "*;
	align             = align_notok >whitespace_start %whitespace_end;
	indent_notok      = "\t"*;
	indent            = indent_notok >whitespace_start %whitespace_end;
	wsep              = " "+ >whitespace_start %whitespace_end;
	list_sep          = "," align;
	empty_line        = align newline;
	
	eol               = align
	                    (
	                      "//" %sl_comment_sep
	                      (extend-"\n")* >sl_comment_start %sl_comment_end
	                    )?
	                    newline;

	chain_method      = "." >chain_method_start;
	identifier        = ([a-z_] [A-Za-z0-9_]*) >identifier_start %identifier_end $^identifier_abort;
	constant_ident    = [A-Z] [A-Za-z0-9_]*;
	constant_sep      = "::";
	constant          = (
	                      constant_sep?
	                      constant_ident
	                      (
	                        constant_sep
	                        constant_ident
	                      )*
	                    ) >constant_start %constant_end;

	shebang               = ("#!" [^\n]*) >shebang_start %shebang_end newline;
	meta_key              = ([A-Za-z0-9_]+) >meta_key_start %meta_key_end;
	meta_value            = ([^\n]*) >meta_value_start %meta_value_end newline;
	meta_tuple            = meta_key ":" %assign_end align <: meta_value;
	meta_separator        = "+++" %meta_separator_end newline;

	meta                  = shebang? meta_tuple*;
	embedded_data         = extend*;

	doc_comment_sep       = "---" %doc_comment_sep_end;
	doc_comment           = indent
	                        doc_comment_sep %doc_comment_start
	                        newline_notok
	                        extend*
	                        :>> (
	                          newline_notok %doc_comment_end
	                          indent
	                          doc_comment_sep
	                          eol
	                        );

	string_literal        = ("%'" ((any - "'") | newline_notok)* "'");
	secondary             = string_literal %string_literal_end;

	sign                  = ("+" | "-" @negative);
	date                  = digit{4} "-" digit{2} "-" digit{2};
	time                  = digit{2} ":" digit{2} ":" digit{2} ("." digit+)? (sign digit{4})?;
	datetime              = date | time | date "T" time;
	natural               = ([1-9] digit*); # natural numbers without 0
	uinteger10            = "0" | natural; # whole positive numbers, with 0
	integer10             = sign? uinteger10; # whole numbers, pos & neg, with 0
	integer2              = sign? "0b" [01]+;
	integer8              = sign? "0" [0-7]+;
	integer16             = sign? "0x" xdigit+;
	integer               = integer2 | integer8 | integer10 | integer16;
	decimal               = integer10 "." digit+;
	float                 = (decimal | integer10) [Ee] integer10;
	rational              = integer "/" integer;
	imaginary             = (integer | rational | float | decimal) [IiJj];
	complex               = (integer | rational | float | decimal) sign imaginary;
	numeric_simple        = integer  %integer_end |
	                        decimal  %decimal_end |
	                        float    %float_end;
	numeric_compound      = rational %rational_end |
	                        complex  %complex_end;
	numeric               = numeric_simple |
	                        numeric_compound;
	scalar                = numeric | datetime;
	primary               = scalar %numeric_clear;
	literal               = primary | secondary;

	value                 = literal >literal_start;
	unnamed_argument      = value %unnamed_argument_value;
	named_argument        = identifier %named_argument_name ":" wsep value %named_argument_value;
	single_arg            = named_argument | unnamed_argument;
	free_args             = (single_arg (list_sep single_arg)*)?;
	paren_args            = "(" free_args ")";
	arguments             = (paren_args | (wsep free_args)) $^arguments_abort;
	method_call           = (
	                      constant     # %method_call_receiver
	                      chain_method %method_call_create
	                      identifier   %method_call_name
	                      arguments?   %method_call_arguments_end
	                    ) %method_call_end;

	assignement           = identifier %assign_to ":" %assign_end align value %assign_done;

	statement             = align (assignement | method_call) <: eol;

	#code                  = 
	#document              = meta meta_separator code; # (meta_separator embedded_data)?


	
	main:= (
		start: (
			meta meta_separator -> code
		),
		code: (
			empty_line                         -> code |
			statement                          -> code |
			doc_comment                        -> code
		)
	);
}%%

require 'ostructfixed'
require 'halsbe/tokens'
require 'pp'

module Kernel
	def secure(area)
		yield
	rescue Exception => e
		puts area, e, *e.backtrace
	end
end

module Halsbe
	class Parser
		def self.parse_file(path)
			path = File.expand_path(path)
			parser = new
			parser.parse(File.read(path), path)
			parser
		end
		
		attr_reader :ast
		attr_reader :tokens
		attr_reader :data
		attr_reader :file
		
		def initialize
		%% write data;
	
			@pos = 0
			@cs  = halsbe_start
		end
	
		def parse(data, file='(eval)', line=1)
			@meta    = {}
			@shebang = nil
		
			@data   = data
			@pos    = 0
			@off    = 0
			@pe     = data.length
			@eof    = data.length
			@line   = line
			@mark   = OpenStruct.new
			@file   = file
			@tokens = []
			@ast    = [Block.new([], [])]
			@stack  = [@ast.last.statements]
		
			%% write exec;
		end
		
		def reset
			@mark = OpenStruct.new
		end
		
		def char
			@pos-@off
		end
		
		def last_token_data(n=nil)
			n ? @tokens[-n].data(@data) : @tokens.last.data(@data)
		end
		
		def position
			"#{File.basename(@file)}:#{@line}:#{@pos-@off}"
		end
	end
end
