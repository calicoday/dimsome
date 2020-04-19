module Dimsome
	class RubySize < RubyDim2d
		include Size
		include ModSize
	
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
	end
end