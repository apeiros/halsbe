require 'vm/instructions'
require 'vm/memory'


module Halsbe
	class VM
		include Instructions
		
		def initialize
			@memory = Memory.new
		end
	end
end
