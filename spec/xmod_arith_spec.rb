puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "ModArith" do
  before do
    @dim = Make.dim2d(100, 200)
  end

  describe "#to_ary" do
    it "should allow parallel assigment" do
      one, two = @dim
      one.should == 100.0
      two.should == 200.0
    end
  end

  describe "#==" do
    it "should return true" do
      dim = Make.dim2d(100, 200)
      got = (dim == @dim)
      got.should == true
    end

    it "should return false" do
      dim = Make.dim2d(20, 10)
      got = (dim == @dim)
      got.should == false
    end
  end

  describe "#- (unary)" do
    it "should work" do
      dim = Make.dim2d(100, 200)
      (-dim).should == Make.dim2d(-100, -200)
    end
  end

  describe "#- (binary)" do
    it "should work" do
      dim = Make.dim2d(100, 200)
      (dim - dim).should == Make.dim2d(0, 0)
    end
  end

  describe "#+" do
    it "should work with Dim2d" do
      dim = Make.dim2d(20, 30)
      (@dim + dim).should == Make.dim2d(120, 230)
    end

#     it "should work with Point" do
#       point = Point.new(20, 30)
#       (@dim + point).should == Make.dim2d(120, 230)
#     end
  end

  describe "#*" do
    it "should work with Numeric" do
      dim = Make.dim2d(12, 24)
      (dim * 3).should == Make.dim2d(36, 72)     
    end
  end

  describe "#/" do
    it "should work with Numeric" do
      dim = Make.dim2d(12, 24)
      (dim / 3).should == Make.dim2d(4, 8)
    end
  end

#   describe "#infinite?" do
#     it "should return true" do
#       infinite = Dim2d.infinite
#       infinite.infinite?.should == true
#     end
#   end

#   describe ".empty" do
#     it "should work" do
#       CGRectIsEmpty(Dim2d.empty.rect_at_point([0, 0])).should == true
#     end
#   end

  describe "#empty?" do
    it "should return true" do
      empty = Make.dim2d(0, 0)
      empty.empty?.should == true
    end
  end

  describe "#abs" do
    it "should return true" do
      dim = Make.dim2d(-3.4, 5)
      dim.abs.should == Make.dim2d(3.4, 5)
    end
  end

#   describe "#round" do
#   end

  describe "#rough_diagonal" do
    it "should work" do
      dim = Make.dim2d(3, 4)
      dim.rough_diagonal.should == 25.0
    end
  end

  describe "#diagonal" do
    it "should work" do
      dim = Make.dim2d(3, 4)
      dim.diagonal.should == 5.0
    end
  end

#   describe "#angle" do
#   end
# 
#   describe "#angle_to" do
#   end
# 
#   describe "#within_radius?" do
#   end

end
