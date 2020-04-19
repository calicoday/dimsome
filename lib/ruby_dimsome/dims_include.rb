# Actual reopening of Array to add conv constructor methods.
# motion_ has cg_dims_plus.rb modules grouping things but here it's very simple.

module Dimsome
	module ArrayDimsPlus
		### rough guess!!! FIXME!!
		def dim() "go dim #{self.inspect}!!!" end
		def dim2d() dimo(:dim2d) end #nec???
		def dimp() dimo(:point) end
		def dims() dimo(:size) end
		def dimr() dimo(:rect) end
		def dimo(type=:point)
			case type
			when :dim2d
				RubyDim2d.new(*[self[0], self[1]]) #why this * and []... ???!!! FIXME!!!
			when :size, :s
				RubySize.new(*[self[0], self[1]])
			when :rect, :r
				flat = self.flatten # in case [[],[]]
				RubyRect.new(*[flat[0], flat[1], flat[2], flat[3]]) ### pref construct??? FIXME!!!
			else #:point
				RubyPoint.new(*[self[0], self[1]])
			end
		end
	
		### from motion_ NSArray...
# 		def cg() "go cg!!!" end
# 		def cgp() cgo(:point) end
# 		def cgs() cgo(:size) end
# 		def cgr() cgo(:rect) end
# 		def cgo(type=:point)
# 			case type
# 			when :size, :s
# 				CGSizeMake(*[self[0], self[1]])
# 			when :rect, :r
# 				flat = self.flatten
# 				CGRectMake(*[flat[0], flat[1], flat[2], flat[3]])
# 			else #:point
# 				CGPointMake(*[self[0], self[1]])
# 			end
# 		end
	end #module ArrayDimsPlus
end

class Array
	include Dimsome::ArrayDimsPlus
end
