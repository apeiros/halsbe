require 'halsbe/parser'
require 'halsbe/vm/instructions'
require 'halsbe/vm/memory'


module Halsbe
	class VM
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
end
