module Halsbe
	class Parser
		module Expressions
			GroupStart             = /\(/
			GroupEnd               = /\)/
			MethodChain            = //
			Assign                 = /:/
			Bareword               = /[A-Za-z_][A-Za-z0-9_]*/
			Variable               = /[$:!@]#{Bareword}/
			LocalVariable          = /\$#{Bareword}/
			BoundVariable          = /!#{Bareword}/
			InstanceVariable       = /@#{Bareword}/
			NestedVariable         = /:(?:)?#{Bareword}(?:::#{Bareword})*/
			Featurename            = /#{Bareword}|\*\*|===|==|<=>|<=|>=|[-+*\/%<=>^&|~@]/
			OptionalCallInvocation = /->/
			RequiredCallInvocation = /\./
			LabelSeparator         = /:/
			ListSeparator          = /,/

			def expression
				assignement ||
				method_chain ||
				variable ||
				literal
			end

			def literal
				primary_literal || secondary_literal
			end
		
			def expression_no_symbolic_chain
				method_chain ||       # $foo.bar.baz...
				assignement ||        # $foo: bar
				variable ||
				literal
			end
			
			def assignement
				append(:Assignement, :assignement) do
					variable &&
					optional { scan_spacing } &&
					append_scan(Assign, :Assign, nil) &&
					optional { scan_spacing } &&
					expression
				end
			end
			
			def grouped_expression
				append(:Group, :group) do
					append_scan(GroupStart, :GroupStart) &&
					expression &&
					append_scan(GroupEnd, :GroupEnd)
				end
			end
			
			def variable
				append_scan(LocalVariable, :LocalVariable, :local_variable) ||
				append_scan(BoundVariable, :BoundVariable, :bound_variable) ||
				append_scan(InstanceVariable, :InstanceVariable, :instance_variable) ||
				append_scan(NestedVariable, :NestedVariable, :namespaced_variable)
			end
			
			def method_chain
				append(:Chain, :chain) do
					optional { variable || literal }
					(
						try(1,-1) {
							optional_call ||
							required_call
						}
					)
				end
			end

			def required_call
				return false unless @scanner.check(RequiredCallInvocation)
				append(:RequiredCall, :required_call) do
					append_scan(RequiredCallInvocation, :RequiredCallInvocation, nil) &&
					append_scan(Featurename, :Featurename,  nil) &&
					optional { parenthesized_arguments || free_arguments }
				end
			end

			def optional_call
				return false unless @scanner.check(OptionalCallInvocation)
				append(:OptionalCall, :optional_call) do
					append_scan(OptionalCallInvocation, :OptionalCallInvocation, nil) &&
					append_scan(Featurename, :Featurename, nil) &&
					optional { parenthesized_arguments }
				end
			end

			def parenthesized_arguments
				append(:Arguments, :arguments) do
					append_scan(GroupStart, :OpenArguments, nil) &&
					argument_list &&
					append_scan(GroupEnd, :CloseArguments, nil)
				end
			end

			def argument_list
				scan_spacing
				if argument then
					try(0,-1) {
						append_scan(ListSeparator, :ListSeparator, nil) &&
						scan_spacing &&
						argument
					}
				else
					true
				end
			end

			def argument
				append(:Argument, :argument) do
					optional { argument_name } &&
					expression
				end
			end

			def argument_name
				append_scan(Bareword, :ArgumentName, nil) &&
				append_scan(LabelSeparator, :LabelSeparator, nil) &&
				scan_spacing
			end

			def free_arguments
				false
			end
		end
	end
end
