module Halsbe
	module Frames
		module Frame
			attr_reader :op
		end

		def self.new(op, *args)
			frame = Struct.new(*args)
			#frame.extend(Frame)
			#frame.instance_variable_set(:@op, op)
			frame
		end
		
		Block     = new(:local_variables, :statements)
		Call      = new(:receiver, :method_name, :arguments)
		Constant  = new(:name)
		Literal   = new(:data)
	end
end