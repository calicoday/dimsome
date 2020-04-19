module Dimsome
	class RubySize < RubyDim2d
		include Size
		include ModSize
	
# 		def w() arr[0] end
# 		def w=(v) arr[0] = v end
# 		def h() arr[1] end
# 		def h=(v) arr[1] = v end
	
		def w=(value) arr[0] = value end
		def w(value=nil)
			return arr[0] unless value
			self.class.new([value, arr[1]])
		end

		def h=(value) arr[1] = value end
		def h(value=nil)
			return arr[1] unless value
			self.class.new([arr[0], value])
		end
	
		alias_method :width, :w
		alias_method :width=, :w=
		alias_method :height, :h
		alias_method :height=, :h=
	
		# included arith
		# included size-specific relatives
	
	end
end