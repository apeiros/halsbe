module Halsbe
	class VM
		class H_Object
			attr_accessor :vm
			attr_accessor :object_id
			attr_accessor :template

			attr_accessor :fragment
			attr_accessor :ivars
			attr_accessor :observers
			attr_accessor :conditional_mask
				
			attr_accessor :eigen_methods
			attr_accessor :eigen_mixins
			attr_accessor :eigen_conditionals
			attr_accessor :eigen_invariants

			attr_accessor :template_methods
			attr_accessor :template_mixins
			attr_accessor :template_conditionals
			attr_accessor :template_invariants

			def initialize(vm, object_id, template)
				@vm        = vm
				@object_id = object_id
				@template  = nil

				@fragment         = nil
				@ivars            = {}
				@observers        = []
				@conditional_mask = 0
				
				@eigen_methods      = {}
				@eigen_mixins       = []
				@eigen_conditionals = []
				@eigen_invariants   = {}

				@template_methods      = {}
				@template_mixins       = []
				@template_conditionals = []
				@template_invariants   = {}
			end

			# name: Symbol
			# caller: Fixnum (object reference)
			# arguments: [[name(Symbol), value(Fixnum (object reference))], ...]
			def dispatch(name, caller, arguments)
				method = @eigen_methods.methods[name] || (@template && @template.template_methods[name])
				if method then
					method.call(self, caller, arguments)
				elsif name != :method_missing then
					dispatch(:method_missing, caller, arguments)
				else
					@vm.raise_exception(:NoMethod)
				end
			end
		end # H_Object
	end # VM
end # Halsbe
