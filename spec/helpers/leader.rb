$give_greeting = true # set false to suppress debug $dimsome_greeting output
$test_cg_dims = true # set false to test Ruby dims under RubyMotion

class CGMake
	def self.dim2d(*args) CGSize.make(*args) end
	def self.point(*args) ATSCGSharePoint.make(*args) end
	def self.size(*args) CGSize.make(*args) end
	def self.rect(*args) CGRect.make(*args) end
end
class RubyMake
	include Dimsome unless $gtk || !defined?(NSObject)
	def self.dim2d(*args) RubyDim2d.make(*args) end
	def self.point(*args) RubyPoint.make(*args) end
	def self.size(*args) RubySize.make(*args) end
	def self.rect(*args) RubyRect.make(*args) end
end

# DragonRuby sets a $gtk global and we test it first bc it doesn't know defined? method
# (non-DragonRuby setting a $gtk is not a big stretch -- what else cd we do here???)
if $gtk 
	$test_cg_dims = false
	Make = RubyMake
	include Dimsome
	puts "Dragon! Dragon! Dragon! Ok, that's fine."
	$dimsome_greeting = "Hi, y'all!"
# we assume NSObject means cocoa therefore RubyMotion on AppleOS
elsif defined?(NSObject) 
	if $test_cg_dims
		Make = CGMake 
		$dimsome_greeting = "Aloha!!"
	else
		# Ruby dims under RubyMotion
		Make = RubyMake 
		$dimsome_greeting = "Salut!"
	end
# ok, mri ruby then
else
	$test_cg_dims = false
	Make = RubyMake
	require 'dimsome'
	include Dimsome
	$dimsome_greeting = "Wilkommen!"
end
