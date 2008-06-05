module Halsbe
	class Block

		# * ast:       Abstract Syntax Tree (Array of arrays)
		# * arguments: [[type, name, value], ...]
		#              * type:
		#                * :normal:    normal
		#                * :nodefault: normal without a default value
		#                * :args:      catch-all unnamed
		#                * :kwargs:    catch-all named
		#              * name:  argument name
		#              * value: 
		def initialize(ast, arguments=[])
			@ast             = ast
			@args            = false # name of the *args argument
			@kwargs          = false # name of the %kwargs argument
			@arguments       = arguments.freeze
			@arg_names       = []
			@arg_positions   = {}
			@local_variables = []
			@local_names     = []
			@bound_variables = []
			@bound_names     = []

			analyze_arguments
			analyze_ast
		end

		def evaluate(arguments)
			arguments = process(arguments)
		end
		
		def local_variable_by_name(name)
			@local_variables[@local_names.index(name)] # for once we sacrifice performance for memory
		end
		
		def bound_variable_by_name(name)
			@bound_variables[@bound_names.index(name)] # for once we sacrifice performance for memory
		end
		
		private
		def analyze_arguments
			nodefaults = @arguments.length
			@arguments.each_with_index { |(type, name, value), index|
				@arg_positions[name] = index
				case type
					when :normal
						nodefaults -= 1 if type == :normal
					when :nodefault
						raise "Can't have argument without default after *args/%kwargs" if @args or @kwargs
					when :args
						raise "Can't have *args after *args/%kwargs" if (@args || @kwargs)
						@args       = index
						nodefaults -= 1
					when :kwargs
						raise "Can't have %kwargs after %kwargs" if has_kwargs
						@kwargs     = index
						nodefaults -= 1
				end
			}
			@arity = @args || @kwargs ? -(nodefaults+1) : nodefaults
		end
		
		def analyze_ast
		end

		# arguments must already be expanded (e.g. *args and %kwargs passed args)
		def process(arguments)
			filled = {}
			kwargs = {}
			args   = []
			# unnamed arguments
			until arguments.first.first
				name, value, special = arguments.pop
			end
			
			# *args
			# named ar
			
			arguments.each { |name, value, special|
				if name then
					raise "named argument #{name} used twice" if kwargs[name]
					kwargs[name] = true
					if pos = @arg_positions[name] then
					elsif @kwargs then
						@
					end
				elsif !kwargs.empty? then
					raise "unnamed argument after named argument"
				else
				end
			}
		end
	end
end