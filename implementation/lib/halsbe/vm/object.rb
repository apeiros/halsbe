module Halsbe
	class VM
		
		class HObject

			attr_accessor :proprietary
			attr_reader :object_id
			attr_reader :shared
			def initialize(vm, object_id, shared)
				@vm          = vm
				@object_id   = object_id
				@proprietary = nil
				@shared      = shared
				@ivars       = {}
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
		end # HObeject
		
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