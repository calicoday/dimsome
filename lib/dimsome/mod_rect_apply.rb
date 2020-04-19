module Dimsome
	module ModRectApply 
	
		# apply calls methods, rather than each method calling poss unnec apply with 
		# giant switch
		def apply(options)
			# CGRectStandardize returns a copy, surely???
			rect = self.std
			return rect unless options && !options.empty?
			
			### we return a copy but we tweak the copy's values directly!!!
			# don't use rect conv methods but origin, size here!!!
			
			# sift for redundant/overlapping settings!!! FIXME!!!
			
			### y, orient???
		
			options.each do |key, value|
				# vet value is Numeric, unless for origin, size!!! FIXME!!!
				case key
				# props

				# value MUST be num_pair or Point!!!
				when :origin #then rect.origin = value ### CG-specific!!! does this work???
					pair = numeric_pair(value)
	        rect.origin = rect.origin.class.make(pair)
# 	        rect.origin = rect.origin.class.new(pair)
				when :size #then rect.size = value  ### CG-specific!!! does this work???
					pair = numeric_pair(value)
	        rect.size = rect.size.class.make(pair)
# 	        rect.size = rect.size.class.new(value)
	
				when :x #then rect.x = value
					rect.origin.x = value
				when :y #then rect.y = value
					rect.origin.y = value
				when :width, :w #then rect.w = value
					rect.size.w = value
				when :height, :h #then rect.h = value
					rect.size.h = value
			
				# position
				when :left #then rect.left(value) ### can we go with these???
					rect.origin.x -= value
				when :right #then rect.right(value)
					rect.origin.x += value
				when :up #then rect.up(value)
					rect.origin.y += value
				when :down #then rect.down(value)
					rect.origin.y -= value

				# size
				when :grow
					rect.size.w += value
					rect.origin.x -= value * 0.5 #value/2.0
					rect.size.h += value
					rect.origin.y -= value * 0.5
# 					rect.size.w += value + value
# 					rect.size.h += value + value
# 					rect.origin.x -= value
# 					rect.origin.y -= value
				when :shrink
					rect.size.w -= value
					rect.origin.x += value * 0.5
					rect.size.h -= value
					rect.origin.y += value * 0.5
# 					rect.size.w -= value + value
# 					rect.size.h -= value + value
# 					rect.origin.x += value
# 					rect.origin.y += value
		
				when :wider, :grow_width
					rect.size.w += value
					rect.origin.x -= value * 0.5 #value/2.0
				when :taller, :grow_height
					rect.size.h += value
					rect.origin.y -= value * 0.5

				when :grow_right
					rect.size.w += value
				when :grow_left
					rect.size.w += value
					rect.origin.x -= value
					
				when :grow_up
					rect.size.h += value
				when :grow_down
					rect.size.h += value
					rect.origin.y -= value
					
				when :narrower, :shrink_width, :thinner ###geom name!!!
					rect.size.w -= value
					rect.origin.x += value * 0.5
				when :shorter, :shrink_height
					rect.size.h -= value
					rect.origin.y += value * 0.5
					
				when :shrink_left
					rect.size.w -= value
				when :shrink_right
					rect.size.w -= value
					rect.origin.x += value
					
				when :shrink_down
					rect.size.h -= value
				when :shrink_up
					rect.size.h -= value
					rect.origin.y += value

				#else #???
				end
			end
			
			rect
		end  
	
	# 	def flipflop(orient=[1,1], &b)
	# 		# apply orient
	# 		got = yield self
	# 		# apply orient
	# 	end

	end
end
