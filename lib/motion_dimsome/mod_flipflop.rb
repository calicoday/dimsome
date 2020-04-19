### for now, JUST add relative -y methods for rubymotion ios!!!

module Dimsome
	# ios, flop y: down is up, up is down
	module FlipFlopPointIOS
		def upi(amount) down(amount) end
		def downi(amount) up(amount) end
	end
	
	module FlipFlopRectIOS
		# accessors??? used internally???
		# move
		def upi(amount) down(amount) end
		def downi(amount) up(amount) end
		# resize (adj position)
		def grow_upi(amount) grow_down(amount) end
		def grow_downi(amount) grow_up(amount) end
		def shrink_upi(amount) shrink_down(amount) end
		def shrink_downi(amount) shrink_up(amount) end
		# relative
		def abovei(further=nil) below(further) end
		def belowi(further=nil) above(further) end
		# grip
# 		def centeri(offset=nil center(offset) end
		def top_lefti(offset=nil) bottom_left(offset) end
		def top_centeri(offset=nil) bottom_center(offset) end
		def top_righti(offset=nil) bottom_right(offset) end
# 		def center_righti(offset=nil) center_right(offset) end
		def bottom_righti(offset=nil) top_right(offset) end
		def bottom_centeri(offset=nil) top_center(offset) end
		def bottom_lefti(offset=nil) top_left(offset) end
# 		def center_lefti(offset=nil) center_left(offset) end
	end
	
	# osx, leave it
	module FlipFlopPointOSX
		def upi(amount) up(amount) end
		def downi(amount) down(amount) end
	end
	module FlipFlopRectOSX
		### accessors, eg maxy???
		# move
		def upi(amount) up(amount) end
		def downi(amount) down(amount) end
		# resize (adj position)
		def grow_upi(amount) grow_up(amount) end
		def grow_downi(amount) grow_down(amount) end
		def shrink_upi(amount) shrink_up(amount) end
		def shrink_downi(amount) shrink_down(amount) end
		# relative
		def abovei(further=nil) above(further) end
		def belowi(further=nil) below(further) end
		# grip
# 		def centeri(offset=nil) center(offset) end
		def top_lefti(offset=nil) top_left(offset) end
		def top_centeri(offset=nil) top_center(offset) end
		def top_righti(offset=nil) top_right(offset) end
# 		def center_righti(offset=nil) center_right(offset) end
		def bottom_righti(offset=nil) bottom_right(offset) end
		def bottom_centeri(offset=nil) bottom_center(offset) end
		def bottom_lefti(offset=nil) bottom_left(offset) end
# 		def center_lefti(offset=nil) center_left(offset) end
	end

	# add stub -y methods for all others, for all -y coding??? but that wd be -x!!! bah.
	module FlipFlopPointStub
	end
	module FlipFlopRectStub
	end
	
end