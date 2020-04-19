module Dimsome
	# so we can is_a?
	module Dim2d; end
	module Point; end
	module Size; end
	module Rect; end
	
  # General utility methods
	module ModUtil
		# Core utility methods for all Dimsome classes
		module Core
			# Raise an exception with the name of the current operator and operand and 
			#		optional details.
			#
			# @example 
			#   a_point.raise_cannot_op('+', a_string_var) 
			#			#=> "Point can't + given String"
			#
			# @param op [String] operator name
			# @param other [Object] operand name
			# @param more [String] (optional) details # unused!!!
			# @return none
			def raise_cannot_op(op, other, more="")
				raise "#{self.class.name} can't #{op} given #{other ? other.inspect : 'nil'} #{more}"
			end

			# Converts object to a numeric pair.
			#
			# @example 
			#   numeric_pair(3) #=> [3, 3]
			#   numeric_pair([3, nil]) #=> [3, nil]
			#   numeric_pair(Point.new(4, 5)) #=> [4, 5]
			#   numeric_pair("some string") #=> nil
			#
			# @param other [Numeric, Array, numpairable] a single Numeric or an object that
			#		can be converted to a numeric pair.
			# @return [Array, nil] an Array that is a numeric pair or nil
			def numeric_pair(other)
	# 			return [other, other] if other.is_a?(Numeric)
				return [other, other] if (other.is_a?(Numeric) || other.nil?)
# 				puts "=== && other: other, #{other.inspect}"
				a = other.to_ary if other.respond_to?(:to_ary)
				return nil unless a && a.length > 1
				[(a[0] && a[0].is_a?(Numeric) ? a[0] : nil),
					(a[1] && a[1].is_a?(Numeric) ? a[1] : nil)]
			end

			# Converts object to a strict numeric pair, ie a 2-member Array of Numerics 
			#		(not nil).
			# @see #numeric_pair
			# @example 
			#   numeric_pair(3) #=> [3, 3]
			#   numeric_pair([3, nil]) #=> nil # This example differs!
			#   numeric_pair(Point.new(4, 5)) #=> [4, 5]
			#   numeric_pair("some string") #=> nil
			#
			# @param other [Numeric, Array, numpairable] a single Numeric or an object that
			#		can be converted to a numeric pair.
			# @return [Array, nil] an Array that is a numeric pair or nil
			def strict_numeric_pair(other)
				return nil unless pair = numeric_pair(other)
				(pair[0].nil? || pair[1].nil?) ? nil : pair
			end

			def strict_numeric_pair_pair(*args)
				one, two, quad = nil, nil, nil
				case args.length
				when 4 
					quad = args
				when 1 
					return nil unless args[0].respond_to?(:to_ary)
					quad = args[0].to_ary[0..3]
				end
				# strict_numeric_pair is instance method!!! FIXME!!!
				one = strict_numeric_pair(quad ? [quad[0], quad[1]] : args[0])
				two = strict_numeric_pair(quad ? [quad[2], quad[3]] : args[1])
				return nil unless one && two
				[one, two]
			end

		end #module Core
		
		# Utility methods for Dimsome 2-value Pair classes, ie Dim2d, Point, Size
		module Pair
			include Core

			def inspect
				a = to_ary
				"#{self.class.name}(#{a[0]}, #{a[1]})"
			end
			alias_method :to_s, :inspect
			### TMP!!! Float#round can't take arg!!! FIXME!!!
			def insp(digits=0)
				# chop Dimsome:: from name??? FIXME!!!
				a = to_ary
				name = self.class.name.split(':').last
				"#{name}~(#{a[0].round}, #{a[1].round})"
# 				"#{self.class.name}~(#{a[0].round}, #{a[1].round})"
		#     "#{self.class.name}~(#{arr[0].round(digits)}, #{arr[1].round(digits)})"
			end

		end #module Pair

		# Utility methods for Dimsome 4-value Rect classes
		module Rect
			include Core
			
			# expects supplied to_ary as [origin, size], to_quad as [x, y, w, h]
			def inspect
				x, y, w, h = to_quad
				"#{self.class.name}([#{x}, #{y}], [#{w}, #{h}])"
			end
			alias_method :to_s, :inspect
			### TMP!!! Float#round can't take arg!!! FIXME!!!
			def insp(digits=0)
				x, y, w, h = to_quad
				name = self.class.name.split(':').last
				"#{name}~([#{x.round}, #{y.round}], [#{w.round}, #{h.round}])"
# 				"#{self.class.name}~([#{x.round}, #{y.round}], [#{w.round}, #{h.round}])"
			end
		end #module Rect
	end #module ModUtil
end #module Dimsome