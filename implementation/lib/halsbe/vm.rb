require 'vm/instructions'
require 'vm/memory'


module Halsbe
	class VM
		include Instructions
		Base = File.expand_path("#{__FILE__}/../../../../core")
		p Base

		def initialize
			@memory   = Memory.new # the memory management system for memory fragments
			@objects  = [] # all objects in the system
			@nestings = Nesting.new(self, nil, :Prototype)
			@free_ids = [] # free object id's

			prototype = H_Object.new(self, new_object_id) # the arche-object
			@objects  << prototype
			@nestings[:Prototype] = prototype
		end

		def new_object_id
			@free_ids.pop || @objects.size
		end

		module Primitive
			attr_reader :vm

			def vm_raise(*args)
				raise "Missing implementation"
			end
		end

		class Nesting
			include Primitive

			attr_reader :outer_nesting
			attr_reader :name
			attr_reader :full_name

			def intialize(vm, outer, name)
				@vm            = vm
				@outer_nesting = outer
				@full_name     = "#{outer && outer.name}:#{name}"
				@inner         = {}
			end

			def []=(name, value)
				vm_raise("Nested variable #{value} exists already in nesting #{self}") if @inner.has_key?(name)
				@inner[name] = value
			end

			def [](name)
				vm_raise("Nested variable #{value} exists already in nesting #{self}") if @inner.has_key?(name)
		end
	end
end
