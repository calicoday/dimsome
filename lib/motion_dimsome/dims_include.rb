# Actual reopening of the CG classes, separate files for CGPoint (ios), ATSPoint (osx)
# NOT in module Dimsome bc these are already existing classes at top level!!!

class CGRect
	include Dimsome::CGRectDimsPlus
	extend Dimsome::ModUtil::Core

	def self.make(*args) #self.new(*args) end ### fix args!!! FIXME!!!
# 	def initialize(*args)
		# do we ever want to keep Point, Size passed in or always copy???
		one, two = (args.empty? ? [[0, 0], [0, 0]] : strict_numeric_pair_pair(*args))
		raise "#{self}.make bad args (#{args})" unless one && two #&& two redun
		CGRectMake(one[0], one[1], two[0], two[1])
	end

# 		def self.make(*args) 
# 			args.length > 0 ? CGRectMake(*args) : CGRectMake(0, 0, 0, 0)
# 		end ### fix args!!! FIXME!!!
# 		def self.make(*args) CGRectMake(*args) end ### fix args!!! FIXME!!!
		# how about class empty for all Rects??? FIXME!!!
		def self.empty() self.make(0, 0, 0, 0) end
end

class CGSize
	include Dimsome::CGSizeDimsPlus
	extend Dimsome::ModUtil::Core
	#new?? make??
# 		def self.make(*args) CGPointMake(*args) end ### fix args!!! FIXME!!!

		def self.make(*args) #self.new(*args) end ### fix args!!! FIXME!!!
			one, two, _ = args
			pair = (one ? 
				(two ? strict_numeric_pair([one, two]) : strict_numeric_pair(one)) :
				[0, 0])		
			raise "#{self}.make bad args (#{one}, #{two})" unless pair
			CGSizeMake(pair[0], pair[1])
# 			raise "#{self.class}#new bad args (#{[one, two]})" unless pair
# 			self.arr = pair
		end
# 		def self.make(*args) CGSizeMake(*args) end ### fix args!!! FIXME!!!
end

### elsewhere???
# class Array
# 	include Dimsome::ArrayDimsPlus
# end

class NSArray
# 	def self.dim2d(*args) CGSize.make(*args) end
	def cgp() CGPoint.make(*args) end
# 	def cgp() ATSCGSharePoint.make(*args) end
	def cgs() CGSize.make(*args) end
	def cgr() CGRect.make(*args) end

	def dim2d() Dimsome::RubyDim2d.make(*args) end
	def dimp() Dimsome::RubyPoint.make(*args) end
	def dims() Dimsome::RubySize.make(*args) end
	def dimr() Dimsome::RubyRect.make(*args) end

end

=begin
class NSArray
	# in rubymotion apps, cgx is better bc you need to know you're doing CG types!!!
	def cg() "go cg!!!" end
	def cgp() cgo(:point) end
	def cgs() cgo(:size) end
	def cgr() cgo(:rect) end
	def cgo(type=:point)
		case type
		when :size, :s
			CGSizeMake(self[0], self[1])
# 			CGSizeMake(*[self[0], self[1]])
		when :rect, :r
			CGRectMake(self[0], self[1], self[2], self[3])
# 			flat = self.flatten
# 			CGRectMake(*[flat[0], flat[1], flat[2], flat[3]])
		else #:point
			CGPointMake(self[0], self[1])
# 			CGPointMake(*[self[0], self[1]])
		end
	end
	# gems depending on dimsome will use these:
	# rem: alias_method :alias_name, :defd_name
	def dim() "go dim #{self.inspect}!!!" end # why do we even have this???!!! FIXME!!!
	alias_method :dim2d, :cgp
	alias_method :dimp, :cgp
	alias_method :dims, :cgs
	alias_method :dimr, :cgr
	alias_method :dimo, :cgo
# 		def dim2d() dimo(:dim2d) end #nec???
# 		def dimp() dimo(:point) end
# 		def dims() dimo(:size) end
# 		def dimr() dimo(:rect) end
end
=end