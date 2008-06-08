module Halsbe
	class VM
		class H_Object

			attr_accessor :proprietary
			attr_reader :object_id
			attr_reader :shared
			def initialize(vm, object_id, template)
				@vm          = vm
				@object_id   = object_id
				@template    = nil
				@shared      = shared
				@ivars       = {}

=begin
			(0) *object-id (0 because it is the address)
			(4) *template: the object that contains the template-methods, -mixins, -conditionals and -invariants
			(2) *flags
				-zombie:    object is only preserved for destructor and must not be referenced again
				-frozen:    object is frozen and must not be mutated
				-readlock:  a method is reading from the object
				-writelock: a method is writing to the object
				-memory:    object has a memory fragment
				-ivars:     has an ivar table
				-observers: has observers
				-eigen*:    has eigentmethods, -mixins, -conditionals and -invariants
				-template*: object serves as template and hence has template methods, -mixins, -conditionals and -invariants
			---
			(4)  memory fragment:   a random access memory accessible only by this object
			(4)  ivar table:        pointer to the instance-variable-table
			(4)  observers:         pointer to an observer-table
			(†)  conditionals mask: binary mask which conditionals/methods are active
			--- (eigen*)
			(4)  eigenmethods:      pointer to the eigenmethods table
			(4)  eigenmixins:       pointer to the mixins List (object)
			(4)  eigenconditionals: pointer to the conditionals List (object)
			(4)  eigeninvariants:   pointer to the invariants table
			--- (template*)
			(4)  template methods:      pointer to the eigenmethods table
			(4)  template mixins:       pointer to the mixins List (object)
			(4)  template conditionals: pointer to the conditionals List (object)
			(4)  template invariants:   pointer to the invariants table
=end

			end

			def dispatch(name, arguments, caller=nil, sharedlock=nil)
				method = (@proprietary && @proprietary.methods[name]) || (@shared && @shared.methods[name])
				if method then
					unless sharedlock then
						if method.query? then
							@vm.readlock(self)
						else
							@vm.writelock(self)
						end
					end
					method.call(self, arguments, caller, sharedlock)
					@vm.release_lock(self)
					[true, rv]
				elsif name != :method_missing then
					success, value = *dispatch(:method_missing, arguments)
					@vm.raise_exception(:NoMethod) unless success
				end
			end
		end # HObeject

		class HModule
			def initialize(object_id)
				@object_id = object_id
				@methods   = {}
			end

			def [](name)
				@methods(name)
			end

			def []=(name, method)
				@methods[name] = name
			end
		end
	end # VM

	class HMethods
		def initialize
end # Halsbe
