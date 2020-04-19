module Dimsome
	module ATSCGSharePointDimsPlus
		include Point
		include ModUtil::Pair
		include ModArith
		include ModPoint
	
		# all mods expect:
		def to_ary() [self.x, self.y] end
	end 

	module CGSizeDimsPlus
		include Size
		include ModUtil::Pair
		include ModArith
		include ModSize
	
		# all mods expect:
		def to_ary() [self.width, self.height] end

		def w=(v) self.width = v end
		def w() self.width end
		def h=(v) self.height = v end
		def h() self.height end
	
		# to defeat Apple CGRect keeping neg size info...
		def abs() self.class.new(self.width.abs, self.height.abs) end
	end 

	module CGRectDimsPlus
		include Rect
		include ModUtil::Rect
		include ModRectAccessors
		include ModRectRelative
		include ModRectGrip
		include ModRectApply

		# all mods expect:
		def to_ary() [self.origin, self.size] end
		def to_quad() to_ary.map{|e| e.to_ary}.flatten end
	
		# to defeat Apple CGRect keeping neg size info...
		# if not CGRectStandardize, shd prob return copy not just self!!!
		def std() CGRectStandardize(self) end

		### wrong???!!!
		def dup() self.class.make(self) end
	end 
end 
