%%{
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

	shebang           = ("#!" [^\n]*) >shebang_start %shebang_end newline;
	meta_key          = ([A-Za-z0-9_]+) >meta_key_start %meta_key_end;
	meta_value        = ([^\n]*) >meta_value_start %meta_value_end newline;
	meta_tuple        = meta_key ":" %assign_end align <: meta_value;
	meta_separator    = "+++" %meta_separator_end newline;

	meta              = shebang? meta_tuple*;
	embedded_data     = extend*;
}%%
