module Dimsome
	module ModRectGrip  
		# Spread is a unit vector, where nil means an axis will be ignored or left unmodified.
		# Waypoint is a point some way into the rect, ie [width, height] * (named_)spread
		# 	(geomotion relative position). useful as a delta or offset???
		# Grip is a point in the parent rect, ie origin + [width, height] * (named_)spread
		# 	(geomotion absolute position)
	
		def named_spread(name)
			case name
			when :center then [0.5, 0.5]
			when :top_left then [0.0, 1.0]
			when :top_center then [0.5, 1.0]
			when :top_right then [1.0, 1.0]
			when :center_right then [1.0, 0.5]
			when :bottom_right then [1.0, 0.0]
			when :bottom_center then [0.5, 0.0]
			when :bottom_left then [0.0, 0.0]
			when :center_left then [0.0, 0.5]
			# single edge/direction
			when :left, :rightward then [0.0, nil]
			when :right, :leftward then [1.0, nil]
			when :top, :downward then [nil, 1.0]
			when :bottom, :upward then [nil, 0.0]		
			else
# 				puts "named_spread unknown name: #{name.inspect}"
# 				[nil, nil] # fail silently??? ### [0, 0]???
				#### prob want to raise!!! FIXME!!!
				nil
			end
		end
		### dint solve it
			# if either spread has a nil value, nil for both
# 			if fly_spread[0] == nil || base_spread[0] == nil
# 				fly_spread[0] = base_spread[0] = nil 
# 			end
# 			if fly_spread[1] == nil || base_spread[1] == nil
# 				fly_spread[1] = base_spread[1] = nil 
# 			end
		
		# we are the flyer!!!
		def align(fly_spread, base, base_spread, offset=nil)
			fly_spread = named_spread(fly_spread) if fly_spread.is_a?(Symbol)
			raise_cannot_op(__callee__, fly_spread) unless fly_spread && spread?(fly_spread)
			base_spread = named_spread(base_spread) if base_spread.is_a?(Symbol)
			raise_cannot_op(__callee__, base_spread) unless base_spread && spread?(base_spread)
			
			mask = 2.times.map{|i| fly_spread[i] && base_spread[i] ? 1 : nil}
			dest = base.grip(base_spread) - self.size * fly_spread + offset
			self.move([mask[0] ? dest[0] : self.origin.x, mask[1] ? dest[1] : self.origin.y])
				
			###self.move(delta)
# 			self.move(base.grip(base_spread) - self.size * fly_spread + offset)
			#eg resize:
# 			self.class.make([self.origin.x - (spread[0] || 1) * (pair[0] || 0), 
# 				self.origin.y - (spread[1] || 1) * (pair[1] || 0)], 
# 				sized)
		end
		
		### untested!!! FIXME!!!
		def spread(point)
			### shd std or min/max or something here!!! FIXME!!!
			w, h = size.to_ary
			farx, fary = (origin + size).to_ary
			### no nil, surely???
# 			raise_cannot_op(__callee___, point) unless pair = strict_numeric_pair(offset) &&
			raise_cannot_op(__callee___, point) unless pair = numeric_pair(offset) &&
				pair[0] >= origin.x && pair[0] <= farx &&
				pair[1] >= origin.y && pair[1] <= fary
			[pair[0] == 0 ? 0 : w / (pair[0] * 1.0),
				pair[1] == 0 ? 0 : h / (pair[1] * 1.0)]			
		end

		### new and weird!!!
		def gripgrip_outof(spread, outer_rect, outer_spread)
			grip(spread, outer_rect.grip(outer_spread))
		end
		def gripgrip_into(spread, inner_rect, inner_spread)
			inner_rect.grip(inner_spread, self.grip(spread))
		end

### from daff!!!
		def pull_last_object(baseclass, args_arr)
			baseclass = (args_arr && args_arr.last && args_arr.last.is_a?(baseclass) ? 
				args_arr.pop : 
				nil)
			[baseclass, args_arr]
		end
###	

		def fix_offset(offset, opname)
			return [0.0, 0.0] unless offset
			raise_cannot_op(opname, offset) unless pair = numeric_pair(offset)
			pair
		end


		# to get sksprite anchor point...
		def waypoint(name_or_spread, offset=nil) 
			spread = named_spread(name_or_spread) || numeric_pair(name_or_spread)
			raise_cannot_op(__callee__, spread) unless spread && spread?(spread)
			vetted_waypoint(spread, fix_offset(offset, __callee__)) 
		end
		def vetted_waypoint(spread, offset_pair)
			### allow nil??? FIXME!!!
# 			puts "\n=== v_way spread: #{spread.inspect}, offset: #{offset_pair.inspect}"
			w, h = size.to_ary
			### try ignoring w or h on nil... nope put it back for now...
# 			origin.class.make((offset_pair[0] || 0) + (spread[0] || 0) * w, 
# 				(offset_pair[1] || 0) + (spread[1] || 0) * h)
			origin.class.make((offset_pair[0] || 0) + (spread[0] || 1) * w, 
				(offset_pair[1] || 0) + (spread[1] || 1) * h)
		end	
		
# 		def grip(name_or_spread, offset=nil, callee=nil) 
		def grip(*args) 
			name_or_spread = args.shift
			spread = named_spread(name_or_spread) || numeric_pair(name_or_spread)
			raise_cannot_op(__callee__, spread) unless spread && spread?(spread)

			# __callee__ is Symbol with regular ruby methods, String with SDK methods, eg
			# "method:named_arg:" CONF!!!
			callee = pull_last_object(Symbol, args)
			callee = __callee__ unless callee
			offset, _ = args
			
			#### TMP!!! bc we used to accept true as offset
			raise "#{callee}(true) no longer accepted!!! Give name_or_spread." if offset == true
			
			vetted_grip(spread, fix_offset(offset, __callee__)) 
		end
		
		def vetted_grip(spread, offset_pair)
# 		puts "  === got: #{vetted_waypoint(spread, offset_pair)}, origin: #{origin.inspect}"
			vetted_waypoint(spread, offset_pair) + origin
		end	

		### __callee__ spelt diff ruby/rubymotion, eg :center vs center:
		# otherwise cdv done eg grip(__callee__, offset, __callee__)
		def center(offset=nil) grip(:center, offset, __callee__) end
		def top_left(offset=nil) grip(:top_left, offset, __callee__) end
		def top_center(offset=nil) grip(:top_center, offset, __callee__) end
		def top_right(offset=nil) grip(:top_right, offset, __callee__) end
		def center_right(offset=nil) grip(:center_right, offset, __callee__) end
		def bottom_right(offset=nil) grip(:bottom_right, offset, __callee__) end
		def bottom_center(offset=nil) grip(:bottom_center, offset, __callee__) end
		def bottom_left(offset=nil) grip(:bottom_left, offset, __callee__) end
		def center_left(offset=nil) grip(:center_left, offset, __callee__) end

		# unnec???
		def align_as_spread(v)
			case v
			when :center then [0.5, 0.5]
			when :top_left then [0.0, 1.0]
			when :top_center then [0.5, 1.0]
			when :top_right then [1.0, 1.0]
			when :center_right then [1.0, 0.5]
			when :bottom_right then [1.0, 0.0]
			when :bottom_center then [0.5, 0.0]
			when :bottom_left then [0.0, 0.0]
			when :center_left then [0.0, 0.5]
			else
				[0.0, 0.0] # fail silently
			end
		end

	end
end
