module Halsbe
	module Token
		def self.new(*fields)
			str = Struct.new(:line, :off, :start, :length, *fields)
			str.class_eval {
				def data(str)
					str[start, length]
				end
			}
			str
		end
	
		Shebang          = new()
		MetaKey          = new()
		MetaValue        = new()
		MetaSeparator    = new()
		DocCommentSep    = new()
		DocComment       = new()
		SLCommentSep     = new()
		SLComment        = new()
		Whitespace       = new()
		Newline          = new()
		Assign           = new()
		Arguments        = new()
		Constant         = new()
		Identifier       = new()
		ChainMethod      = new()
		Integer          = new()
		Float            = new()
		Decimal          = new()
		Rational         = new()
		StringLiteral    = new()
	end
end