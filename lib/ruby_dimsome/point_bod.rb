module Dimsome
	class RubyPoint < RubyDim2d
		include Point
		include ModPoint
	
		def x=(value) arr[0] = value end
		def x(value=nil)
			return arr[0] unless value
			self.class.new([value, arr[1]])
		end

		def y=(value) arr[1] = value end
		def y(value=nil)
			return arr[1] unless value
			self.class.new([arr[0], value])
		end
	end
end