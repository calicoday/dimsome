## API Cheatsheet

In lieu of actually effective documentation, here's a long list of the methods added to various classes.

## Classes and class additions

Dimsome offers Ruby classes Dim2d, Point, Size and Rect. For RubyMotion, the same functions are also mixed into the AppleOS Foundation classes CGPoint (or ATSPoint, for macos), CGSize and CGRect.

```ruby

module Dimsome
	class Dim2d
		def pair()
		alias_method :to_ary, :pair
		alias_method :to_a, :pair
		def dup()
		def charge
		def self.make(*args)
		def initialize(one=nil, two=nil)
		def self.empty()
		def self.zero()

module Dimsome
	class Point
		def x()
		def x=(v)
		def y()
		def y=(v)

module Dimsome
	class Size
		def w()
		def w=(v)
		def h()
		def h=(v)
		alias_method :width, :w
		alias_method :height, :h

module Dimsome
	class Rect
		def to_ary()
		def to_quad()
		def to_pair_pair()
		def std()
		def std()
		def dup()
		def self.make(*args)
		def initialize(*args)
		def self.empty()
		def farpoint()
		def far_x()
		def far_y()
		def kitty()
		def kitty_pair()
		def kitty_quad()


```

## Ruby Includes

```ruby
module Dimsome
	module ArrayDimsPlus
		def dim()
		def dim2d()
		def dimp()
		def dims()
		def dimr()
		def dimo(type=:point)
class Array
	include Dimsome::ArrayDimsPlus
	
	
```

## RubyMotion Includes

```ruby
module Dimsome
	module ATSCGSharePointDimsPlus
		include ModUtil::Pair
		include ModArith
		include ModPoint
		def to_ary()
	module CGSizeDimsPlus
		include ModUtil::Pair
		include ModArith
		include ModSize
		def to_ary()
		def w=(v)
		def w()
		def h=(v)
		def h()
		def abs()
	module CGRectDimsPlus
		include ModUtil::Rect
		include ModRectAccessors
		include ModRectRelative
		include ModRectGrip
		include ModRectApply
		def to_ary()
		def to_quad()
		def std()
		def dup()
		def self.make(*args)

# ios only
class CGPoint
	include Dimsome::ATSCGSharePointDimsPlus
	include Dimsome::FlipFlopPointIOS
		def self.make(*args)
class CGRect
	include Dimsome::FlipFlopRectIOS

# osx only
class ATSPoint
	include Dimsome::ATSCGSharePointDimsPlus
	include Dimsome::FlipFlopPointOSX
		def self.make(*args)
class CGRect
	include Dimsome::FlipFlopRectOSX
	
class CGRect
	include Dimsome::CGRectDimsPlus
		def self.make(*args)
		def self.empty()
class CGSize
	include Dimsome::CGSizeDimsPlus
		def self.make(*args)
class NSArray
	def cg()
	def cgp()
	def cgs()
	def cgr()
	def cgo(type=:point)
	def dim()
	alias_method :dim2d, :cgp
	alias_method :dimp, :cgp
	alias_method :dims, :cgs
	alias_method :dimr, :cgr
	alias_method :dimo, :cgo

	
```

## Modules FlipFlop

```ruby
module Dimsome
	module FlipFlopPointIOS
		def upi(amount)
		def downi(amount)
	module FlipFlopRectIOS
		def upi(amount)
		def downi(amount)
		def grow_upi(amount)
		def grow_downi(amount)
		def shrink_upi(amount)
		def shrink_downi(amount)
		def abovei(further=nil)
		def belowi(further=nil)
		def top_lefti(offset=nil)
		def top_centeri(offset=nil)
		def top_righti(offset=nil)
		def bottom_righti(offset=nil)
		def bottom_centeri(offset=nil)
		def bottom_lefti(offset=nil)
	module FlipFlopPointOSX
		def upi(amount)
		def downi(amount)
	module FlipFlopRectOSX
		def upi(amount)
		def downi(amount)
		def grow_upi(amount)
		def grow_downi(amount)
		def shrink_upi(amount)
		def shrink_downi(amount)
		def abovei(further=nil)
		def belowi(further=nil)
		def top_lefti(offset=nil)
		def top_centeri(offset=nil)
		def top_righti(offset=nil)
		def bottom_righti(offset=nil)
		def bottom_centeri(offset=nil)
		def bottom_lefti(offset=nil)
	module FlipFlopPointStub
	module FlipFlopRectStub

```


## Modules

These are the modules of functions that get included in dimension classes. Not intended for use elsewhere (haven't even looked at that, thus far).

```ruby
module ModUtil
	module Core
		# intended for internal use only:
		def numeric_pair(other)
		def strict_numeric_pair(other)
		def strict_numeric_pair_pair(*args)		
		def raise_cannot_op(op, other, more="")

module ModUtil
	module Pair 
		include Core

		def inspect
		alias_method :to_s, :inspect
		def insp(digits=0)
			# TODO: digits is for how many digits precision to round to, currently ignored

module ModUtil
	module Rect 
		include Core

		def inspect
		alias_method :to_s, :inspect
		def insp(digits=0)
			# TODO: digits is for how many digits precision to round to, currently ignored

module ModArith
	# Basic arithmetic methods. Unless otherwise noted:
	#	- any arg is a numeric pairable object
	#	- returns a new object of the same class
	def ==(other)
	def -@
	def compose(delta, orient=[1,1])
		# TODO: orient is for flipflopping, currently ignored
	def +(other)
	def *(other)
	def /(other)
	def -(other)
	def empty?() 
		# => boolean
	def abs() 
	def round(digits=0)
	def rough_diagonal
	def diagonal 
		# => float
	def angle
		# => float
	def angle_to(other) 
		# => float
	def within_radius?(radius) 
		# => boolean

	# intended for internal use only:
	def vetted_add(pair)
	def vetted_multiply(pair)
	def vetted_divide(pair)
	def vetted_subtract(pair)		

module ModPoint
	# point-specific relatives
	#	- arg 'amount' is a numeric (scalar) [not numeric pairable object!!!]
	#	- returns a new object of the same class
	def left(amount)
	def right(amount)
	def up(amount)
	def down(amount)
end

module ModSize
	# size-specific relatives
	#	- arg 'amount' is a numeric (scalar) [not numeric pairable object!!!]
	#	- returns a new object of the same class
	def grow(amount)
	def shrink(amount)
	def wider(amount)
	def thinner(amount)
	def taller(amount)
	def shorter(amount)
end

module ModRectAccessors
	### expects an origin with #x,#x=,#y,#y= and size with #w,#w=,#h,#h=!!!
	### expect #std returning standardized copy of rect!!!

	# These standardize first, which can be no op when not AppleOS CoreGraphics.
	
	# Rect getters/setters. 
	#	- equals form sets and returns the value
	#	- non-equals form with:
	#		- no or nil arg returns the value
	#		- with non-nil args, sets and returns a (standardized) new object of the 
	#				same class for chaining.
	def x=(value) self.origin.x = value end
	def x(value=nil)
	def y=(value)
	def y(value=nil)
	def w=(value)
	def w(value=nil)
	alias_method :width=, :w=
	alias_method :width, :w
	def h=(value)
	def h(value=nil)
	alias_method :height=, :h=
	alias_method :height, :h
	# These standardize first, which can be no op when not AppleOS CoreGraphics.
	# (prev these called CGRectGetMinX, CGRectGetMidX, etc)
	def min_x()
	def mid_x()
	def max_x()
	def min_y()
	def mid_y()
	def max_y()

```

General rect relative notes:

	### NOTE if you want to pass a num_pair not scalar use move/resize not left/grow/wider
	### specialized methods only take scalar!!!

	# spread for the op!!! expressed as a fraction of the w, h
	# anchor wd be a point (in spritekit it's a spread)!!!

	# eg:
	# grow_up(5) => taller(5)
	# grow_down(5) => taller(5, [0, 1]) => vetted_resize([nil, 5], [0, 1])
	
	# grow_left == grow_align_right???

CONFIRM!!!:
- resize/grow/shrink from center or origin by default???
		### grow/shrink amount to EACH side!!!
		### maybe get these into inside/outside, for now grow/shrink from middle...
	# 			spread = [0.5, 0.5] unless spread #???
		# ONLY for grow()/shrink(), others amount is total!!!
		# ok very iffy but FOR NOW
		# 1) without spread, dbl amount and center
		# 2) with spread, assume amount is total (ie dbl equiv) and spread is intended	
		### REALLY think amount shd be total!!! FIXME!!! tmp only to match geom specs!!!
		# grow/shrink accept pair as amount???!!! maybe THAT's inside/outside()???

```ruby
module ModRectRelative
	# rect-specific relatives. Unless otherwise noted:
	#	- arg 'amount' is a numeric (scalar) [not numeric pairable object!!!]
	#		##- arg 'other' is a numeric (scalar) or numeric pairable object
	#	- arg 'other' is a numeric pairable object (includes scalar!!!)
	#	- arg 'spread' is a spread (Array), not necessarily a strictly numeric spread 
	#	- returns a new object of the same class

	# Intended for internal use only
	def vetted_move(pair)
		# => object of same class
	def numeric_spread?(spread)
		# => boolean
	def spread?(spread) ### allows nil members
		# => boolean
	def fix_resize_args(amount, spread, opname)
		# raises if bad args
		# => a spread
	def vetted_resize(pair, spread)
		# => object of same class
	def amount_as_pair(v, amount)
		# v is  :grow, :shrink, :wider, :narrower, :taller or :shorter
		# => a spread ([nil, nil] if unrecognized v)

	# Create rect with same size, adjusted position	
	def move(other)
	def left(amount)
	def right(amount)
	def up(amount)
	def down(amount)

```

	# Create rect with same position, adjusted size
	#	- ???default is relative to origin bc internal rep -- make centered??? FIXME!!!
	# eg:
	# grow_up(5) => taller(5)
	# grow_down(5) => taller(5, [0, 1]) => vetted_resize([nil, 5], [0, 1])	
	# grow_left == grow_align_right???

```ruby	
	def resize(other, spread=nil)
	def grow(amount, spread=nil) 
	def shrink(amount, spread=nil) 
	def wider(amount, spread=nil) 
	def narrower(amount, spread=nil) 
#   alias_method :thinner, :narrower
#   alias_method :thicker, :wider
	def taller(amount, spread=nil) 
	def shorter(amount, spread=nil) 

	def grow_left(amount)
	def grow_right(amount)
	def grow_up(amount)
	def grow_down(amount)

	def shrink_left(amount)
	def shrink_right(amount)
	def shrink_up(amount)
	def shrink_down(amount)

	# grow/shrink_width/_height ???

	### Create relative rect with same or adjusted size, adjusted (or adjusted for 
	### resize direction) position, 
	#above, from_left...

	### start with simple above, before, etc, then we'll deal with opts!!!
	def above(further=nil)
	def below(further=nil)
	def before(further=nil)
	def after(further=nil)

module ModRectApply 
	# Apply a hash of changes at once
	# Really sketchy!!! Don't use this!!!
	def apply(options)

NOTES:

	### dint solve it
		# if either spread has a nil value, nil for both
# 			if fly_spread[0] == nil || base_spread[0] == nil
# 				fly_spread[0] = base_spread[0] = nil 
# 			end
# 			if fly_spread[1] == nil || base_spread[1] == nil
# 				fly_spread[1] = base_spread[1] = nil 
# 			end
	



module ModRectGrip  
	### Point locations within rect.
	# Waypoint is a point some way into the rect, ie origin + spread * width, height.
	# Spread is a unit vector, where nil means an axis to be ignored or left unmodified.
	# Grip is a named, preset waypoint.
	##### NOPE now
	# Spread is a unit vector, where nil means an axis will be ignored or left unmodified.
	# Waypoint is a point some way into the rect, ie [width, height] * (named_)spread
	# 	(geomotion relative position). useful as a delta or offset???
	# Grip is a point in the parent rect, ie origin + [width, height] * (named_)spread
	# 	(geomotion absolute position)
	
	# Intended for internal use only
	def pull_last_object(baseclass, args_arr)
	def fix_offset(offset, opname)
		# => numeric pair

	def named_spread(name)
		# - name is one of :center, :top_left, :top_center, :top_right, 
		#		:center_right, :bottom_center, :bottom_left, :center_left
		#		(or for single edge/direction, one of :left, :rightward, :right, :leftward,
		#		:top, :downward, :bottom, :upward)
		# => a spread ([nil, nil] if unrecognized name)

	def align(fly_spread, base, base_spread, offset=nil)
		# we are the flyer!!!
		# ???
	
	def spread(point)
		### untested!!! FIXME!!!
		### shd std or min/max or something here!!! FIXME!!!
		# ???

	### new and weird!!!
	def gripgrip_outof(spread, outer_rect, outer_spread)
	def gripgrip_into(spread, inner_rect, inner_spread)


	def waypoint(name_or_spread, offset=nil) 
		# to get sksprite anchor point...
		# ???
	def vetted_waypoint(spread, offset_pair)
		### allow nil??? FIXME!!!
		# ???

	def grip(*args) 
		# ??? args
		# => a point (of the class of origin)
		### eg grip(:center, offset, __callee__)
		name_or_spread = args.shift
		spread = named_spread(name_or_spread) || numeric_pair(name_or_spread)
		raise_cannot_op(__callee__, spread) unless spread && spread?(spread)

		# __callee__ is Symbol with regular ruby methods, String with SDK methods, eg
		# "method:named_arg:" CONF!!!
		callee = pull_last_object(Symbol, args)
		callee = __callee__ unless callee
		offset, _ = args
	def vetted_grip(spread, offset_pair)

	# specific named grips. offset is???
	def center(offset=nil)
	def top_left(offset=nil)
	def top_center(offset=nil)
	def top_right(offset=nil)
	def center_right(offset=nil)
	def bottom_right(offset=nil)
	def bottom_center(offset=nil)
	def bottom_left(offset=nil)
	def center_left(offset=nil)

	def align_as_spread(v)
		# unnec???

```
