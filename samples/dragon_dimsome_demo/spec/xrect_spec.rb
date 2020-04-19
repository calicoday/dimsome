puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "Rect" do
  before do
    @rect = Make.rect(10, 100, 50, 20)
  end

	### mod acc
  describe "#to_ary" do
    it "should allow parallel assigment" do
      position, size = @rect
      position.should == Make.point(10.0, 100.0)
      size.should == Make.size(50, 20)
    end
  end

  describe "#==" do
    it "works" do
      rect = Make.rect(10, 100, 50, 20)
      rect.should == @rect
    end
	end
	
  describe "#new" do
    it "works with 4 nums" do
      rect = Make.rect(10, 100, 50, 20)
      rect.should == @rect
    end
    it "works with no args" do
      rect = Make.rect()
			rect.should == Make.rect(0, 0, 0, 0)
    end
    it "works with 1 quad" do
      rect = Make.rect([10, 100, 50, 20])
      rect.should == @rect
    end
    it "works with 2 num_pairs" do
      rect = Make.rect([10, 100], [50, 20])
      rect.should == @rect
    end
    it "works with num_pair and Size" do
      size = Make.size(50, 20)
      rect = Make.rect([10, 100], size)
      rect.should == @rect
    end
  end

  describe "#x" do
    it "returns value when no args" do
      @rect.x.should == 10
    end
    it "returns min_x when width is negative" do
      rect = Make.rect(110, 10, -100, 100)
      rect.x.should == 10
      rect.origin.x.should == 110
    end

    it "returns copy when has args" do
      rect = @rect.x(20)
      rect.is_a?(Dimsome::ModRectAccessors).should == true
      rect.should == Make.rect(20, 100, 50, 20)
    end
  end

  describe "#x=" do
    it "sets value" do
      rect = Make.rect()
      rect.x = 20
      rect.origin.x.should == 20
    end
  end

  describe "#y" do
    it "returns value when no args" do
      @rect.y.should == 100
    end
    it "returns min_y when height is negative" do
      rect = Make.rect(10, 110, 100, -100)
      rect.y.should == 10
      rect.origin.y.should == 110
    end

    it "returns copy when has args" do
      rect = @rect.y(20)
      rect.is_a?(Dimsome::ModRectAccessors).should == true
      rect.should == Make.rect(10, 20, 50, 20)
    end
  end

  describe "#y=" do
    it "sets value" do
      rect = Make.rect()
      rect.y = 20
      rect.origin.y.should == 20
    end
  end

  describe "#width" do
    it "returns value when no args" do
      @rect.width.should == 50
    end
    it "always returns positive width" do
      rect = Make.rect(10, 110, -100, -100)
      rect.width.should == 100
    end
    it "returns copy when has args" do
      rect = @rect.width(20)
      rect.is_a?(Dimsome::ModRectAccessors).should == true
      rect.should == Make.rect(10, 100, 20, 20)
    end
  end

  describe "#width=" do
    it "sets value" do
      rect = Make.rect()
      rect.width = 20
      rect.size.width.should == 20
    end
  end

  describe "#height" do
    it "returns value when no args" do
      @rect.height.should == 20
    end
    it "always returns positive height" do
      rect = Make.rect(10, 110, -100, -100)
      rect.height.should == 100
    end
    it "returns copy when has args" do
      rect = @rect.height(50)
      rect.is_a?(Dimsome::ModRectAccessors).should == true
      rect.should == Make.rect(10, 100, 50, 50)
    end
  end

  describe "#height=" do
    it "sets value" do
      rect = Make.rect()
      rect.height = 50
      rect.size.height.should == 50
    end
  end

  describe "#min_x, #mid_x, #max_x, #min_y, #mid_y, #max_y" do
    before do
      @min_rect = Make.rect(10, 10, 100, 100)
      @min_rect_negative = Make.rect(110, 110, -100, -100)
    end

    it "#min_x works" do
      @min_rect.min_x.should == 10
    end
    it "#mid_x works" do
      @min_rect.mid_x.should == 60
    end
    it "#max_x works" do
      @min_rect.max_x.should == 110
    end
    it "#min_x works with negative width" do
      @min_rect_negative.min_x.should == 10
    end
    it "#mid_x works with negative width" do
      @min_rect_negative.mid_x.should == 60
    end
    it "#max_x works with negative width" do
      @min_rect_negative.max_x.should == 110
    end

    it "#min_y works" do
      @min_rect.min_y.should == 10
    end
    it "#mid_y works" do
      @min_rect.mid_y.should == 60
    end
    it "#max_y works" do
      @min_rect.max_y.should == 110
    end
    it "#min_y works with negative height" do
      @min_rect_negative.min_y.should == 10
    end
    it "#mid_y works with negative height" do
      @min_rect_negative.mid_y.should == 60
    end
    it "#max_y works with negative height" do
      @min_rect_negative.max_y.should == 110
    end
  end

end
