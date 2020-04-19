puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "Size" do
#   before do
#     @size = Size.new(100, 200)
#   end
  describe "#to_ary" do
    it "should allow parallel assigment" do
      one, two = Make.size(10, 20)
      one.should == 10.0
      two.should == 20.0
    end
  end


#   describe ".make" do
#     it "should work with options" do
#       CGSizeEqualToSize(@size, Make.size(100, 200)).should == true
#     end
# 
#     it "should work with no options" do
#       CGSizeEqualToSize(Make.size, Make.size(0, 0)).should == true
#     end
#   end

  describe "#grow" do
    it "works" do
      size = Make.size(0, 0).grow(20)
      size.width.should == 20
      size.height.should == 20
    end
  end

  describe "#shrink" do
    it "works" do
      size = Make.size(20, 20).shrink(20)
      size.width.should == 0
      size.height.should == 0
    end
  end

  describe "#wider" do
    it "works" do
      size = Make.size(0, 0).wider(20)
      size.width.should == 20
    end
  end

  describe "#thinner" do
    it "works" do
      size = Make.size(20, 20).thinner(20)
      size.width.should == 0
    end
  end

  describe "#taller" do
    it "works" do
      size = Make.size(0, 0).taller(20)
      size.height.should == 20
    end
  end

  describe "#shorter" do
    it "works" do
      size = Make.size(20, 20).shorter(20)
      size.height.should == 0
    end
  end

#   describe "#rect_at_point" do
#     it "should work" do
#       point = Point.new(20, 30)
#       @size.rect_at_point(point).should == CGRectMake(20, 30, 100, 200)
#     end
#   end

  describe "#diagonal" do
    it "should work" do
      size = Make.size(30, 40)
      size.diagonal.should == 50.0
    end
  end

  describe "#- (unary)" do
    it "should work" do
      size = Make.size(100, 200)
      (-size).should == Make.size(-100, -200)
    end
  end

  describe "#- (binary)" do
    it "should work" do
      size = Make.size(100, 200)
      (size - size).should == Make.size(0, 0)
    end
  end

  describe "#+" do
    it "should work with Size" do
      size = Make.size(20, 30)
      (Make.size(100, 200) + size).should == Make.size(120, 230)
#       (@size + size).should == Make.size(120, 230)
    end

### no rect making in geom-plus
#     it "should work with CGPoint" do
#       point = Point.new(20, 30)
#       (@size + point).should == CGRectMake(20, 30, 100, 200)
#     end
### but add values??? consider!!! FIXME!!!
    it "should work with Point" do
      point = Make.point(20, 30)
      (Make.size(100, 200) + point).should == Make.size(120, 230)
#       (@size + point).should == Make.size(120, 230)
    end
  end

  describe "#*" do
    it "should work with Numeric" do
      size = Make.size(12, 24)
      bigger = size * 3
      bigger.width.should == 36
      bigger.height.should == 72
    end
  end

  describe "#/" do
    it "should work with Numeric" do
      size = Make.size(12, 24)
      smaller = size / 3
      smaller.width.should == 4
      smaller.height.should == 8
    end
  end

#   describe "#infinite?" do
#     it "should return true" do
#       infinite = Size.infinite
#       infinite.infinite?.should == true
#     end
#   end

#   describe ".empty" do
#     it "should work" do
#       CGRectIsEmpty(Size.empty.rect_at_point([0, 0])).should == true
#     end
# 
#     it "should not be mutable" do
#       f = Size.empty
#       f.width = 10
#       f.height = 10
#       CGRectIsEmpty(Size.empty.rect_at_point([0, 0])).should == true
#     end
#   end

  describe "#empty?" do
    it "should return true" do
      empty = Make.size(0, 0)
      empty.empty?.should == true
    end
  end

  describe "#==" do
    it "should return true" do
      size = Make.size(100, 200)
      Make.size(100, 200).should == size
#       @size.should == size
    end

    it "should return false" do
      size = Make.size(20, 10)
      (Make.size(100, 200) == size).should == false
#       @size.should_not == size
#       @size.should != size
    end
  end

#   describe "#centered_in" do
#     it "works" do
#       outer_rect = Rect.new(100, 100)
#       inner_size = Make.size(50, 0)
# 
#       centered_rect = inner_size.centered_in(outer_rect)
#       CGRectEqualToRect(centered_rect, CGRectMake(25, 25, 50, 50)).should == true
#     end
# 
#     it "works as relative" do
#       outer_rect = CGRect.make(x: 20, y: 30, width: 100, height: 100)
#       inner_size = Make.size(50, 50)
# 
#       centered_rect = inner_size.centered_in(outer_rect, true)
#       CGRectEqualToRect(centered_rect, CGRectMake(45, 55, 50, 50)).should == true
#     end
#   end

#   describe '#to/from_ns_value' do
#     it 'should convert to NSValue' do
#       val = Make.size(0, 0).to_ns_value
#       val.should.be.kind_of(NSValue)
#     end
#     it 'should convert from NSValue' do
#       val = NSValue.valueWithSize(Make.size(0, 0))
#       size = Size.from_ns_value(val)
#       size.should.be.kind_of(Size)
#     end
#   end

end
