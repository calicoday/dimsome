# Some sort of comment here.

class Array
	def to_ary() to_a end
end
module Kernel
	alias __callee__ __method__ if $gtk
# 	def defined?(v) Kernel.const_defined?(v.to_sym) end
end

module Dimsome
	# so we can is_a?
	module Dim2d; end
	module Point; end
	module Size; end
	module Rect; end
	
  # General utility methods
	module ModUtil
		# Core utility methods for all Dimsome classes
		module Core
			# Raise an exception with the name of the current operator and operand and 
			#		optional details.
			#
			# @example 
			#   a_point.raise_cannot_op('+', a_string_var) 
			#			#=> "Point can't + given String"
			#
			# @param op [String] operator name
			# @param other [Object] operand name
			# @param more [String] (optional) details # unused!!!
			# @return none
			def raise_cannot_op(op, other, more="")
				raise "#{self.class.name} can't #{op} given #{other ? other.inspect : 'nil'} #{more}"
			end

			# Converts object to a numeric pair.
			#
			# @example 
			#   numeric_pair(3) #=> [3, 3]
			#   numeric_pair([3, nil]) #=> [3, nil]
			#   numeric_pair(Point.make(4, 5)) #=> [4, 5]
			#   numeric_pair("some string") #=> nil
			#
			# @param other [Numeric, Array, numpairable] a single Numeric or an object that
			#		can be converted to a numeric pair.
			# @return [Array, nil] an Array that is a numeric pair or nil
			def numeric_pair(other)
	# 			return [other, other] if other.is_a?(Numeric)
				return [other, other] if (other.is_a?(Numeric) || other.nil?)
# 				puts "=== && other: other, #{other.inspect}"
				a = other.to_ary if other.respond_to?(:to_ary)
				return nil unless a && a.length > 1
				[(a[0] && a[0].is_a?(Numeric) ? a[0] : nil),
					(a[1] && a[1].is_a?(Numeric) ? a[1] : nil)]
			end

			# Converts object to a strict numeric pair, ie a 2-member Array of Numerics 
			#		(not nil).
			# @see #numeric_pair
			# @example 
			#   numeric_pair(3) #=> [3, 3]
			#   numeric_pair([3, nil]) #=> nil # This example differs!
			#   numeric_pair(Point.make(4, 5)) #=> [4, 5]
			#   numeric_pair("some string") #=> nil
			#
			# @param other [Numeric, Array, numpairable] a single Numeric or an object that
			#		can be converted to a numeric pair.
			# @return [Array, nil] an Array that is a numeric pair or nil
			def strict_numeric_pair(other)
				return nil unless pair = numeric_pair(other)
				(pair[0].nil? || pair[1].nil?) ? nil : pair
			end

			def strict_numeric_pair_pair(*args)
				one, two, quad = nil, nil, nil
				case args.length
				when 4 
					quad = args
				when 1 
					return nil unless args[0].respond_to?(:to_ary)
					quad = args[0].to_ary[0..3]
				end
				one = strict_numeric_pair(quad ? [quad[0], quad[1]] : args[0])
				two = strict_numeric_pair(quad ? [quad[2], quad[3]] : args[1])
				return nil unless one && two
				[one, two]
			end
		end 
		
		# Utility methods for Dimsome 2-value Pair classes, ie Dim2d, Point, Size
		module Pair
			include Core

			def inspect
				a = to_ary
				"#{self.class.name}(#{a[0]}, #{a[1]})"
			end
			alias_method :to_s, :inspect
			
			### TMP!!! Float#round can't take arg!!! FIXME!!!
			def insp(digits=0)
				a = to_ary
				name = self.class.name.split(':').last
				"#{name}~(#{a[0].round}, #{a[1].round})"
			end
		end 

		# Utility methods for Dimsome 4-value Rect classes
		module Rect
			include Core
			
			# expects supplied to_ary as [origin, size], to_quad as [x, y, w, h]
			def inspect
				x, y, w, h = to_quad
				"#{self.class.name}([#{x}, #{y}], [#{w}, #{h}])"
			end
			alias_method :to_s, :inspect
			
			### TMP!!! Float#round can't take arg!!! FIXME!!!
			def insp(digits=0)
				x, y, w, h = to_quad
				name = self.class.name.split(':').last
				"#{name}~([#{x.round}, #{y.round}], [#{w.round}, #{h.round}])"
			end
		end
	end
end

module Dimsome
	module ModArith
		### expects supplied to_ary as [origin, size]

		# basic operators

		def ==(other)
			other.is_a?(self.class) && other.to_ary == self.to_ary
		end

		def -@
			a = to_ary
			self.class.make(-a[0], -a[1])
		end

		def compose(delta, orient=[1,1])
			(self + delta) * orient
		end

		# for subclasses
		# yard doc needs TWO blank lines before def to ignore comment!!!
		
		
		def vetted_add(pair)
			a = to_ary
			self.class.make(a[0] + (pair[0] || 0), a[1] + (pair[1] || 0))
		end
		def vetted_multiply(pair)
			a = to_ary
			self.class.make(a[0] * (pair[0] || 1), a[1] * (pair[1] || 1))
		end
		def vetted_divide(pair)
			### yard doc needs comment INSIDE def to ignore it!!!
			# comment from geomotion:
			# it is tempting to define this as self * (1.0/scale) but floating point
			# errors result in too many errors
			### ensure fdiv!!! FIXME!!!
			a = to_ary
			self.class.make(a[0] * 1.0 / (pair[0] || 1), a[1] * 1.0 / (pair[1] || 1))
		end
		def vetted_subtract(pair)
			a = to_ary
			self.class.make(a[0] - (pair[0] || 0), a[1] - (pair[1] || 0))
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
			self.class.make(a[0].abs, a[1].abs) 
		end
	
		### TMP!!! Float#round can't take arg!!! FIXME!!!
		def round(digits=0)
			a = to_ary
			self.class.make(a[0].round, a[1].round)
	#     self.class.make(a[0].round(digits), a[1].round(digits))
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

		def within_radius?(radius)
			a = to_ary
			return rough_diagonal <= radius**2 if a[0].abs <= radius && a[1].abs <= radius
			false
		end
	end 
end 

module Dimsome
	module ModPoint
		# point-specific relatives
		def left(amount) compose([-amount, nil]) end
		def right(amount) compose([amount, nil]) end
		def up(amount) compose([nil, amount]) end
		def down(amount) compose([nil, -amount]) end
	end
end

module Dimsome
	module ModSize
		# size-specific relatives
		def grow(amount) compose([amount, amount]) end
		def shrink(amount) compose([-amount, -amount]) end
		def wider(amount) compose([amount, nil]) end
		def thinner(amount) compose([-amount, nil]) end
		def taller(amount) compose([nil, amount]) end
		def shorter(amount) compose([nil, -amount]) end
	end
end

module Dimsome
	module ModRectRelative
		# Create rect with same size, adjusted position
	
		### NOTE if you want to pass a num_pair not scalar use move/resize not left/grow/wider
		### specialized methods only take scalar!!!

		def move(other)
			raise_cannot_op('move', other) unless pair = numeric_pair(other)
			vetted_move(pair)
		end
		def vetted_move(pair)
			self.class.make(pair, size.to_ary)
		end

		#### let amount be pair, poss nil, eg [v, nil]??? ###FIXME!!!
		# because these methods have the same names as origin methods, we needn't __callee__
		def left(amount) vetted_move(origin.left(amount)) end
		def right(amount) vetted_move(origin.right(amount)) end
		def up(amount) vetted_move(origin.up(amount)) end
		def down(amount) vetted_move(origin.down(amount)) end
	
		# Create rect with same position, adjusted size

		# spread for the op!!! expressed as a fraction of the w, h
		# anchor wd be a point (in spritekit it's a spread)!!!

		# fit_within/outside???
		def wrt(outer)
		end
	
		def numeric_spread?(spread)
			spread.is_a?(Array) && 
				spread[0] && spread[0].is_a?(Numeric) && spread[0] >= 0 && spread[0] <= 1.0 &&
				spread[1] && spread[0].is_a?(Numeric) && spread[1] >= 0 && spread[1] <= 1.0
		end

		def spread?(spread) ### allows nil members
			spread.is_a?(Array) && 
				spread.length > 1 &&
				(spread[0] == nil || 
					spread[0].is_a?(Numeric) && spread[0] >= 0 && spread[0] <= 1.0) &&
				(spread[1] == nil || 
					spread[1].is_a?(Numeric) && spread[1] >= 0 && spread[1] <= 1.0)
		end
	
		# default is relative to origin bc internal rep -- make centered??? FIXME!!!
	
		def fix_resize_args(amount, spread, opname)
			raise_cannot_op(opname, amount) unless amount.is_a?(Numeric)
			raise_cannot_op(opname, spread, '(bad spread)') if spread && !spread?(spread)
			spread ? spread : [0.0, 0.0]
		end
	
		def resize(other, spread=nil)
			raise_cannot_op('resize', other) unless pair = numeric_pair(other)
			raise_cannot_op(opname, spread, '(bad spread)') if spread && !spread?(spread)
			vetted_resize(pair, spread)
		end

		# use origin.y not rect conv y() to avoid min/max problems for flipflop!!! FIXME!!!
		def vetted_resize(pair, spread)
			sized = size.vetted_add(pair)
			self.class.make([self.origin.x - (spread[0] || 1) * (pair[0] || 0), 
				self.origin.y - (spread[1] || 1) * (pair[1] || 0)], 
				sized)
		end
	
		### grow/shrink amount to EACH side!!!
		### maybe get these into inside/outside, for now grow/shrink from middle...
# 			spread = [0.5, 0.5] unless spread #???
		# ONLY for grow()/shrink(), others amount is total!!!
		# ok very iffy but FOR NOW
		# 1) without spread, dbl amount and center
		# 2) with spread, assume amount is total (ie dbl equiv) and spread is intended	
		### REALLY think amount shd be total!!! FIXME!!! tmp only to match geom specs!!!
		# grow/shrink accept pair as amount???!!! maybe THAT's inside/outside()???
		def grow(amount, spread=nil) 
			unless spread
# 				amount += amount
				spread = [0.5, 0.5]
			end
			vetted_resize([amount, amount], fix_resize_args(amount, spread, __callee__))
		end
		def shrink(amount, spread=nil) 
			unless spread
# 				amount += amount
				spread = [0.5, 0.5]
			end
			vetted_resize([-amount, -amount], fix_resize_args(amount, spread, __callee__))
		end

		def wider(amount, spread=nil) 
# 			amount += amount
# 			spread = [0.5, 0.5] unless spread #???
			vetted_resize([amount, nil], fix_resize_args(amount, spread, __callee__))
		end
		def narrower(amount, spread=nil) 
# 			amount += amount
# 			spread = [0.5, 0.5] unless spread #???
			vetted_resize([-amount, nil], fix_resize_args(amount, spread, __callee__))
		end
	  alias_method :thinner, :narrower
	  alias_method :thicker, :wider
		def taller(amount, spread=nil) 
			vetted_resize([nil, amount], fix_resize_args(amount, spread, __callee__))
		end
		def shorter(amount, spread=nil) 
			vetted_resize([nil, -amount], fix_resize_args(amount, spread, __callee__))
		end
	
		def amount_as_pair(v, amount)
			case v
			when :grow then [amount, amount]
			when :shrink then [-amount, -amount]

			when :wider then [amount, nil]
			when :narrower then [-amount, nil]
			when :taller then [nil, amount]
			when :shorter then [nil, -amount]
			else
				[nil, nil] # fail silently
			end
		end
	
		# grow_up(5) => taller(5)
		# grow_down(5) => taller(5, [0, 1]) => vetted_resize([nil, 5], [0, 1])

		# grow_left == grow_align_right???
		def grow_left(amount) wider(amount, named_spread(:right)) end
		def grow_right(amount) wider(amount, named_spread(:left)) end
		def grow_up(amount) taller(amount, named_spread(:bottom)) end
		def grow_down(amount) taller(amount, named_spread(:top)) end
	
		def shrink_left(amount) narrower(amount, named_spread(:left)) end
		def shrink_right(amount) narrower(amount, named_spread(:right)) end
		def shrink_up(amount) shorter(amount, named_spread(:top)) end
		def shrink_down(amount) shorter(amount, named_spread(:bottom)) end
	
		# grow/shrink_width/_height ???
	
		### Create relative rect with same or adjusted size, adjusted (or adjusted for 
		### resize direction) position, 
		#above, from_left...

		### start with simple above, before, etc, then we'll deal with opts!!!
		def above(further=nil)
			self.up(further ? self.height + further : self.height)
		end
		def below(further=nil)
			self.down(further ? self.height + further : self.height) 
		end
		def before(further=nil)
			self.left(further ? self.width + further : self.width)
		end
		def after(further=nil)
			self.right(further ? self.width + further : self.width)
		end
	
	
		#def near for inside/outside/relative_to???
		# from_ s in general...
	
		# instead of from_left, etc, let's try inside, outside with align...
		# use grip names as directions
		# align pair and offset/padding pair!!!
		def inside(align=nil, offset=nil) ###*args!!!
		end
	# 	def outside(align=nil, further=nil)
		def outside(*args)
# 			align, args = HandyArgs.pull_first_object(Symbol, args)
# 			align = center unless align
			# blah blah blah
		end
	
	
	end
end

module Dimsome
	module ModRectGrip  
		# Spread is a unit vector, where nil means an axis will be ignored or left unmodified.
		# Waypoint is a point some way into the rect, ie [width, height] * (named_)spread
		# 	(geomotion relative position). useful as a delta or offset???
		# Grip is a point in the parent rect, ie origin + [width, height] * (named_)spread
		# 	(geomotion absolute position)
	
		def named_spread(name)
			case name
			when :center then [0.5, 0.5]
			when :top_left then [0.0, 1.0]
			when :top_center then [0.5, 1.0]
			when :top_right then [1.0, 1.0]
			when :center_right then [1.0, 0.5]
			when :bottom_right then [1.0, 0.0]
			when :bottom_center then [0.5, 0.0]
			when :bottom_left then [0.0, 0.0]
			when :center_left then [0.0, 0.5]
			# single edge/direction
			when :left, :rightward then [0.0, nil]
			when :right, :leftward then [1.0, nil]
			when :top, :downward then [nil, 1.0]
			when :bottom, :upward then [nil, 0.0]		
			else
# 				puts "named_spread unknown name: #{name.inspect}"
# 				[nil, nil] # fail silently??? ### [0, 0]???
				#### prob want to raise!!! FIXME!!!
				nil
			end
		end
		### dint solve it
			# if either spread has a nil value, nil for both
# 			if fly_spread[0] == nil || base_spread[0] == nil
# 				fly_spread[0] = base_spread[0] = nil 
# 			end
# 			if fly_spread[1] == nil || base_spread[1] == nil
# 				fly_spread[1] = base_spread[1] = nil 
# 			end
		
		# we are the flyer!!!
		def align(fly_spread, base, base_spread, offset=nil)
			fly_spread = named_spread(fly_spread) if fly_spread.is_a?(Symbol)
			raise_cannot_op(__callee__, fly_spread) unless fly_spread && spread?(fly_spread)
			base_spread = named_spread(base_spread) if base_spread.is_a?(Symbol)
			raise_cannot_op(__callee__, base_spread) unless base_spread && spread?(base_spread)
			
			mask = 2.times.map{|i| fly_spread[i] && base_spread[i] ? 1 : nil}
			dest = base.grip(base_spread) - self.size * fly_spread + offset
			self.move([mask[0] ? dest[0] : self.origin.x, mask[1] ? dest[1] : self.origin.y])
				
			###self.move(delta)
# 			self.move(base.grip(base_spread) - self.size * fly_spread + offset)
			#eg resize:
# 			self.class.make([self.origin.x - (spread[0] || 1) * (pair[0] || 0), 
# 				self.origin.y - (spread[1] || 1) * (pair[1] || 0)], 
# 				sized)
		end
		
		### untested!!! FIXME!!!
		def spread(point)
			### shd std or min/max or something here!!! FIXME!!!
			w, h = size.to_ary
			farx, fary = (origin + size).to_ary
			### no nil, surely???
# 			raise_cannot_op(__callee___, point) unless pair = strict_numeric_pair(offset) &&
			raise_cannot_op(__callee___, point) unless pair = numeric_pair(offset) &&
				pair[0] >= origin.x && pair[0] <= farx &&
				pair[1] >= origin.y && pair[1] <= fary
			[pair[0] == 0 ? 0 : w / (pair[0] * 1.0),
				pair[1] == 0 ? 0 : h / (pair[1] * 1.0)]			
		end

		### new and weird!!!
		def gripgrip_outof(spread, outer_rect, outer_spread)
			grip(spread, outer_rect.grip(outer_spread))
		end
		def gripgrip_into(spread, inner_rect, inner_spread)
			inner_rect.grip(inner_spread, self.grip(spread))
		end

### from daff!!!
		def pull_last_object(baseclass, args_arr)
			baseclass = (args_arr && args_arr.last && args_arr.last.is_a?(baseclass) ? 
				args_arr.pop : 
				nil)
			[baseclass, args_arr]
		end
###	

		def fix_offset(offset, opname)
			return [0.0, 0.0] unless offset
			raise_cannot_op(opname, offset) unless pair = numeric_pair(offset)
			pair
		end


		# to get sksprite anchor point...
		def waypoint(name_or_spread, offset=nil) 
			spread = named_spread(name_or_spread) || numeric_pair(name_or_spread)
			raise_cannot_op(__callee__, spread) unless spread && spread?(spread)
			vetted_waypoint(spread, fix_offset(offset, __callee__)) 
		end
		def vetted_waypoint(spread, offset_pair)
			### allow nil??? FIXME!!!
# 			puts "\n=== v_way spread: #{spread.inspect}, offset: #{offset_pair.inspect}"
			w, h = size.to_ary
			### try ignoring w or h on nil... nope put it back for now...
# 			origin.class.make((offset_pair[0] || 0) + (spread[0] || 0) * w, 
# 				(offset_pair[1] || 0) + (spread[1] || 0) * h)
			origin.class.make((offset_pair[0] || 0) + (spread[0] || 1) * w, 
				(offset_pair[1] || 0) + (spread[1] || 1) * h)
		end	
		
# 		def grip(name_or_spread, offset=nil, callee=nil) 
		def grip(*args) 
			name_or_spread = args.shift
			spread = named_spread(name_or_spread) || numeric_pair(name_or_spread)
			raise_cannot_op(__callee__, spread) unless spread && spread?(spread)

			# __callee__ is Symbol with regular ruby methods, String with SDK methods, eg
			# "method:named_arg:" CONF!!!
			callee = pull_last_object(Symbol, args)
			callee = __callee__ unless callee
			offset, _ = args
			
			#### TMP!!! bc we used to accept true as offset
			raise "#{callee}(true) no longer accepted!!! Give name_or_spread." if offset == true
			
			vetted_grip(spread, fix_offset(offset, __callee__)) 
		end
		
		def vetted_grip(spread, offset_pair)
# 		puts "  === got: #{vetted_waypoint(spread, offset_pair)}, origin: #{origin.inspect}"
			vetted_waypoint(spread, offset_pair) + origin
		end	

		### __callee__ spelt diff ruby/rubymotion, eg :center vs center:
		# otherwise cdv done eg grip(__callee__, offset, __callee__)
		def center(offset=nil) grip(:center, offset, __callee__) end
		def top_left(offset=nil) grip(:top_left, offset, __callee__) end
		def top_center(offset=nil) grip(:top_center, offset, __callee__) end
		def top_right(offset=nil) grip(:top_right, offset, __callee__) end
		def center_right(offset=nil) grip(:center_right, offset, __callee__) end
		def bottom_right(offset=nil) grip(:bottom_right, offset, __callee__) end
		def bottom_center(offset=nil) grip(:bottom_center, offset, __callee__) end
		def bottom_left(offset=nil) grip(:bottom_left, offset, __callee__) end
		def center_left(offset=nil) grip(:center_left, offset, __callee__) end

		# unnec???
		def align_as_spread(v)
			case v
			when :center then [0.5, 0.5]
			when :top_left then [0.0, 1.0]
			when :top_center then [0.5, 1.0]
			when :top_right then [1.0, 1.0]
			when :center_right then [1.0, 0.5]
			when :bottom_right then [1.0, 0.0]
			when :bottom_center then [0.5, 0.0]
			when :bottom_left then [0.0, 0.0]
			when :center_left then [0.0, 0.5]
			else
				[0.0, 0.0] # fail silently
			end
		end

	end
end

module Dimsome
	module ModRectAccessors
		### expects an origin with #x,#x=,#y,#y= and size with #w,#w=,#h,#h=!!!
		### expect #std returning standardized copy of rect!!!
		
		# Getters/setters -- non-equals form given an arg is a setter, to enable chaining
	
		# shd we have origin(value=nil), size(value=nil) for balance???
		# not if we're CGRect, already has it!!! Other ruby??? Android???

		### rect getters implementation must NOT use the rect getters but rather 
		# origin/size getters to avoid std() looping!!! duh.
		
		def x=(value) self.origin.x = value end
		def x(value=nil)
			return min_x unless value
			self.class.make([value, self.origin.y], self.size)
		end

		def y=(value) self.origin.y = value end
		def y(value=nil)
			return min_y unless value
			self.class.make([self.origin.x, value], self.size)
		end

		def w=(value) self.size.w = value end
		def w(value=nil)
			return self.std.size.w unless value
			self.class.make(self.origin, [value, self.size.h])
		end
		alias_method :width=, :w=
		alias_method :width, :w

		def h=(value) self.size.h = value end
		def h(value=nil)
			return self.std.size.h unless value
			self.class.make(self.origin, [self.size.w, value])
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

module Dimsome
	module ModRectApply 
	
		# apply calls methods, rather than each method calling poss unnec apply with 
		# giant switch
		def apply(options)
			# CGRectStandardize returns a copy, surely???
			rect = self.std
			return rect unless options && !options.empty?
			
			### we return a copy but we tweak the copy's values directly!!!
			# don't use rect conv methods but origin, size here!!!
			
			# sift for redundant/overlapping settings!!! FIXME!!!
			
			### y, orient???
		
			options.each do |key, value|
				# vet value is Numeric, unless for origin, size!!! FIXME!!!
				case key
				# props

				# value MUST be num_pair or Point!!!
				when :origin #then rect.origin = value ### CG-specific!!! does this work???
					pair = numeric_pair(value)
	        rect.origin = rect.origin.class.make(pair)
# 	        rect.origin = rect.origin.class.new(pair)
				when :size #then rect.size = value  ### CG-specific!!! does this work???
					pair = numeric_pair(value)
	        rect.size = rect.size.class.make(pair)
# 	        rect.size = rect.size.class.new(value)
	
				when :x #then rect.x = value
					rect.origin.x = value
				when :y #then rect.y = value
					rect.origin.y = value
				when :width, :w #then rect.w = value
					rect.size.w = value
				when :height, :h #then rect.h = value
					rect.size.h = value
			
				# position
				when :left #then rect.left(value) ### can we go with these???
					rect.origin.x -= value
				when :right #then rect.right(value)
					rect.origin.x += value
				when :up #then rect.up(value)
					rect.origin.y += value
				when :down #then rect.down(value)
					rect.origin.y -= value

				# size
				when :grow
					rect.size.w += value
					rect.origin.x -= value * 0.5 #value/2.0
					rect.size.h += value
					rect.origin.y -= value * 0.5
# 					rect.size.w += value + value
# 					rect.size.h += value + value
# 					rect.origin.x -= value
# 					rect.origin.y -= value
				when :shrink
					rect.size.w -= value
					rect.origin.x += value * 0.5
					rect.size.h -= value
					rect.origin.y += value * 0.5
# 					rect.size.w -= value + value
# 					rect.size.h -= value + value
# 					rect.origin.x += value
# 					rect.origin.y += value
		
				when :wider, :grow_width
					rect.size.w += value
					rect.origin.x -= value * 0.5 #value/2.0
				when :taller, :grow_height
					rect.size.h += value
					rect.origin.y -= value * 0.5

				when :grow_right
					rect.size.w += value
				when :grow_left
					rect.size.w += value
					rect.origin.x -= value
					
				when :grow_up
					rect.size.h += value
				when :grow_down
					rect.size.h += value
					rect.origin.y -= value
					
				when :narrower, :shrink_width, :thinner ###geom name!!!
					rect.size.w -= value
					rect.origin.x += value * 0.5
				when :shorter, :shrink_height
					rect.size.h -= value
					rect.origin.y += value * 0.5
					
				when :shrink_left
					rect.size.w -= value
				when :shrink_right
					rect.size.w -= value
					rect.origin.x += value
					
				when :shrink_down
					rect.size.h -= value
				when :shrink_up
					rect.size.h -= value
					rect.origin.y += value

				#else #???
				end
			end
			
			rect
		end  
	
	# 	def flipflop(orient=[1,1], &b)
	# 		# apply orient
	# 		got = yield self
	# 		# apply orient
	# 	end

	end
end

module Dimsome

	class Grid
		attr_accessor :cols, :rows, :cell_rect

		def self.make(cell_rect, cols, rows)
			self.new(cell_rect, cols, rows)
		end
		def initialize(cell_rect, cols, rows)
			self.cell_rect = cell_rect
			self.cols = cols
			self.rows = rows
		end
	
		def cell_size() cell_rect.size end
		def grid_size() @grid_size ||= cell_size * [cols, rows] end
	
		def random_colrow
			[rand(0...cols), rand(0...rows)]
		end
	
		def colrow_to_rect(col, row)
			cell_rect.class.make(*(cell_size * [col, row]), *cell_size)
		end

		def point_to_colrow(p)
			# dims don't have floor yet!!! FIXME!!!
			got = p / cell_size
			[got.x.floor, got.y.floor]
		end
	
		def point_to_rect(p)
			colrow_to_rect(*point_to_colrow(p))
		end
	
	end

end

module Dimsome

	class Twig
		attr_accessor :name, :children, :data
	
		def initialize(*args)
			@name, @data, @children, _ = args
			@name ||= "new item"
			@children ||= []
		end

		def new_kid(name, data=nil)
			new_kid_at_index(name, -1, data)
		end
		def new_kid_at_index(name, index, data=nil)
			twig = Twig.new(name)
			@children.insert(index, twig)
			twig.data = data
			twig
		end
		### nec??? works???? FIXME!!!
		def new_kid_at_end(name, data=nil)
			Twig.new(name).tap{|o| children << o}
		end
	# 	def to_s
	# 		"[#{name}, #{children.map{|e| e.inspect}}]"
	# 	end
		def four11
			[name, children.map {|e| e.name }].inspect
		end
	end

end

module Dimsome
	class RubyDim2d
		include Dim2d
		include ModUtil::Pair
		include ModArith

		attr_accessor :arr
	
		def pair() [arr[0], arr[1]] end
		alias_method :to_ary, :pair
		alias_method :to_a, :pair
	
		def dup() self.class.make(*arr) end

		def charge
			[arr[0] == 0 ? 0 : (arr[0] > 0 ? 1 : -1),
				arr[1] == 0 ? 0 : (arr[1] > 0 ? 1 : -1)]
	# 		[arr[0] == 0 ? 0 : arr[0]/arr[0].abs,
	# 			arr[1] == 0 ? 0 : arr[1]/arr[1].abs]
		end

		def self.make(*args) self.new(*args) end

		def initialize(one=nil, two=nil)
			pair = (one ? 
				(two ? strict_numeric_pair([one, two]) : strict_numeric_pair(one)) :
				[0, 0])		
			raise "#{self.class}#new bad args (#{one}, #{two})" unless pair
			self.arr = pair
		end

		def self.empty() self.new(0, 0) end
# 		def empty?() arr[0] == 0 && arr[1] == 0 end
	# 	alias_method :zero, :empty
		def self.zero() self.empty end
	end
end

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

# Actual reopening of Array to add conv constructor methods.
# motion_ has cg_dims_plus.rb modules grouping things but here it's very simple.

module Dimsome
	module ArrayDimsPlus
		def dim2d() Dimsome::RubyDim2d.make(self) end
		def dimp() Dimsome::RubyPoint.make(self) end
		def dims() Dimsome::RubySize.make(self) end
		def dimr() Dimsome::RubyRect.make(self) end
	
		# alias cg methods, so we can copy-paste???
		alias_method :cgp, :dimp
		alias_method :cgs, :dims
		alias_method :cgr, :dimr
	end 
end

class Array
	include Dimsome::ArrayDimsPlus
end

