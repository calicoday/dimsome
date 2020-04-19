module Dimsome

	class RubyDim2d
		include Dim2d
		include ModUtil::Pair
		include ModArith

		attr_accessor :arr
	
		def pair() [arr[0], arr[1]] end
		alias_method :to_ary, :pair
		alias_method :to_a, :pair
	
		def dup() self.class.new(*arr) end
	# 	def dup() self.class.new(self) end ###???

		def charge
			[arr[0] == 0 ? 0 : (arr[0] > 0 ? 1 : -1),
				arr[1] == 0 ? 0 : (arr[1] > 0 ? 1 : -1)]
	# 		[arr[0] == 0 ? 0 : arr[0]/arr[0].abs,
	# 			arr[1] == 0 ? 0 : arr[1]/arr[1].abs]
		end

		def self.make(*args) self.new(*args) end ### fix args!!! FIXME!!!

		def initialize(one=nil, two=nil)
			pair = (one ? 
				(two ? strict_numeric_pair([one, two]) : strict_numeric_pair(one)) :
				[0, 0])		
			raise "#{self.class}#new bad args (#{one}, #{two})" unless pair
			self.arr = pair
		end

		def self.empty() self.new(0, 0) end
# 		def self.empty() self.class.new(0, 0) end
# 		def empty?() arr[0] == 0 && arr[1] == 0 end
	# 	alias_method :zero, :empty
		def self.zero() self.empty end
	end
end
