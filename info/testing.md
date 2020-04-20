# Dimsome Testing

This first bit about Porkbelly is likely the only section of possible interest to people who aren't me. The rest is a note for when I forget how to run tests on different ruby platforms in different configs to spot what I break when I have to reorganize something.

## DragonRuby-GTK and Porkbelly

I wanted to be able to run in DragonRuby-GTK the same test files I had already written for RubyMotion, so I created a testing module called Porkbelly by cobbling together only the most basic bits from various versions of Bacon/MacBacon (the testing module built into RubyMotion). The main differences between the original Bacon/MacBacon and Porkbelly are:
- DragonRuby-GTK doesn't currently handle regexes, so no match predicate, restricting names or contexts, etc
- Bacon didn't nest the output of nested contexts, so it wasn't matching my RubyMotion results
- MacBacon gathers the top-level contexts into an array, then runs them (allowing scheduling, etc) but that was getting SystemStackError (stack too deep) in DragonRuby-GTK, so I simplified it for now. The tests are just run as they are read.

Porkbelly.rb is in the dragon_dimsome/ directory that you copy to your DragonRuby-GTK project. The sample/ project dragon_dimsome_demo shows the necessary `require`-ing. As for how to write the test _spec files, the [README for the original Bacon](https://github.com/leahneukirchen/bacon) is the best hint, though only the default output format is implemented and you may find some of the features don't work (besides those mentioned above). I haven't (intentionally) cut any other features but I've only run Dimsome tests and Bacon's 'Whirl-wind tour' thus far. Will do better. Soonish.


I'm keen to use Porkbelly to explore fleshing out the options/platforms with different modular architextures but right now, all it does for sure is give the same results for the tests I have.

**Except** the parallel assignment tests for Dim2d, Point, Size and Rect fail because DragonRuby-GTK is mruby-based -- parallel assignment *does* work but you have to starburst it:

```ruby
x, y = [3, 4].dimp
=> Dimsome::Point(3, 4)
x
=> Dimsome::Point(3, 4)
y
=> 
x, y = *[3, 4].dimp
=> [3, 4]
x
=> 3
y
=> 4
```

### Results

From the DragonRuby-GTK directory (with dragon_dimsome_demo/ copied there):

```ruby
$ ./dragonruby dragon_dimsome_demo --no-tick
[...]
200 specifications (220 requirements), 6 failures, 0 errors
```

just the 5 `to_ary` parallel assignment tests and the whirlwind_spec 'should have super powers' fail.


## RubyMotion and built-in MacBacon


### Results for OSX

(with $test_cg_dims = true or false)

```ruby
$ bundle exec rake spec
[...]
200 specifications (225 requirements), 1 failures, 0 errors
```

just the whirlwind_spec 'should have super powers' fails.



### Results for IOS

(with $test_cg_dims = true or false)

```ruby
$ ios=true bundle exec rake spec 
[...]
200 specifications (225 requirements), 1 failures, 0 errors
```

just the whirlwind_spec 'should have super powers' fails.



## RubyMotion and Porkbelly

Problematic because there are clashes with the built-in Bacon. In particular, both RubyMotion and Porkbelly add #describe to Kernel and #should to Object and I think RubyMotion's Bacon is getting loaded second. Not sure what I can do about this. It's possible to test something analogous by creating a variation on Porkbelly and matching _spec files that use 'say' for 'describe' and 'oughta' for 'should', for example.


## Ruby and RSpec

RSpec automatically looks in the project lib/ directory, so to be sure you're testing an installed gem not source files, delete the lib/ directory from the RSpec $LOAD_PATH in the rspec_helper.rb (or rename the lib/ directory to lib-hide/, or something)

### Results

```ruby
$ rspec
[...]
FFFFFF..................................................................................................................................................................................................

Failures:

  1) A new array should be empty
     Failure/Error: @ary.should.be.empty
     
     NoMethodError:
       undefined method `be' for #<RSpec::Matchers::BuiltIn::PositiveOperatorMatcher:0x00007fbc46056e50>
     # ./spec/whirlwind_spec.rb:9:in `block (2 levels) in <top (required)>'
[...]
```

all problems with the whirlwind_spec use of Bacon not RSpec syntax. [See if rspec options can remedy this!!!]


## Ruby and Porkbelly

### Results

```ruby
$ ruby dragon_dimsome/run_porkbelly.rb
[...]
200 specifications (225 requirements), 1 failures, 0 errors
```
just the whirlwind_spec 'should have super powers'.



## Testing Local Files (pre-gem)

- RubyMotion needs the spec files added to the rakefile (without `spec` option, it won't automatically add the contents of the spec/ directory
- comment out `gem 'dimsome'` in the Gemfile
- make sure NOT to delete the lib/ directory from the RSpec $LOAD_PATH in the rspec_helper.rb
