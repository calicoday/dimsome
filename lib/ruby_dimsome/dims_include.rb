# Actual reopening of Array to add conv constructor methods.
# motion_ has cg_dims_plus.rb modules grouping things but here it's very simple.

module Dimsome
	module ArrayDimsPlus
		def dim2d() Dimsome::RubyDim2d.make(*args) end
		def dimp() Dimsome::RubyPoint.make(*args) end
		def dims() Dimsome::RubySize.make(*args) end
		def dimr() Dimsome::RubyRect.make(*args) end
	
		# alias cg methods, so we can copy-paste???
		alias_method :cgp, :dimp
		alias_method :cgs, :dims
		alias_method :cgr, :dimr
	end 
end

class Array
	include Dimsome::ArrayDimsPlus
end
