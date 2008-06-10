module Halsbe
	class VM
		module Primitive
			attr_reader :vm

			def vm_raise(*args)
				raise "Missing implementation"
			end
		end
	end
end
