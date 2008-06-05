module Halsbe
	class Parser
		module ControlStructures
			If           = /if/
			Unless       = /unless/
			Else         = /else/
			ElseIf       = /else #{If}/
			ElseUnless   = /else #{Unless}/
			Case         = /case/
			When         = /when/
			While        = /while/
			Until        = /until/
			OnceWhile    = /once_while/
			OnceUntil    = /once_until/
			Do           = /do/
			Rescue       = /rescue/
			Ensure       = /ensure/
			BlockFollows = /:/
	
			def control_structure
				try {
					if_unless_statement ||
					loop_statement ||
					case_statement ||
					do_statement
				}
			end
			
			def block_follows
				append_scan(BlockFollows, :BlockFollows, nil)
			end
			
			def if_unless_statement
				append(:Conditional, :conditional) do
					# initial if/unless statement
					success = (
						if @scanner.check(If) then
							append(:If, :if) do
								scan_indent &&
								append_scan(If, :IfKeyword, nil) &&
								scan_spacing &&
								expression &&
								block_follows &&
								block
							end
						elsif @scanner.check(Unless) then
							append(:Unless, :unless) do
								scan_indent &&
								append_scan(Unless, :UnlessKeyword, nil) &&
								scan_spacing &&
								expression &&
								block_follows &&
								block
							end
						else
							false
						end
					)
					next false unless success
					
					# optional "else if"/"else unless" statement
					try(0,-1) {
						if @scanner.check(ElseIf) then
							append(:If, :if) do
								scan_indent &&
								append_scan(Else, :ElseKeyword, nil) &&
								scan_spacing &&
								append_scan(If, :IfKeyword, nil) &&
								scan_spacing &&
								expression &&
								block_follows &&
								block
							end
						elsif @scanner.check(ElseUnless) then
							append(:Unless, :unless) do
								scan_indent &&
								append_scan(Else, :ElseKeyword, nil) &&
								scan_spacing &&
								append_scan(Unless, :UnlessKeyword, nil) &&
								scan_spacing &&
								expression &&
								block_follows &&
								block
							end
						end
					}

					# optional else statement
					if @scanner.check(Else) then
						append(:Else, :else) do
							scan_indent &&
							append_scan(Else, :ElseKeyword, nil) &&
							block_follows &&
							block
						end
					end
					true
				end
			end
			
			def loop_statement
				try {
					while_statement ||
					until_statement ||
					once_while_statement ||
					once_until_statement
				}
			end
			
			def while_statement
				append(:While, :while) do
					scan_indent &&
					append_scan(While, :WhileKeyword, nil) &&
					scan_spacing &&
					expression &&
					block_follows &&
					block
				end
			end

			def until_statement
				append(:Until, :until) do
					scan_indent &&
					append_scan(Until, :UntilKeyword, nil) &&
					scan_spacing &&
					expression &&
					block_follows &&
					block
				end
			end

			def once_while_statement
				append(:OnceWhile, :once_while) do
					append_scan(OnceWhile, :OnceWhileKeyword, nil) &&
					scan_spacing &&
					expression &&
					block_follows &&
					block
				end
			end

			def once_until_statement
				append(:OnceUntil, :once_until) do
					append_scan(OnceUntil, :OnceUntilKeyword, nil) &&
					scan_spacing &&
					expression &&
					block_follows &&
					block
				end
			end
			
			def case_statement
				append(:Case, :case) do
					scan_indent &&
					append_scan(Case, :CaseKeyword, nil) &&
					scan_spacing &&
					expression &&
					increment_indent &&
					scan_newline &&
					try(0,-1) {
						when_statement
					} &&
					optional {
						case_default_statement
					} &&
					decrement_indent
				end
			end
			
			def when_statement
				scan_indent &&
				append_scan(When, :WhenKeyword, nil) &&
				scan_spacing &&
				expression &&
				block_follows &&
				block
			end

			def case_default_statement
				scan_indent &&
				append_scan(Else, :ElseKeyword, nil) &&
				block_follows &&
				block
			end
			
			def do_statement
				append(:Do, :do) do
					scan_indent &&
					append_scan(Do, :DoKeyword, nil) &&
					block &&
					optional { rescue_statement } &&
					optional { do_else_statement } &&
					optional { ensure_statement }
				end
			end
			
			def rescue_statement
				append(:Rescue, :rescue) do
					scan_indent &&
					append_scan(Rescue, :RescueKeyword, nil) &&
					block
				end
			end

			def do_else_statement
				append(:DoElse, :do_else) do
					scan_indent &&
					append_scan(Else, :ElseKeyword, nil) &&
					block
				end
			end

			def ensure_statement
				append(:Ensure, :ensure) do
					scan_indent &&
					append_scan(Ensure, :EnsureKeyword, nil) &&
					block
				end
			end
			
			def block
				append(:Block, :block) do
					scan_newline
					increment_indent
					code
					decrement_indent
				end
			end
		end
	end
end
