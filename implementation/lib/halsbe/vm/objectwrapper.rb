module Halsbe
	class VM
		# Wrap Halsbe Objects so that they can be used like ruby objects
		class ObjectWrapper
			def initialize(halsbe_object)
				@obj = halsbe_object
			end
			
			def halsbe_send()
			end
			
			def method_missing
			end
		end
	end
end
