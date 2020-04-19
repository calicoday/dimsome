# Actual reopening of the CGPoint (ios) class
# NOT in module Dimsome bc these are already existing classes at top level!!!

ATSCGSharePoint = CGPoint

class CGPoint
	include Dimsome::ATSCGSharePointDimsPlus
	include Dimsome::FlipFlopPointIOS
	extend Dimsome::ModUtil::Core
	#new?? make??
# 		def self.make(*args) CGPointMake(*args) end ### fix args!!! FIXME!!!

		def self.make(*args) #self.new(*args) end ### fix args!!! FIXME!!!
			one, two, _ = args
			pair = (one ? 
				(two ? strict_numeric_pair([one, two]) : strict_numeric_pair(one)) :
				[0, 0])		
			raise "#{self}.make bad args (#{one}, #{two})" unless pair
			CGPointMake(pair[0], pair[1])
# 			raise "#{self.class}#new bad args (#{[one, two]})" unless pair
# 			self.arr = pair
		end
end

class CGRect
	include Dimsome::FlipFlopRectIOS
end