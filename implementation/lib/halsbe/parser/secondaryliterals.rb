module Halsbe
	class Parser
		module SecondaryLiterals
			SecondaryLiteralPrefix    = /%/
			SecondaryLiteralType      = /[A-Za-z_][A-Za-z0-9_]*/
			SecondaryLiteralData      = /
			                              \{(?:[^\\\}]|\\.)*\} |
			                              \((?:[^\\\)]|\\.)*\) |
			                              \[(?:[^\\\]]|\\.)*\] |
			                              \<(?:[^\\\>]|\\.)*\> |
			                              \#(?:[^\\\#]|\\.)*\# |
			                              \"(?:[^\\\"]|\\.)*\" |
			                              \'(?:[^\\\']|\\.)*\' |
			                              \`(?:[^\\\`]|\\.)*\` |
			                              \/(?:[^\\\/]|\\.)*\/
			                            /x
		
			def secondary_literal
				append(:SecondaryLiteral, :secondary_literal) do
					append_scan(SecondaryLiteralPrefix, :SecondaryLiteralPrefix, nil) &&
					append_scan(SecondaryLiteralType, :SecondaryLiteralType, nil) &&
					optional { parenthesized_arguments } && # from expressions.rb
					append_scan(SecondaryLiteralData, :SecondaryLiteralData, nil)
				end
			end
		end
	end
end
