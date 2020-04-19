puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "Rect ModRel" do
  before do
    @rect = Make.rect(10, 100, 50, 20) #x: 10, y: 100, width: 50, height: 20)
  end

#   describe "#new" do
#     it "works" do
# #       size = Make.size(0, 0).grow(20)
# #       size.width.should == 20
# #       size.height.should == 20
#     end
#   end

  describe "#left" do
    it "works" do
      rect = Make.rect().left(20)
      rect.origin.x.should == -20
    end
  end

  describe "#right" do
    it "works" do
      rect = Make.rect().right(20)
      rect.origin.x.should == 20
    end
  end

  describe "#up [without y_origin]" do
		it "works" do
			rect = Make.rect().up(20)
			rect.origin.y.should == 20 #-20
		end
  end

  describe "#down [without y_origin]" do
		it "works" do
			rect = Make.rect().down(20)
			rect.origin.y.should == -20 #20
		end
  end

  describe "#wider" do
    it "works" do
      rect = Make.rect().wider(20)
      rect.size.width.should == 20
    end
  end

  describe "#narrower" do
#   describe "#thinner" do
    it "works" do
    	rect = Make.rect().w(20).narrower(10)
      rect.size.width.should == 10
    end
  end

  describe "#taller [without y_origin]" do
    it "works" do
    	rect = Make.rect().h(20).taller(20)
      rect.size.height.should == 40
    end
  end


  describe "#shorter [without y_origin]" do
    it "works" do
    	rect = Make.rect().h(20).shorter(10)
      rect.size.height.should == 10
    end
  end

  describe "#above [without y_origin]" do
    it "works without margins" do
    	rect = Make.rect().h(50).above
      rect.origin.y.should == 50 #-50
      rect.size.height.should == 50
    end

    it "works with margins" do
    	rect = Make.rect().h(50).above(20)
      rect.origin.y.should == 70 #-70
      rect.size.height.should == 50
    end
  end

  describe "#below [without y_origin]" do
    it "works without margins" do
    	rect = Make.rect().h(50).below
      rect.origin.y.should == -50 #50
      rect.size.height.should == 50
    end

    it "works with margins" do
    	rect = Make.rect().h(50).below(20)
      rect.origin.y.should == -70 #70
      rect.size.height.should == 50
    end

  end

  describe "#before" do
    it "works without margins" do
    	rect = Make.rect().w(50).before
      rect.origin.x.should == -50
      rect.size.width.should == 50
    end

    it "works with margins" do
    	rect = Make.rect().w(50).before(20)
      rect.origin.x.should == -70
      rect.size.width.should == 50
    end
  end

	### #after!!! FIXME!!!
  describe "#after" do
#   describe "#beside" do
    it "works without margins" do
    	rect = Make.rect().w(50).after
      rect.origin.x.should == 50
      rect.size.width.should == 50
    end

    it "works with margins" do
    	rect = Make.rect().w(50).after(20)
      rect.origin.x.should == 70
      rect.size.width.should == 50
    end
  end

#     @rect = Make.rect(10, 100, 50, 20) #x: 10, y: 100, width: 50, height: 20)

	# centered, not dbl
  describe "#grow" do
    it "should work with Numeric" do
      rect = @rect.grow(10)
      rect.should == Make.rect(5, 95, 60, 30)
    end
		### SHOULD it work with Size??? or is amount only Numeric???
#     it "should work with Size" do
#       rect = @rect.grow(Make.size(10, 20))
#       rect.should == Make.rect(0, 80, 70, 60)
#     end
  end

  describe "#grow_left" do
    it "should work" do
      rect = @rect.grow_left(10)
      rect.should == Make.rect(0, 100, 60, 20)
    end
  end

  describe "#grow_right" do
    it "should work" do
      rect = @rect.grow_right(10)
      rect.should == Make.rect(10, 100, 60, 20)
    end
  end

  describe "#grow_up" do
    it "should work" do
      rect = @rect.grow_up(10)
      rect.should == Make.rect(10, 100, 50, 30)
    end
  end

  describe "#grow_down" do
    it "should work" do
      rect = @rect.grow_down(10)
       rect.should == Make.rect(10, 90, 50, 30)
    end
  end

	### do we even want grow_width, etc???
#   describe "#grow_width" do
#     it "should work" do
#       rect = @rect.grow_width(10)
#       rect.should == Make.rect(0, 100, 70, 20)
#     end
#   end
# 
#   describe "#grow_height" do
#     it "should work" do
#       rect = @rect.grow_height(10)
#       rect.should == Make.rect(10, 90, 50, 40)
#     end
#   end

	# centered, not dbl
  describe "#shrink" do
    it "should work with Numeric" do
      rect = @rect.shrink(10)
      rect.should == Make.rect(15, 105, 40, 10)
    end

#     it "should work with Size" do
#       rect = @rect.shrink(Make.size(20, 10))
#       rect.should == Make.rect(30, 110, 10, 0)
#     end
# 
#     it "should work with Array" do
#       rect = @rect.shrink([20, 10])
#       rect.should == Make.rect(30, 110, 10, 0)
#     end
  end

  describe "#shrink_left" do
    it "should work" do
      rect = @rect.shrink_left(10)
      rect.should == Make.rect(10, 100, 40, 20)
    end
  end

  describe "#shrink_right" do
    it "should work" do
      rect = @rect.shrink_right(10)
      rect.should == Make.rect(20, 100, 40, 20)
    end
  end

  describe "#shrink_up [without y_origin]" do
    it "should work" do
      rect = @rect.shrink_up(10)
      rect.should == Make.rect(10, 110, 50, 10)
    end
  end

  describe "#shrink_down [without y_origin]" do
    it "should work" do
      rect = @rect.shrink_down(10)
      rect.should == Make.rect(10, 100, 50, 10)
    end
  end

#   describe "#shrink_width" do
#     it "should work" do
#       rect = @rect.shrink_width(10)
#       rect.should == Make.rect(20, 100, 30, 20)
#     end
#   end
# 
#   describe "#shrink_height" do
#     it "should work" do
#       rect = @rect.shrink_height(10)
#       rect.should == Make.rect(10, 110, 50, 0)
#     end
#   end

  describe "#apply" do

    it "should support :left" do
      rect = @rect.apply(left: 10)
      rect.should == Make.rect(0, 100, 50, 20)
    end

    it "should support :right" do
      rect = @rect.apply(right: 10)
      rect.should == Make.rect(20, 100, 50, 20)
    end

    it "should support :up" do
      rect = @rect.apply(up: 10)
      rect.should == Make.rect(10, 110, 50, 20)
    end

    it "should support :down" do
      rect = @rect.apply(down: 10)
      rect.should == Make.rect(10, 90, 50, 20)
    end

		# centered
    it "should support :wider" do # == :grow_width
      rect = @rect.apply(wider: 10)
      rect.should == Make.rect(5, 100, 60, 20)
#       rect.should == Make.rect(10, 100, 60, 20)
    end

		# centered
    it "should support :thinner" do # == :shrink_width
      rect = @rect.apply(thinner: 10)
      rect.should == Make.rect(15, 100, 40, 20)
#       rect.should == Make.rect(10, 100, 40, 20)
    end

		# centered
    it "should support :taller" do # == :grow_height
      rect = @rect.apply(taller: 10)
      rect.should == Make.rect(10, 95, 50, 30)
#       rect.should == Make.rect(10, 100, 50, 30)
    end

		# centered
    it "should support :shorter" do # == :shrink_height
      rect = @rect.apply(shorter: 10)
      rect.should == Make.rect(10, 105, 50, 10)
#       rect.should == Make.rect(10, 100, 50, 10)
    end

    it "should support :x" do
      rect = @rect.apply(x: 11)
      rect.should == Make.rect(11, 100, 50, 20)
    end

    it "should support :y" do
      rect = @rect.apply(y: 10)
      rect.should == Make.rect(10, 10, 50, 20)
    end

    it "should support :origin" do
      rect = @rect.apply(origin: [11, 10])
      rect.should == Make.rect(11, 10, 50, 20)
    end

    it "should support :width" do
      rect = @rect.apply(width: 10)
      rect.should == Make.rect(10, 100, 10, 20)
    end

    it "should support :height" do
      rect = @rect.apply(height: 10)
      rect.should == Make.rect(10, 100, 50, 10)
    end

    it "should support :size" do
      rect = @rect.apply(size: [10, 10])
      rect.should == Make.rect(10, 100, 10, 10)
    end

		# centered
    it "should support :grow" do
      rect = @rect.apply(grow: 10)
      rect.should == Make.rect(5, 95, 60, 30)
#       rect.should == Make.rect(0, 90, 70, 40)
    end

		# centered
    it "should support :grow_width" do
      rect = @rect.apply(grow_width: 10)
      rect.should == Make.rect(5, 100, 60, 20)
#       rect.should == Make.rect(0, 100, 70, 20)
    end

		# centered
    it "should support :grow_height" do
      rect = @rect.apply(grow_height: 10)
      rect.should == Make.rect(10, 95, 50, 30)
#       rect.should == Make.rect(10, 90, 50, 40)
    end

    it "should support :grow_left" do
      rect = @rect.apply(grow_left: 10)
      rect.should == Make.rect(0, 100, 60, 20)
    end

    it "should support :grow_right" do #was == :grow_width pre centered
      rect = @rect.apply(grow_right: 10)
      rect.should == Make.rect(10, 100, 60, 20)
#       rect.should == Make.rect(0, 100, 70, 20)
    end

    it "should support :grow_up" do
      rect = @rect.apply(grow_up: 10)
      rect.should == Make.rect(10, 100, 50, 30)
    end

    it "should support :grow_down" do #was == :grow_height top_y pre centered
      rect = @rect.apply(grow_down: 10)
      rect.should == Make.rect(10, 90, 50, 30)
#       rect.should == Make.rect(10, 90, 50, 40)
    end

		# centered
    it "should support :shrink" do
      rect = @rect.apply(shrink: 10)
      rect.should == Make.rect(15, 105, 40, 10)
#       rect.should == Make.rect(20, 110, 30, 0)
    end

		# centered
    it "should support :shrink_width" do
      rect = @rect.apply(shrink_width: 10)
      rect.should == Make.rect(15, 100, 40, 20)
    end

		# centered
    it "should support :shrink_height" do
      rect = @rect.apply(shrink_height: 10)
      rect.should == Make.rect(10, 105, 50, 10)
    end

    it "should support :shrink_left" do #was == :shrink_width pre centered
      rect = @rect.apply(shrink_left: 10)
      rect.should == Make.rect(10, 100, 40, 20)
    end

    it "should support :shrink_right" do
      rect = @rect.apply(shrink_right: 10)
      rect.should == Make.rect(20, 100, 40, 20)
    end

    it "should support :shrink_down" do
      rect = @rect.apply(shrink_down: 10)
      rect.should == Make.rect(10, 100, 50, 10)
    end

    it "should support :shrink_up" do #was == :shrink_height top_y pre centered
      rect = @rect.apply(shrink_up: 10)
      rect.should == Make.rect(10, 110, 50, 10)
    end

#     it "should support :offset" do
#       rect = @rect.apply(offset: [10, 10])
#       rect.should == Make.rect(20, 110, 50, 20)
#     end

  end

end
