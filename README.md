# Dimsome

Tagline: A gem of 2d arithmetic methods for basic dimension classes in RubyMotion/Ruby/DragonRuby-GTK.

Dimsome is a collection of convenience methods for 2d arithmetic and the basic dimension classes, such Point or Rect, to which they are added. For use with RubyMotion targeting AppleOS (ios, macos, tvos, etc), the methods are added to the Foundation SDK types CGPoint (ATSPoint for macos), CGSize and CGRect.

**Please note**: every part of the project (this Readme, docs, tests, organization, packaging) is in the rough, early stages. Most of the methods themselves I've been using in one way or another for well over a year but some garbling *may* have happened as I hacked things for different ruby platforms.

**Also**: heartfelt thanks to the author-contributors of the [Geomotion](https://rubygems.org/gems/geomotion/versions/0.15.0) gem ([github repo](https://github.com/clayallsopp/geomotion)). I had been picking at what became Dimsome for half a year before I stumbled on Geomotion. It's ios-only and I needed osx/bottom-left origin for SpriteKit work but it's a mature, working gem (with tests!) along very similar lines and gave me lots to play with while I settled what I really wanted. And in fact, ios-natural screen coordinates is something Dimsome (almost) totally doesn't do, so if that's what you need, go Geomotion.

Included in this repo:
- Dimsome code
- gemspec and including code to build a gem for RubyMotion or Ruby
- (RubyMotion) basic ios and osx app code (ie Rakefile, AppDelegate, etc), for experimenting with Dimsome in the RubyMotion REPL
- (DragonRuby-GTK) Ruby script dragonruby_cat.rb to cat the necessary Dimsome code plus tidbits into a single file for adding to DragonRuby-GTK projects (DragonRuby-GTK doesn't handle gems yet)
- (DragonRuby-GTK) Porkbelly, a Bacon/MacBacon testing module derivative for running the test files in DragonRuby-GTK.
- spec/ directory of test files to be run with RubyMotion's built-in MacBacon, rspec for Ruby, Porkbelly for DragonRuby-GTK.
- info/ directory of further documentation (setting doc/ aside currently, for exploring rdoc/yard generated docs)
- LICENSE, this README.md

Good to know:

- Dimsome runs in RubyMotion for AppleOS (no Android yet), Ruby (ie MRI-ish) and DragonRuby-GTK (ie mruby-ish)
- I'm overwhelmingly focussed on tools for sketching/experimenting, so Dimsome is not at all optimized for anything but easy typing. Could be later. We'll see.
- all methods but the simplest setters return a new not modified object.
- ALL coordinates are relative to a bottom-left origin, for all targets.
- rect is sized-rect, not kitty-rect (which is to say, an origin point and a size, not origin and farpoint).
- there are tests and they run on all targets (see Testing, DragonRuby-GTK_notes). There need to be more.
- the Grid and Twig classes included here are trivial and undocumented and probably belong somewhere else but I experiment with them a lot and I don't know what else to do with them yet.
- The name 'Dimsome' is just my shorthand for 'arithmetic for SOME DIMensionS'. In hindsight, I think it might've been a mistake because it sounds exactly like 'dimsum' and now arithmetic always makes me hungry. Sigh.



Jump to topic: 
- [Getting Started](getting-started)
- [Initializers and Inspectors](initializers-and-inspectors)
- [Classes Dim2d, Point, Size](simple-classes-dim2d-point-size-not-rect)
- [Class Rect](compound-class-rect)
- [Kludgey IOS-oriented methods](kludgey-ios-oriented-methods)
- [API Cheatsheet](api_cheatsheet.md)
- [Dimsome Testing](testing.md) and Porkbelly
- [To Do/Buglist](to-dobuglist)

## Installation

To build the gem:
```
gem build dimsome.gemspec
```

To install the (locally-built or downloaded) gem:
```
gem install ./dimsome-0.2.0.gem
```

DragonRuby-GTK doesn't currently support gem loading, so 'dragon_dimsome.rb' is created by a little ruby script `dragonruby_cat.rb` that cats all the necessary code into a single ruby file.

To install for DragonRuby-GTK, copy the dragon_dimsome/ directory into your project

## Usage

### RubyMotion

To use in a RubyMotion app, include in the Gemfile:

```ruby
gem 'dimsome'
```

and then `bundle install` or run using `bundle exec rake`.

To run the basic Dimsome app to experiment in the RubyMotion REPL on osx:

```ruby
bundle exec rake
```
or on ios:

```ruby
ios=true bundle exec rake
```
(one Rakefile here to launch in either ios or osx)

### Ruby

To use in Ruby (in a program or Pry, for instance):

```ruby
require 'dimsome'
```

### DragonRuby-GTK

To use in DragonRuby-GTK, add in your main.rb:

```ruby
require 'dragon_dimsome/dragon_dimsome.rb'
```

The sample/ project dragon_dimsome_demo is for running the test files (with the Porkbelly testing module) and shows the basic pattern.


## Getting Started

Dimsome was initially created for use with RubyMotion and the AppleOS Foundation data types CGPoint, CGSize and CGRect (which are Objective-C structs, wrapped in classes by RubyMotion). For other Ruby platforms, I created RubyPoint, RubySize and RubyRect (and then also made them available in RubyMotion just because). 

The basic classes are:
- RubyDim2d
- RubyPoint < RubyDim2d
- RubySize < RubyDim2d 
- RubyRect, composed of a RubyPoint and a RubySize

and for RubyMotion, the same methods are added to the built-in classes:
- CGPoint (or ATSPoint, in osx)
- CGSize
- CGRect (which is composed of a CGPoint and a CGSize)
	
Dimsome works entirely around the idea of a 'numeric pair', which is basically a 2-member array, each member of which is nil or a Numeric. A 'strict numeric pair' doesn't contain any nils. A 'numeric pairable' is any object that has a `to_ary` method that returns a numeric pair (eg all Dimsome classes except Rect/CGRect) or is a Numeric (indicating the value for *each* member, so 3 becomes [3, 3]).
	
See [API Cheatsheet](api_cheatsheet.md) for a list of available methods. Some examples of the most useful bits follow.

See [Testing](testing.md) for how to run the spec/ files, and about Porkbelly, the testing module for use in DragonRuby-GTK.

### Initializers and Inspectors

All the Dimsome classes have a `make` class method and an `inspect` instance method:

```ruby
dim2d = Dimsome::RubyDim2d.make(10, 15)
=> Dimsome::RubyDim2d(10, 15)
point = Dimsome::RubyPoint.make(20, 30)
=> Dimsome::RubyPoint(20, 30)
size = Dimsome::RubySize.make(120, 80)
=> Dimsome::RubySize(120, 80)
# RubyRect.make has a number of forms. These are all equivalent:
rect = Dimsome::RubyRect.make(20, 30, 120, 80)
rect = Dimsome::RubyRect.make([20, 30], [120, 80])
rect = Dimsome::RubyRect.make([20, 30, 120, 80])
rect = Dimsome::RubyRect.make(Dimsome::RubyPoint.make(20, 30), Dimsome::RubySize.make(120, 80))
=> Dimsome::RubyRect([20, 30], [120, 80]

```

and for RubyMotion, these as well:

```ruby
point = CGPoint(20, 30) # ios only
=> #<CGPoint x=20.0 y=30.0>
point = ATSPoint(20, 30) # osx only
=> #<ATSPoint x=20.0 y=30.0>
size = CGSize.make(120, 80)
=> #<CGSize width=120.0 height=80.0>
rect = CGRect.make(20, 30, 120, 80)
rect = CGRect.make([20, 30], [120, 80])
rect = CGRect.make([20, 30, 120, 80])
rect = CGRect.make(CGPoint.make(20, 30), CGSize.make(120, 80))
=> #<CGRect origin=#<ATSPoint x=20.0 y=30.0> size=#<CGSize width=120.0 height=80.0>>

```

[snag: CGPoint.make won't work on osx, though CGPoint exists on osx. FIXME!!!]

Alternatively, you can use the convenience methods `dim2d`, `dimp`, `dims` and `dimr` added to Array:

```ruby
dim2d = [10, 15].dim2d
=> Dimsome::RubyDim2d(10, 15)
point = [20, 30].dimp
=> Dimsome::RubyPoint(20, 30)
size = [120, 80].dims
=> Dimsome::RubySize(120, 80)
rect = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
```

And for RubyMotion, `cgp`, `cgs` and `cgr`:

```ruby
point = [20, 30].cgp
=> #<ATSPoint x=20.0 y=30.0>
size = [120, 80].dims
=> #<CGSize width=120.0 height=80.0>
cgrect = [20.158, 30.875, 120.6666666, 80].cgr
=> #<CGRect origin=#<ATSPoint x=20.158 y=30.875> size=#<CGSize width=120.6666666 height=80.0>>
```

Each class also an `insp` instance method, which gives a shorter description, rounding the values to the nearest whole number:

```ruby
[10, 15].dim2d.insp
=> "RubyDim2d~(10, 15)"
[20, 30].dimp.insp
=> "RubyPoint~(20, 30)"
[120, 80].dims.insp
=> "RubySize~(120, 80)"
[20, 30, 120, 80].dimr.insp
=> "RubyRect~([20, 30], [120, 80]"
[4.56678999, 8.7765442].dimp.insp
```

And for RubyMotion:

```ruby
=> "RubyPoint~(5, 9)"
[4.56678999, 8.7765442].cgp.insp
=> "ATSPoint~(5, 9)"
CGRect.make(20.158, 30.875, 120.6666666, 80).insp
=> "CGRect~([20, 31], [121, 80])"
```

(I'm going to just note the plain Ruby form examples from here on).


### Simple Classes Dim2d, Point, Size (not Rect)

There are getter methods for the instance variables `x` and `y` (for Point) and `width`/`w` and `height`/`h` (for Size).

Setting instance variables by using `x=` and `y=` (for Point) and `width=`/`w=` and `height=`/`h=` (for Size) returns the new value.

Passing a value to `x` and `y` (for Dim2d, Point) and `width`/`w` and `height`/`h` (for Size) creates a new object of the same class, sets the value and returns it for chaining:

```ruby
p = [3, 4].dimp
=> Dimsome::RubyPoint(3, 4)
p.x
=> 3
p.x = 7
=> 7
p
=> Dimsome::RubyPoint(7, 4)
p.x(9)
=> Dimsome::RubyPoint(9, 4)
p
=> Dimsome::RubyPoint(7, 4)
```

(Note the chaining setters aren't currently implemented for CGPoint, CGSize)

Basic unary operators/methods `-`, `abs`, `empty?`, `diagonal`, `rough_diagonal` and `angle`:

```ruby
p = [3, 4].dimp
=> Dimsome::RubyPoint(3, 4)
negative_p = -p
=> Dimsome::RubyPoint(-3, -4)
negative_p.abs
=> Dimsome::RubyPoint(3, 4)
p.empty?
=> false
[0, 0].dimp.empty?
=> true
p.diagonal
=> 5.0
p.rough_diagonal
=> 25
p.angle
=> 0.9272952180016122

```

Basic binary operators/methods `+`, `-`, `*` and `/` take a single parameter, a Numeric or numeric pairable, and return a new object of the same class for chaining:

```ruby
p = [3, 4].dimp
=> Dimsome::RubyPoint(3, 4)
p * 2
=> Dimsome::RubyPoint(6, 8)
p * [2, nil]
=> Dimsome::RubyPoint(6, 4)
p * [2, nil] + 3
=> Dimsome::RubyPoint(9, 7)
(p + 3) * [2, nil]
=> Dimsome::RubyPoint(12, 7)
```

(Note `p + 3 * [2, nil]` without the parens will raise because because the `*` will get applied first and ruby won't be able to coerce the Array to something that 3 can multiply).

And methods `==`, `round`, `angle_to` and `within_radius?`:

```ruby
p = [3, 4].dimp
=> Dimsome::RubyPoint(3, 4)
p == [3, 4].dimp
=> true
detailed_p = [3.36768, 4.1234987].dimp
=> Dimsome::RubyPoint(3.36768, 4.1234987)
detailed_p.round
=> Dimsome::RubyPoint(3, 4)
p.angle_to([0, 0])
=> 0.9272952180016122
p.angle_to([70, -5])
=> 3.008063604497922
p.within_radius?(5)
=> true
p.within_radius?(4)
=> false
```

Specialized methods `left`, `right`, `up` and `down` (for Point) and `grow`, `shrink`, `wider`, `thinner`, `taller` and `shorter` (for Size) take only a Numeric and return a new object of the same class for chaining:

[narrower!!!]

```ruby
p = [3, 4].dimp
=> Dimsome::RubyPoint(3, 4)
p.right(2).up(4)
=> Dimsome::RubyPoint(5, 8)
s = [20, 30].dims
=> Dimsome::RubySize(20, 30)
s.grow(5)
=> Dimsome::RubySize(25, 35)
s.taller(20).wider(20).shrink(15)
=> Dimsome::RubySize(25, 35)

```


### Compound Class Rect

Rect is a compound of 2 'numeric pairable' objects, a point `origin` (with x and y values) and a size `size` (with width and height values). 

[to_ary, to_pair, to_pair_pair and starburst!!!]

A 'waypoint' is a point some way into the Rect. :-) Which is a say, a point whose x and y values are between 0 and the Rect's width and height, respectively. A 'grip' is a point in the Rect in terms of the Rect's parent's coordinate system (ie a waypoint plus the Rect's origin). So moving a Rect by some amount will change the value of any grip by the same amount.

A 'spread' is a unit vector for a waypoint or grip (ie with values between 0 and 1). A 'named spread' is a spread by one of the preset names `:center`, `:top_left`, `:top_center`, `:top_right`, `:center_right`, `:bottom_right`, `:bottom_center`, `:bottom_left` and `:center_left` (and for single edge/direction `:left`, `:right`, `:top` and `:bottom`)


```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.waypoint([0.5, 0.5])
=> Dimsome::RubyPoint(60.0, 40.0)
r.waypoint(:center)
=> Dimsome::RubyPoint(60.0, 40.0)
r.grip([0.5, 0.5])
=> Dimsome::RubyPoint(80.0, 70.0)
r.grip(:center)
=> Dimsome::RubyPoint(80.0, 70.0)
r.right(20)
=> Dimsome::RubyRect([40, 30], [120, 80])
r.right(20).grip(:center)
=> Dimsome::RubyPoint(100.0, 70.0)
```


#### Accessors

There are direct getter methods for the instance variables `x` and `y` (of the `origin`) and `width`/`w` and `height`/`h` (of the `size`).

Directly setting instance variables by using `x=` and `y=` (for Point) and `width=`/`w=` and `height=`/`h=` (for Size) returns the new value.

Passing a value to `x` and `y` (for Dim2d, Point) and `width`/`w` and `height`/`h` (for Size) creates a new object of the same class, sets the value and returns it for chaining:

```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.x
=> 20
r.x = 7
=> 7
r
=> Dimsome::RubyRect([7, 30], [120, 80])
r.x(9)
=> Dimsome::RubyRect([9, 30], [120, 80])
r
=> Dimsome::RubyRect([7, 30], [120, 80])
```

[Rect ought to but doesn't currently take `+`, `-` for moving, `*`, `/` for scaling. FIXME!!!]


#### Rect relative methods

Methods `left`, `right`, `up` and `down` take a Numeric and return a new Rect with same size, adjusted position:

```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.right(30)
=> Dimsome::RubyRect([50, 30], [120, 80])
```
	
Methods `above`, `below`, `before` and `after` take an optional Numeric offset and return a new Rect with the same size, adjusted position (right next to the original, plus any given offset):

```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.above
=> Dimsome::RubyRect([20, 110], [120, 80])
r.after(10)
=> Dimsome::RubyRect([150, 30], [120, 80])
```

Methods `grow`, `shrink`, `wider`/`thicker`, `narrower`/`thinner`, `taller`, `shorter` take a Numeric amount and optional spread (default `[0, 0]`, so from the center) and create a new Rect with adjusted size and position adjusted according to the given spread:
	
```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.wider(30)
=> Dimsome::RubyRect([20.0, 30.0], [150, 80])
> r.wider(30, [0, 0])
=> Dimsome::RubyRect([20, 30], [150, 80])
> r.wider(30, [0.5, 0.5])
=> Dimsome::RubyRect([5.0, 30.0], [150, 80])
[r.origin, r.size].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
[r.origin, r.size.wider(30)].dimr
=> Dimsome::RubyRect([20, 30], [150, 80])
```

(Note the default will almost certainly be changing to `[0.5, 0.5]`, so from the center).

Methods `grow_left`, `grow_right`, `grow_up`, `grow_down`, `shrink_left`, `shrink_right`, `shrink_up`, `shrink_down` take a Numeric amount:

```ruby
r.grow_left(20)
=> Dimsome::RubyRect([0.0, 30], [140, 80])
r.shrink_up(10)
=> Dimsome::RubyRect([20, 40.0], [120, 70])

```


#### Rect grip/waypoint methods


Methods `center`, `top_left`, `top_center`, `top_right`, `center_right`, `bottom_right`, `bottom_center`, `bottom_left`, `center_left` take an optional numeric pairable offset (default `[0, 0]`) and return the position in the Rect's parent coordinate system as a new Point object:

```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.bottom_left
=> Dimsome::RubyPoint(20.0, 30.0)
r.bottom_left(10)
=> Dimsome::RubyPoint(30.0, 40.0)
r.bottom_left([10, nil])
=> Dimsome::RubyPoint(30.0, 30.0)
r.top_right
=> Dimsome::RubyPoint(140.0, 110.0)
```

The more general `grip` method takes an optional spread or named spread (default `:bottom_left`), an optional numeric pairable offset (default `[0, 0]`) and returns the position in the Rect's parent's coordinate system as a new Point object:

```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.grip(:bottom_left)
=> Dimsome::RubyPoint(20, 30)
r.grip([0, 0], [10, nil])
=> Dimsome::RubyPoint(30.0, 30.0)
```

The `waypoint` method takes spread or named spread and an optional numeric pairable offset (default [0, 0]) and returns the position within the Rect as a new Point object:

```ruby
r = [20, 30, 120, 80].dimr
=> Dimsome::RubyRect([20, 30], [120, 80])
r.waypoint(:bottom_left)
=> Dimsome::RubyPoint(0, 0)
r.waypoint([0, 0], [10, nil])
=> Dimsome::RubyPoint(10, 0)
r.waypoint(:center)
=> Dimsome::RubyPoint(60, 40)
```

### Kludgey IOS-oriented methods

Super temporarily, a handful of methods have been added for RubyMotion that DO accomodate the IOS top, left origin on IOS but keep bottom, left for OSX: `upi` and `downi` (for CGPoint), `upi`, `downi`, `grow_upi`, `grow_downi`, `shrink_upi`, `shrink_downi`, `abovei`, `belowi`, `top_lefti`, `top_centeri`, `top_righti`, `bottom_righti`, `bottom_centeri` and `bottom_lefti` (for CGRect)


### To Do/Buglist

- make a To Do/Buglist