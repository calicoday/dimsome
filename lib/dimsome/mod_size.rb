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