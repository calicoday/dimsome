module Dimsome
	module ModPoint
		# point-specific relatives
		def left(amount) compose([-amount, nil]) end
		def right(amount) compose([amount, nil]) end
		def up(amount) compose([nil, amount]) end
		def down(amount) compose([nil, -amount]) end
	end
end