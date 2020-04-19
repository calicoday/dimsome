module Dimsome

	module ATSCGSharePointDimsPlus
		include Point
		include ModUtil::Pair
		include ModArith
		include ModPoint
	# 	include DimsUtil
	# 	include PairArithmetic
	# 	include PointRelative
	
		# all mods expect:
		def to_ary() [self.x, self.y] end

		### we don't supply new bc we're extending existing class wrapping objc struct!!!
		### standardize on make()??? ya try that, else have to rem new is ok bc struct...!!!
# 		def make(*args) self.class.new(*args) end
# 		def self.make(*args) CGPointMake(*args) end ### fix args!!! FIXME!!!
# 		def make(*args) CGPointMake(*args) end ### fix args!!! FIXME!!!

# 		def self.make(*args) #self.new(*args) end ### fix args!!! FIXME!!!
# 			one, two, _ = args
# 			pair = (one ? 
# 				(two ? strict_numeric_pair([one, two]) : strict_numeric_pair(one)) :
# 				[0, 0])		
# 			raise "#{self}#new bad args (#{one}, #{two})" unless pair
# 			CGPointMake(pair[0], pair[1])
# # 			raise "#{self.class}#new bad args (#{[one, two]})" unless pair
# # 			self.arr = pair
# 		end

	end #module ATSCGSharePointDimsPlus

	module CGSizeDimsPlus
		include Size
		include ModUtil::Pair
		include ModArith
		include ModSize
# 		include DimsUtil
# 		include PairArithmetic
# 		include SizeRelative
	
		# all mods expect:
		def to_ary() [self.width, self.height] end

		def w=(v) self.width = v end
		def w() self.width end
		def h=(v) self.height = v end
		def h() self.height end
		
		# what up with the namespacing...???
# 		alias_method :w=, ::width=
# 		alias_method :w, ::width
# 		alias_method :h=, ::height=
# 		alias_method :h, ::height
# 		alias_method :w=, :width=
# 		alias_method :w, :width
# 		alias_method :h=, :height=
# 		alias_method :h, :height
		# reverse for ruby!!!
# 		alias_method :width=, :w=
# 		alias_method :width, :w
# 		alias_method :height=, :h=
# 		alias_method :height, :h

		# rename methods for conv
		### these are already diagonal, not length!!!
# 		alias_method :diagonal, :length
# 		alias_method :rough_diagonal, :rough_length
	
		# to defeat Apple CGRect keeping neg size info...
		def abs() self.class.new(self.width.abs, self.height.abs) end

	end #module CGSizeDimsPlus

	module CGRectDimsPlus
		include Rect
		include ModUtil::Rect
		include ModRectAccessors
		include ModRectRelative
		include ModRectGrip
		include ModRectApply
# 		include DimsUtil
# 	# 	include RectArithmetic #compare, intersect? ???
# 		include RectRelative

		# all mods expect:
		def to_ary() [self.origin, self.size] end
		def to_quad() to_ary.map{|e| e.to_ary}.flatten end
	
		# to defeat Apple CGRect keeping neg size info...
		# if not CGRectStandardize, shd prob return copy not just self!!!
		def std() CGRectStandardize(self) end

		### wrong???!!!
		def dup() self.class.new(self) end ###???

		def self.make(*args) # ??? # do size.abs???
		end
	
		### getters/setters???

	end #module CGRectDimsPlus


end #module Dimsome
