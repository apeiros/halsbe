module Halsbe
	class Parser
		MetaSep          = /\+\+\+\n/
		InlineData       = /.*/m
		EmptyLine        = /[\x20\t]*(?:\/\/.*)?\n/
		DocComment       = /[\x20\t]*---(.*)\n((?:(?![\x20\t]*---).*\n)*)[\x20\t]*---(.*)\n/
		SLComment        = /\/\/.*/
		MLCommentStart   = /\/-/
		MLCommentEnd     = /-\//
		MLCommentContent = /(?:(?!-\/|\/-).)*/
		Whitespace       = /[\t\x20]+/

		module Document
			def document
				try {
					meta_data &&
					meta_sep &&
					optional { code } &&
					optional {
						meta_sep &&
						inline_data
					}
				}
			end
			
			def meta_sep
				@line += 1 if append_scan(MetaSep, :MetaSep, nil)
			end
			
			def code
				try(0,-1) {
					empty_line ||
					doc_comment ||
					multiline_comment ||
					statement
				}
			end
			
			def empty_line
				@line += 1 if append_scan(EmptyLine, :EmptyLine, nil)
			end
			
			def doc_comment
				append_scan_with_captures(DocComment, :DocComment, 3, nil)
			end
			
			def singleline_comment
				try {
					scan_whitespace
					append_scan(SLComment, :SinglelineComment, nil)
				}
			end
			
			def multiline_comment
				try {
					scan_whitespace
					append(:MultilineComment, nil) do
						pos = @scanner.pos
						next false unless @scanner.scan(MLCommentStart)
						@doc_nesting = 1
						until @doc_nesting.zero?
							@scanner.scan(MLCommentContent)
							if @scanner.scan(MLCommentStart)
								@doc_nesting += 1
							elsif @scanner.scan(MLCommentEnd)
								@doc_nesting -= 1
							else
								raise "hu?"
							end
						end
						@doc_nesting.zero? # FIXME shouldn't it raise her if nesting is not zero?
					end
				}
			end
			
			def statement
				try(1,-1) {
					control_structure ||
					try(1,-1) {
						scan_indent &&
						expression &&
						scan_newline
					}
				}
			end
			
			def inline_data
				append_scan(InlineData, :InlineData, nil)
			end
		end
	end
end
