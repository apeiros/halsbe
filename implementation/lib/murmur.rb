class String
	# not sure what range seed may be
	def murmur(seed=Kernel.rand(1<<32))

		# 'm' and 'r' are mixing constants generated offline.
		# They're not really 'magic', they just happen to work well.
		m = 0x5bd1e995
		r = 24

		# Initialize the hash to a 'random' value
		h = seed ^ size;

		# Mix 4 bytes at a time into the hash
		ljust((size/4.0 - 0.1).ceil*4, "\0").unpack("I*").each { |k|
			k *= m
			k ^= k >> r
			k *= m 
		
			h *= m 
			h ^= k

			len -= 4
		}
	
		# Do a few final mixes of the hash to ensure the last few
		# bytes are well-incorporated.
		h *= m
		h ^= h >> 13
		h *= m
		h ^= h >> 15
		return h
	end
end
