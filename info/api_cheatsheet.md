# API Cheatsheet

In lieu of actually effective documentation, here's a list of the methods added to various classes.


## dimsome/


### dimsome/mod_arith.rb

```ruby
module Dimsome
  module ModArith
    # Basic arithmetic methods. Unless otherwise noted:
    #  - any arg is a numeric pairable object
    #  - returns a new object of the same class
    def ==(other)
    def -@
    def compose(delta, orient=[1,1])
      # TODO: orient is for flipflopping, currently untested
    def +(other)
    def *(other)
    def /(other)
    def -(other)
    def empty?() 
    alias_method :zero?, :empty?
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
```


### dimsome/mod_point.rb

```ruby
module Dimsome
  module ModPoint
    # point-specific relatives
    #  - arg 'amount' is a numeric (scalar) [not numeric pairable object!!!]
    #  - returns a new object of the same class
    def left(amount)
    def right(amount)
    def up(amount)
    def down(amount)
```

### dimsome/mod_rect_accessors.rb

```ruby
module Dimsome
  # expect an origin with #x,#x=,#y,#y= and size with #w,#w=,#h,#h=
  # expect #std returning standardized copy of rect
  module ModRectAccessors
    # Rect getters/setters. 
    #  - equals form sets and returns the value
    #  - non-equals form with:
    #    - no or nil arg returns the value
    #    - with non-nil args, sets and returns a (standardized) new object of the 
    #        same class for chaining.
    def x=(value)
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


### dimsome/mod_rect_apply.rb

```ruby
module Dimsome
  module ModRectApply
    def apply(options)
      # apply a hash of changes at once. Sketchy!!! Don't use this!!!
```


### dimsome/mod_rect_grip.rb

```ruby
module Dimsome
  module ModRectGrip
    # A 'spread' is a unit vector, where nil means an axis will be ignored or 
    #   left unmodified
    # A 'waypoint' is a point some way into the rect, ie [width, height] * (named_)spread
    #   (geomotion relative position)
    # A 'grip' is a point in the parent rect, ie origin + [width, height] * (named_)spread
    #   (geomotion absolute position)
    def named_spread(name)
      # - name is one of :center, :top_left, :top_center, :top_right, 
      #    :center_right, :bottom_center, :bottom_left, :center_left
      #    (or for single edge/direction, one of :left, :rightward, :right, :leftward,
      #    :top, :downward, :bottom, :upward)
      # => a spread ([nil, nil] if unrecognized name)
      
    def waypoint(name_or_spread, offset=nil)
      # - name_or_spread is a spread or a symbol acceptable to #named_spread
      # - offset is optional numeric_pairable
      # => a point within the rect

    def grip(name_or_spread, offset=nil)
      # - name_or_spread is a spread or a symbol acceptable to #named_spread
      # - offset is optional numeric_pairable
      # => a point in the rect's parent's coordinate system

    # grips by name
    def center(offset=nil)
    def top_left(offset=nil)
    def top_center(offset=nil)
    def top_right(offset=nil)
    def center_right(offset=nil)
    def bottom_right(offset=nil)
    def bottom_center(offset=nil)
    def bottom_left(offset=nil)
    def center_left(offset=nil)

    # Intended for internal use only
    def pull_last_object(baseclass, args_arr)
    def fix_offset(offset, opname)
      # => numeric pair
    def vetted_waypoint(spread, offset_pair)
    def vetted_grip(spread, offset_pair)
```


### dimsome/mod_rect_relative.rb

```ruby
module Dimsome
  module ModRectRelative
    # rect-specific relatives. Unless otherwise noted:
    #  - arg 'amount' is a numeric (scalar) [not numeric pairable object!!!]
    #    ##- arg 'other' is a numeric (scalar) or numeric pairable object
    #  - arg 'other' is a numeric pairable object (includes scalar!!!)
    #  - arg 'spread' is a spread (Array), not necessarily a strictly numeric spread 
    #  - returns a new object of the same class
  
    # create rect with same size, adjusted position  
    def move(other)
    def left(amount)
    def right(amount)
    def up(amount)
    def down(amount)
    
    # create rect with same position, adjusted size
    def resize(other, spread=nil)
    def grow(amount, spread=nil)
    def shrink(amount, spread=nil)
    def wider(amount, spread=nil)
    def narrower(amount, spread=nil)
    alias_method :thinner, :narrower
    alias_method :thicker, :wider
    def taller(amount, spread=nil)
    def shorter(amount, spread=nil)
    def amount_as_pair(v, amount)
    def grow_left(amount)
    def grow_right(amount)
    def grow_up(amount)
    def grow_down(amount)
    def shrink_left(amount)
    def shrink_right(amount)
    def shrink_up(amount)
    def shrink_down(amount)
    
    # create relative rect with same or adjusted size, adjusted (or adjusted for 
    # resize direction) position
    def above(further=nil)
    def below(further=nil)
    def before(further=nil)
    def after(further=nil)
    
    # intended for internal use only:
    def numeric_spread?(spread)
      # => boolean
    def spread?(spread) ### allows nil members
      # => boolean
    def fix_resize_args(amount, spread, opname)
      # raises if bad args
      # => a spread
    def vetted_move(pair)
      # => object of same class
    def vetted_resize(pair, spread)
      # => object of same class
    def amount_as_pair(v, amount)
      # v is  :grow, :shrink, :wider, :narrower, :taller or :shorter
      # => a spread ([nil, nil] if unrecognized v)
```


### dimsome/mod_size.rb

```ruby
module Dimsome
  module ModSize
    # size-specific relatives
    #  - arg 'amount' is a numeric (scalar) [not numeric pairable object!!!]
    #  - returns a new object of the same class
    def grow(amount)
    def shrink(amount)
    def wider(amount)
    def thinner(amount)
    def taller(amount)
    def shorter(amount)
```


### dimsome/mod_util.rb

```ruby
module Dimsome
  # so we can is_a?
  module Dim2d; end
  module Point; end
  module Size; end
  module Rect; end

  module ModUtil
    module Core
      # intended for internal use only:
      def raise_cannot_op(op, other, more="")
      def numeric_pair(other)
      def strict_numeric_pair(other)
      def strict_numeric_pair_pair(*args)
    
    module Pair
      include Core

      def inspect
      alias_method :to_s, :inspect
      def insp(digits=0)
        # TODO: digits is for how many digits precision to round to, currently ignored    
    
    module Rect
      include Core

      def inspect
      alias_method :to_s, :inspect
      def insp(digits=0)
        # TODO: digits is for how many digits precision to round to, currently ignored
```


## motion_dimsome/

### motion_dimsome/cg_dims_plus.rb

```ruby
module Dimsome
  module ATSCGSharePointDimsPlus
    # all mods expect:
    def to_ary()
  
  module CGSizeDimsPlus
    # all mods expect:
    def to_ary()
    
    def w=(v)
    def w()
    def h=(v)
    def h()
    def abs()
  
  module CGRectDimsPlus
    # all mods expect:
    def to_ary()
    def to_quad()
    
    def std()
      # to defeat Apple CGRect keeping neg size info
    def dup()
```
  

### motion_dimsome/dims_include_ios.rb

```ruby
# ios-only
# top level NOT module Dimsome
class CGPoint
  def self.make(*args)
class CGRect
```


### motion_dimsome/dims_include_osx.rb

```ruby
# osx-only
# top level NOT module Dimsome
class ATSPoint
  def self.make(*args)
  
class CGPoint
  def self.make(*args)
  
class CGRect
```


### motion_dimsome/dims_include.rb

```ruby
# top level NOT module Dimsome
class CGRect
  def self.make(*args)
  def self.empty()
  
class CGSize
  def self.make(*args)
  
class NSArray
  def cgp()
  def cgs()
  def cgr()
  def dim2d()
  def dimp()
  def dims()
  def dimr()
```


### motion_dimsome/mod_flipflop.rb

```ruby
module Dimsome
  # handful of methods for RubyMotion that accomodate the IOS top, left origin on IOS 
  # but keep bottom, left for OSX

  # ios, flop y: down is up, up is down
  module FlipFlopPointIOS
    def upi(amount)
    def downi(amount)

  module FlipFlopRectIOS
    # move
    def upi(amount)
    def downi(amount)
    
    # resize (adj position)
    def grow_upi(amount)
    def grow_downi(amount)
    def shrink_upi(amount)
    def shrink_downi(amount)
    
    # relative
    def abovei(further=nil)
    def belowi(further=nil)

    # grip
    def top_lefti(offset=nil)
    def top_centeri(offset=nil)
    def top_righti(offset=nil)
    def bottom_righti(offset=nil)
    def bottom_centeri(offset=nil)
    def bottom_lefti(offset=nil)

  # osx, leave it
  module FlipFlopPointOSX
    def upi(amount)
    def downi(amount)
    
  module FlipFlopRectOSX
    # move
    def upi(amount)
    def downi(amount)
    
    # resize (adj position)
    def grow_upi(amount)
    def grow_downi(amount)
    def shrink_upi(amount)
    def shrink_downi(amount)
    
    # relative
    def abovei(further=nil)
    def belowi(further=nil)

    # grip
    def top_lefti(offset=nil)
    def top_centeri(offset=nil)
    def top_righti(offset=nil)
    def bottom_righti(offset=nil)
    def bottom_centeri(offset=nil)
    def bottom_lefti(offset=nil)
```


## ruby_dimsome/

### ruby_dimsome/dim2d_bod.rb

```ruby
module Dimsome
  class RubyDim2d
    def pair()
    alias_method :to_ary, :pair
    alias_method :to_a, :pair
    def dup()
    def charge
    def self.make(*args)
    def initialize(one=nil, two=nil)
    def self.empty()
    def self.zero()
```

### ruby_dimsome/dims_include.rb

```ruby
module Dimsome
  module ArrayDimsPlus
    def dim2d()
    def dimp()
    def dims()
    def dimr()
    alias_method :cgp, :dimp
    alias_method :cgs, :dims
    alias_method :cgr, :dimr
  
# top level NOT module Dimsome
class Array
```


### ruby_dimsome/point_bod.rb

```ruby
module Dimsome
  class RubyPoint
    def x
    def x(value=nil)
    def y
    def y(value=nil)
```


### ruby_dimsome/rect_bod.rb

```ruby
module Dimsome
  class RubyRect
    def to_ary()
    def to_quad()
    def to_pair_pair()
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


### ruby_dimsome/size_bod.rb

```ruby
module Dimsome
  class RubySize
    def w
    def w(value=nil)
    def h
    def h(value=nil)
    alias_method :width, :w
    alias_method :width=, :w=
    alias_method :height, :h
    alias_method :height=, :h=  
```
