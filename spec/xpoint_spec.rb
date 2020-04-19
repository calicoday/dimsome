puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "Point" do
  describe "#to_ary" do
    it "should allow parallel assigment" do
      one, two = Make.point(10, 20)
      one.should == 10.0
      two.should == 20.0
    end
  end

	# fix these .make tests!!!
#   describe ".make" do
#     it "should work with options" do
#       CGPointEqualToPoint(@point, CGPointMake(10, 20)).should == true
#     end
# 
#     it "should work with no options" do
#       CGPointEqualToPoint(ATSCGShareMake.point, CGPointMake(0, 0)).should == true
#     end
#   end
# 
#   describe "#rect_of_size" do
#     it "should work" do
#       size = CGSizeMake(20, 30)
#       @point.rect_of_size(size).should == CGRectMake(10, 20, 20, 30)
#     end
#   end

  describe "#up" do
    it "should work without y_dir" do
    	Make.point(1,1).up(1).should == Make.point(1,2)
    end
  end

  describe "#down" do
    it "should work without y_dir" do
     	Make.point(1,1).down(1).should == Make.point(1,0)
    end
  end

  describe "#left" do
    it "should work" do
     	Make.point(1,1).left(1).should == Make.point(0, 1)
    end
  end

  describe "#right" do
    it "should work" do
     	Make.point(1,1).right(1).should == Make.point(2, 1)
    end
  end

  describe "chaining up().down().left().right()" do
    it "should work" do
    	# test whether we get back to the start, so it's the same across platforms
    	# confirm order doesn't matter??? FIXME!!!
    	start = Make.point(1, 1)
      finish = start.up(2).left(2).down(2).right(2)
      start.should == finish
    end
  end

  describe "#diagonal" do
    it "should work" do
      point = Make.point(3, 4)
      point.diagonal.should == 5
    end
  end

  describe "#rough_diagonal" do
    it "should work" do
      point = Make.point(3, 4)
      point.rough_diagonal.should == 25
    end
  end


#   describe "#angle_to" do
#     it "should work" do
#       point = Make.point(0, 0)
#       point.angle_to(Make.point(10, 0)).should == 0
#       (0.785 - point.angle_to(Make.point(10, 10))).abs.should < 0.01  # ~= Math::PI/4
#       (1.57 - point.angle_to(Make.point(0, 10))).abs.should < 0.01  # ~= Math::PI/2
#       (3.14 - point.angle_to(Make.point(-10, 0))).abs.should < 0.01  # ~= Math::PI
#       (-1.57 - point.angle_to(Make.point(0, -10))).abs.should < 0.01  # ~= -Math::PI/2
#     end
#   end

  describe "#angle" do
    it "should work with 0 degrees" do
      point = Make.point(3, 0)
      point.angle.should == 0
    end
    it "should work with 90 degrees" do
      point = Make.point(0, 4)
      point.angle.round(4).should == (Math::PI / 2).round(4)
    end
  end

#   describe "#inside?" do
#     it "should return true" do
#       rect = CGRectMake(0, 0, 100, 100)
#       @point.inside?(rect).should == true
#     end
# 
#     it "should return false" do
#       rect = CGRectMake(0, 0, 5, 5)
#       @point.inside?(rect).should == false
#     end
#   end

#   describe '#to/from_ns_value' do
#     it 'should convert to NSValue' do
#       val = CGPointMake(0, 0).to_ns_value
#       val.should.be.kind_of(NSValue)
#     end
#   end

end
