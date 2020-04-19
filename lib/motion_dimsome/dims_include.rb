# Actual reopening of the CG classes, separate files for CGPoint (ios), ATSPoint (osx)
# NOT in module Dimsome bc these are already existing classes at top level!!!

class CGRect
	include Dimsome::CGRectDimsPlus
	extend Dimsome::ModUtil::Core

	def self.make(*args)
		# do we ever want to keep Point, Size passed in or always copy???
		one, two = (args.empty? ? [[0, 0], [0, 0]] : strict_numeric_pair_pair(*args))
		raise "#{self}.make bad args (#{args})" unless one && two #&& two redun
		CGRectMake(one[0], one[1], two[0], two[1])
	end

	def self.empty() self.make(0, 0, 0, 0) end
end

class CGSize
	include Dimsome::CGSizeDimsPlus
	extend Dimsome::ModUtil::Core

	def self.make(*args) 
		one, two, _ = args
		pair = (one ? 
			(two ? strict_numeric_pair([one, two]) : strict_numeric_pair(one)) :
			[0, 0])		
		raise "#{self}.make bad args (#{one}, #{two})" unless pair
		CGSizeMake(pair[0], pair[1])
	end
end

class NSArray
	def cgp() CGPoint.make(*args) end
	def cgs() CGSize.make(*args) end
	def cgr() CGRect.make(*args) end

	def dim2d() Dimsome::RubyDim2d.make(*args) end
	def dimp() Dimsome::RubyPoint.make(*args) end
	def dims() Dimsome::RubySize.make(*args) end
	def dimr() Dimsome::RubyRect.make(*args) end
end
