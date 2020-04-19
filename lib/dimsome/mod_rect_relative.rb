module Dimsome
	module ModRectRelative
		# Create rect with same size, adjusted position
	
		#nope not useful here!!!
	#   def method_missing(m, *args, &b)
	#   	case m
	#   	when :left, :right, :up, :down then origin.send(m, args, &b) 
	#   	end
	#   end
	#   # respond_to_missing...???

		### NOTE if you want to pass a num_pair not scalar use move/resize not left/grow/wider
		### specialized methods only take scalar!!!

		def move(other)
			raise_cannot_op('move', other) unless pair = numeric_pair(other)
			vetted_move(pair)
		end
		def vetted_move(pair)
			self.class.new(pair, size.to_ary)
		end

		#### let amount be pair, poss nil, eg [v, nil]??? ###FIXME!!!
		# because these methods have the same names as origin methods, we needn't __callee__
		def left(amount) vetted_move(origin.left(amount)) end
		def right(amount) vetted_move(origin.right(amount)) end
		def up(amount) vetted_move(origin.up(amount)) end
		def down(amount) vetted_move(origin.down(amount)) end
	
		# Create rect with same position, adjusted size

		# spread for the op!!! expressed as a fraction of the w, h
		# anchor wd be a point (in spritekit it's a spread)!!!

		# fit_within/outside???
		def wrt(outer)
		end
	
		def numeric_spread?(spread)
			spread.is_a?(Array) && 
				spread[0] && spread[0].is_a?(Numeric) && spread[0] >= 0 && spread[0] <= 1.0 &&
				spread[1] && spread[0].is_a?(Numeric) && spread[1] >= 0 && spread[1] <= 1.0
		end

		def spread?(spread) ### allows nil members
			spread.is_a?(Array) && 
				spread.length > 1 &&
				(spread[0] == nil || 
					spread[0].is_a?(Numeric) && spread[0] >= 0 && spread[0] <= 1.0) &&
				(spread[1] == nil || 
					spread[1].is_a?(Numeric) && spread[1] >= 0 && spread[1] <= 1.0)
		end
	
		# default is relative to origin bc internal rep -- make centered??? FIXME!!!
	
		def fix_resize_args(amount, spread, opname)
			raise_cannot_op(opname, amount) unless amount.is_a?(Numeric)
			raise_cannot_op(opname, spread, '(bad spread)') if spread && !spread?(spread)
# 			raise_cannot_op(opname, spread) unless spread && spread?(spread)
	#   	spread = [0.0, 0.0] unless spread
			spread ? spread : [0.0, 0.0]
		end
	
		def resize(other, spread=nil)
			raise_cannot_op('resize', other) unless pair = numeric_pair(other)
			raise_cannot_op(opname, spread, '(bad spread)') if spread && !spread?(spread)
#			raise_cannot_op('resize', spread) unless spread && spread?(spread)
			vetted_resize(pair, spread)
		end
		#???
# 		def vetted_resize!(pair, spread)
# 			self.x = self.x - (spread[0] || 1) * (pair[0] || 0)
# 			self.y = self.y - (spread[1] || 1) * (pair[1] || 0)
# 			self.w = self.w + (pair[0] || 0)
# 			self.h = self.h + (pair[1] || 0)
# 		end
		# use origin.y not rect conv y() to avoid min/max problems for flipflop!!! FIXME!!!
		def vetted_resize(pair, spread)
			sized = size.vetted_add(pair)
			self.class.new([self.origin.x - (spread[0] || 1) * (pair[0] || 0), 
				self.origin.y - (spread[1] || 1) * (pair[1] || 0)], 
				sized)
# 			self.class.new([self.x - (spread[0] || 1) * (pair[0] || 0), 
# 				self.y - (spread[1] || 1) * (pair[1] || 0)], 
# 				sized)
		end
	
		### grow/shrink amount to EACH side!!!
		### maybe get these into inside/outside, for now grow/shrink from middle...
# 			spread = [0.5, 0.5] unless spread #???
		# ONLY for grow()/shrink(), others amount is total!!!
		# ok very iffy but FOR NOW
		# 1) without spread, dbl amount and center
		# 2) with spread, assume amount is total (ie dbl equiv) and spread is intended	
		### REALLY think amount shd be total!!! FIXME!!! tmp only to match geom specs!!!
		# grow/shrink accept pair as amount???!!! maybe THAT's inside/outside()???
		def grow(amount, spread=nil) 
			unless spread
# 				amount += amount
				spread = [0.5, 0.5]
			end
			vetted_resize([amount, amount], fix_resize_args(amount, spread, __callee__))
		end
		def shrink(amount, spread=nil) 
			unless spread
# 				amount += amount
				spread = [0.5, 0.5]
			end
			vetted_resize([-amount, -amount], fix_resize_args(amount, spread, __callee__))
		end

		# tmp are geom specs centered or no??? FIXME!!!
		def wider(amount, spread=nil) 
# 			amount += amount
# 			spread = [0.5, 0.5] unless spread #???
			vetted_resize([amount, nil], fix_resize_args(amount, spread, __callee__))
		end
		def narrower(amount, spread=nil) 
# 			amount += amount
# 			spread = [0.5, 0.5] unless spread #???
			vetted_resize([-amount, nil], fix_resize_args(amount, spread, __callee__))
		end
	#   alias_method :thinner, :narrower
	#   alias_method :thicker, :wider
		def taller(amount, spread=nil) 
			vetted_resize([nil, amount], fix_resize_args(amount, spread, __callee__))
		end
		def shorter(amount, spread=nil) 
			vetted_resize([nil, -amount], fix_resize_args(amount, spread, __callee__))
		end
	
		def amount_as_pair(v, amount)
			case v
			when :grow then [amount, amount]
			when :shrink then [-amount, -amount]

			when :wider then [amount, nil]
			when :narrower then [-amount, nil]
			when :taller then [nil, amount]
			when :shorter then [nil, -amount]
			else
				[nil, nil] # fail silently
			end
		end
	
		# grow_up(5) => taller(5)
		# grow_down(5) => taller(5, [0, 1]) => vetted_resize([nil, 5], [0, 1])

		# grow_left == grow_align_right???
		def grow_left(amount) wider(amount, named_spread(:right)) end
		def grow_right(amount) wider(amount, named_spread(:left)) end
		def grow_up(amount) taller(amount, named_spread(:bottom)) end
		def grow_down(amount) taller(amount, named_spread(:top)) end
	
		def shrink_left(amount) narrower(amount, named_spread(:left)) end
		def shrink_right(amount) narrower(amount, named_spread(:right)) end
		def shrink_up(amount) shorter(amount, named_spread(:top)) end
		def shrink_down(amount) shorter(amount, named_spread(:bottom)) end
	
		# grow/shrink_width/_height ???
	
		### Create relative rect with same or adjusted size, adjusted (or adjusted for 
		### resize direction) position, 
		#above, from_left...

		### start with simple above, before, etc, then we'll deal with opts!!!
		def above(further=nil)
			self.up(further ? self.height + further : self.height)
		end
		def below(further=nil)
			self.down(further ? self.height + further : self.height) 
		end
		def before(further=nil)
			self.left(further ? self.width + further : self.width)
		end
		def after(further=nil)
			self.right(further ? self.width + further : self.width)
		end
	
	
		#def near for inside/outside/relative_to???
		# from_ s in general...
	
		# instead of from_left, etc, let's try inside, outside with align...
		# use grip names as directions
		# align pair and offset/padding pair!!!
		def inside(align=nil, offset=nil) ###*args!!!
		
		
		end
	# 	def outside(align=nil, further=nil)
		def outside(*args)
			align, args = HandyArgs.pull_first_object(Symbol, args)
			align = center unless align
		end
	
	
	end
end
