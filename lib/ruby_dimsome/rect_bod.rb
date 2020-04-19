module Dimsome
	class RubyRect 
		include Rect
		include Dimsome::ModUtil::Rect
		include Dimsome::ModRectAccessors
		include Dimsome::ModRectRelative
		include Dimsome::ModRectGrip
		include Dimsome::ModRectApply

		attr_accessor :origin, :size

		# all mods expect:
		def to_ary() [self.origin, self.size] end
	
		def to_quad() to_ary.map{|e| e.to_ary}.flatten end
		def to_pair_pair() to_ary.map{|e| e.to_ary} end
		# to_a???
		
		### Rect doesn't extend Dim2d, so doesn't include ModArith, need ModRectArith...
		def ==(other)
			other.is_a?(self.class) && other.to_ary == self.to_ary
		end


		# ModRectAccessors expects:
		# to defeat Apple CGRect keeping neg size info...
		def std() 
			x = (size.w < 0 ? origin.x + size.w : origin.x)
			y = (size.h < 0 ? origin.y + size.h : origin.y)
			self.class.new(x, y, size.w.abs, size.h.abs)
		end			

		def dup() 
			self.class.new(origin.x, origin.y, size.w, size.h)
		end
	
		def self.make(*args) self.new(*args) end ### fix args!!! FIXME!!!

		def initialize(*args)
			# do we ever want to keep Point, Size passed in or always copy???
			one, two = (args.empty? ? [[0, 0], [0, 0]] : strict_numeric_pair_pair(*args))
			raise "#{self.class}#new bad args (#{args.inspect})" unless one && two #&& two redun
			self.origin = RubyPoint.make(one)
			self.size = RubySize.make(two)
		end

		def self.empty() self.new(0, 0, 0, 0) end
# 		def self.empty() self.class.new(0, 0, 0, 0) end
# 		def self.zero() self.empty end

		def farpoint() origin + size end
		def far_x() x + w end
		def far_y() y + h end
		def kitty() [far_x, far_y] end # Point???
		def kitty_pair() [[x, y], kitty] end
		def kitty_quad() [x, y, far_x, far_y] end
	
	end
end
