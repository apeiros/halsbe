module Halsbe
	class Parser
		module CodeLiterals
			CurlyOpen  = /{/
			CurlyClose = /}/
		
			def code_literal
				append(:CodeLiteral, :code_literal) do
					code_curly_braces ||
					code_indented_block
				end
			end
			
			def code_curly_braces
				append_scan(CurlyOpen, :CodeLiteralStart, nil) &&
				scan_spacing &&
				optional {
					scan_newline &&
				}
				
				append_scan(SecondaryLiteralType, :SecondaryLiteralType, nil) &&
				optional { parenthesized_arguments } && # from expressions.rb
				append_scan(SecondaryLiteralData, :SecondaryLiteralData, nil)
			end
			
			def code_indented_block
			end
		end
	end
end
