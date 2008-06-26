require 'halsbe/parser'
require 'halsbe/vm/instructions'
require 'halsbe/vm/memory'
require 'halsbe/vm/helpers'


module Halsbe
	class VM
		include Instructions
		
		# base path to halsbe core libs
		CoreBase = File.expand_path("#{__FILE__}/../../../../core")

		def initialize
			@memory   = Memory.new # the memory management system for memory fragments
			@objects  = [] # all objects in the system
			@nestings = Nesting.new(self, nil, :Prototype)
			@free_ids = [] # free object id's

			prototype = H_Object.new(self, new_object_id) # the arche-object
			@objects  << prototype
			@nestings[:Prototype] = prototype
			
			# establish core-classes
			[:String, :List, :Array].each { |klass|
				
			
			# load core libs
			Dir.glob("#{CoreBase}/*.halsbe") { |file|
				import(file)
			}
		end
		
		def empty_object
			object_id = new_object_id
			object    = H_Object.new(self, object_id)
			@objects[object_id] = object
		end
		
		def full_object(klass, data, ivars)
			object = empty_object
			object.
		end
		
		def arguments=(args)
			@argv = args
		end

		# get an unused/new object-id
		def new_object_id
			@free_ids.pop || @objects.size
		end
		
		def object(id)
			@objects[id]
		end
		
		def nested(id, base=nil)
			if id =~ /^::/ then
				base = @nestings[:Prototype]
				id = id[2..-1].split(/:/)
			else
				base ||= @nestings[:Prototype]
				id = id[1..-1].split(/:/)
			end
			id.inject(base) { |base,nest| base[nest.to_sym] }
		end
		
		def import(file)
			parser = Parser.file(file)
			parser.parse
			evaluate(parser.ast)
		end
		
		def evaluate(ast)
		end
	end
end
