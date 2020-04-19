module Dimsome
	module ModArith
		### expects supplied to_ary as [origin, size]

		# basic operators

		def ==(other)
			other.is_a?(self.class) && other.to_ary == self.to_ary
		end

		def -@
			a = to_ary
			self.class.new(-a[0], -a[1])
		end

		def compose(delta, orient=[1,1])
			(self + delta) * orient
	# 		b = self + delta
	# 		self.class.new(b[0] * orient[0], b[1] * orient[1])
	# 		a = to_ary
	# 		self.class.new(a[0] + add[0]
		end

		# for subclasses
		# yard doc needs TWO blank lines before def to ignore comment!!!
		
		
		def vetted_add(pair)
			a = to_ary
			self.class.new(a[0] + (pair[0] || 0), a[1] + (pair[1] || 0))
		end
		def vetted_multiply(pair)
			a = to_ary
			self.class.new(a[0] * (pair[0] || 1), a[1] * (pair[1] || 1))
		end
		def vetted_divide(pair)
			### yard doc needs comment INSIDE def to ignore it!!!
			# comment from geomotion:
			# it is tempting to define this as self * (1.0/scale) but floating point
			# errors result in too many errors
			### ensure fdiv!!! FIXME!!!
			a = to_ary
			self.class.new(a[0] * 1.0 / (pair[0] || 1), a[1] * 1.0 / (pair[1] || 1))
		end
		def vetted_subtract(pair)
			a = to_ary
			self.class.new(a[0] - (pair[0] || 0), a[1] - (pair[1] || 0))
		end
		
		def +(other)
			raise_cannot_op('+', other) unless pair = numeric_pair(other)
			vetted_add(pair)
		end

	
		def *(other)
			raise_cannot_op('*', other) unless pair = numeric_pair(other)
			vetted_multiply(pair)
		end

		def /(other)
			raise_cannot_op('/', other) unless pair = numeric_pair(other)
			vetted_divide(pair)
		end

		def -(other)
			raise_cannot_op('-', other) unless pair = numeric_pair(other)
			vetted_subtract(pair)
		end

		# Derived values and size arithmetic

		def empty?() 
			a = to_ary
			a[0] == 0 && a[1] == 0 
		end
		alias_method :zero?, :empty?

		def abs() 
			a = to_ary
			self.class.new(a[0].abs, a[1].abs) 
		end
	
		### TMP!!! Float#round can't take arg!!! FIXME!!!
		def round(digits=0)
			a = to_ary
			self.class.new(a[0].round, a[1].round)
	#     self.class.new(a[0].round(digits), a[1].round(digits))
		end

		def rough_diagonal
			a = to_ary
			return a[0]**2 + a[1]**2
		end

		def diagonal 
			return Math.sqrt(rough_diagonal)
		end

		def angle
			a = to_ary
			Math.atan2(a[1], a[0])
		end

		def angle_to(other) (self - other).angle end

		### phrase this differently???
	#   def inside?(rect)
	#     CGRectContainsPoint(rect, self)
	#   end

		# was really length_to_within?
		#def within?(any_numeric_pair) ???
		def within_radius?(radius) # do - then call this???
			a = to_ary
			return rough_diagonal <= radius**2 if a[0].abs <= radius && a[1].abs <= radius
# 			return rough_length <= radius**2 if a[0].abs <= radius && a[1].abs <= radius
			false
		end
	#   def length_within?(radius, point)
	# #   def distance_within?(radius, to: point)
	#     dx = self.x - point.x
	#     dy = self.y - point.y
	#     if dx.abs <= radius && dy.abs <= radius
	#       return rough_distance_to(point) <= radius**2
	#     end
	#     return false
	#   end
	
	end #module ModArith
end #module Dimsome