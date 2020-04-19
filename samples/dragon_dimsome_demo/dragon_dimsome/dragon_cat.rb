####
# This script cats all the necessary Dimsome code into a single file dragon_dimsome.rb.
#
# from WITHIN dragon_dimsome/, run this like:
# ruby dragon_cat.rb
####

srcfiles = [
	'../lib/dimsome/mod_util.rb',
	'../lib/dimsome/mod_arith.rb',
	'../lib/dimsome/mod_point.rb',
	'../lib/dimsome/mod_size.rb',
	'../lib/dimsome/mod_rect_relative.rb',
	'../lib/dimsome/mod_rect_grip.rb',
	'../lib/dimsome/mod_rect_accessors.rb',
	'../lib/dimsome/mod_rect_apply.rb',
	'../lib/dimsome/grid.rb',
	'../lib/dimsome/twig.rb',
	'../lib/ruby_dimsome/dim2d_bod.rb',
	'../lib/ruby_dimsome/point_bod.rb',
	'../lib/ruby_dimsome/size_bod.rb',
	'../lib/ruby_dimsome/rect_bod.rb',
	'../lib/ruby_dimsome/dims_include.rb',
]

File.open("dragon_dimsome.rb", "w+") do |f|
	f.puts <<-HEREDOC
# Some sort of comment here.

class Array
	def to_ary() to_a end
end
module Kernel
	alias __callee__ __method__ if $gtk
# 	def defined?(v) Kernel.const_defined?(v.to_sym) end
end

	HEREDOC

  srcfiles.each do |e| 
  	stuff = File.read(e)
  	f.puts(stuff)
  	f.puts
  end
end
