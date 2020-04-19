module Dimsome
	class RubyPoint < RubyDim2d
		include Point
		include ModPoint
	
	# 	[:x, :y].each_with_index do |m, i|
	# 		define_method(m){ arr[i] }
	# 		define_method("#{m}="){|v| arr[i] = v }
	# 	end

# 		def x() arr[0] end
# 		def x=(v) arr[0] = v end
# 		def y() arr[1] end
# 		def y=(v) arr[1] = v end

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
	
		# included arith
		# included point-specific relatives
	end
end