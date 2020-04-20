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
