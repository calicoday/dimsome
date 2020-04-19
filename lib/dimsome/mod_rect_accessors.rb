module Dimsome
	module ModRectAccessors
		### expects an origin with #x,#x=,#y,#y= and size with #w,#w=,#h,#h=!!!
		### expect #std returning standardized copy of rect!!!
		
		# Getters/setters -- non-equals form given an arg is a setter, to enable chaining
		# from geom-plus, consider opts!!! FIXME!!!
	
		#use make() to standardize size????

		### what about class methods???
# 		def self.empty() self.make(0, 0, 0, 0) end
	
		# shd we have origin(value=nil), size(value=nil) for balance???
		# not if we're CGRect, already has it!!! Android??? Other ruby???

		### rect getters implementation must NOT use the rect getters but rather 
		# origin/size getters to avoid std() looping!!! duh.
		
		def x=(value) self.origin.x = value end
		def x(value=nil)
			return min_x unless value
			self.class.new([value, self.origin.y], self.size)
	#   	x, y, w, h = to_quad
	#   	self.class.new([[value, y], [w, h]])
	#   	self.class.new([[value, self.origin.y], self.size.to_ary])
			# make() better bc CGSize???
	# 		rect = CGRect.new([value, self.origin.y], self.size)
		end

		def y=(value) self.origin.y = value end
		def y(value=nil)
			return min_y unless value
			self.class.new([self.origin.x, value], self.size)
		end

		def w=(value) self.size.w = value end
		def w(value=nil)
			return self.std.size.w unless value
			self.class.new(self.origin, [value, self.size.h])
		end
		alias_method :width=, :w=
		alias_method :width, :w

		def h=(value) self.size.h = value end
		def h(value=nil)
			return self.std.size.h unless value
			self.class.new(self.origin, [self.size.w, value])
		end
		alias_method :height=, :h=
		alias_method :height, :h

		# these standardize first, which can be no op when not AOS CoreGraphics.
		# (prev these called CGRectGetMinX, CGRectGetMidX, etc)
		def min_x() self.std.origin.x end 
# 		def min_x() self.std.x end ### nope!!! std() crazyloop!!!
		def mid_x() #(self.std/2).x end # resize ### waypoint??? keep these vr basic???
			r = self.std 
			r.origin.x + r.size.width/2.0
		end
		def max_x() 
			r = self.std
			r.origin.x + r.size.width
		end
		def min_y() self.std.origin.y end
		def mid_y()  #(self.std/2).y end # resize
			r = self.std 
			r.origin.y + r.size.height/2.0
		end
		def max_y()
			r = self.std 
			r.origin.y + r.size.height
		end
	end
end
