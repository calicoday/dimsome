# Actual reopening of the ATSPoint (osx) class
# NOT in module Dimsome bc these are already existing classes at top level!!!

ATSCGSharePoint = ATSPoint

class ATSPoint
	include Dimsome::ATSCGSharePointDimsPlus
	include Dimsome::FlipFlopPointOSX
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
class CGPoint
	def self.make(*args) ATSPoint.make(*args) end
end

class CGRect
	include Dimsome::FlipFlopRectOSX
end