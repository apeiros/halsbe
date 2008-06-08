class RubyHMethod
	# name is a Symbol
	# args is an array of the form: [[argname, default], ...] where argname
	#   is either a Symbol or an HKleene
	# the block supplied is the body of the method
	def initialize(name, args, &body)
		@name = name
		@args = args
		@pos  = {}
		@body = body
		args.each_with_index { |(name,default),i| @pos[name] = i }
	end
	
	def call(hself, args)
		@body.call(hself, *map_args(args))
	end
	
	def map_args(args)
		named_args, unnamed_args = args.partition { |name, value|
			name
		}
		@args.map { |name, default|
			if found = named_args.assoc(name) then
				found.last
			else
				unnamed_args.empty? ? default : unnamed_args.shift.last
			end
		}
	end
	
	def to_proc
		@body
	end
end
