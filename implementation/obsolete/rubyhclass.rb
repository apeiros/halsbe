class RubyHClass
	class <<self
		def inherited(by)
			by.initialize_class
		end

		def initialize_class
			@instance_methods   = {}
			@instance_variables = {}
		end

		# See RubyHMethod for info
		def h_instance_method(name, args, &body)
			@instance_methods[name] = RubyHMethod.new(name, args, &body)
		end
		
		# name is a Symbol, args an array of the form: [[argname, argvalue], ...]
		# if an argument is positional, the argname should be nil
		def invoke_instance_method(hself, name, args)
			@instance_methods[name].call(hself, args)
		rescue ArgumentError => e
			raise "Failed to call #{name} on #{hself.inspect} with #{args.inspect} due to:\n#{e}"
		end
	end
	
	# name is a Symbol, args an array of the form: [[argname, argvalue], ...]
	# if an argument is positional, the argname should be nil
	def invoke(name, args)
		self.class.invoke_instance_method(self, name, args)
	end
end
