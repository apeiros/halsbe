require 'halsbe/parser'
require 'halsbe/vm/instructions'
require 'halsbe/vm/memory'


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
			
			# load core libs
			Dir.glob("#{CoreBase}/*.halsbe") { |file|
				import(file)
			}
		end

		def new_object_id
			@free_ids.pop || @objects.size
		end
		
		def import(file)
			parser = Parser.file(file)
			parser.parse
			evaluate(parser.ast)
		end

		module Primitive
			attr_reader :vm

			def vm_raise(*args)
				raise "Missing implementation"
			end
		end
	end
end
