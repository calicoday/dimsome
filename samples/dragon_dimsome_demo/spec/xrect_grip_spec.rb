puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "Rect ModGrip" do
  before do
#     @dim = Make.dim2d(100, 200)
  end

  describe "#new" do
    it "works" do
#       size = Make.size(0, 0).grow(20)
#       size.width.should == 20
#       size.height.should == 20
    end
  end

	### positions
	describe "waypoint/grip w spread" do
    it "waypoint [0.25, 0.75], no offset" do
    	Make.rect(100, 100, 200, 200).waypoint([0.25, 0.75]).should == Make.point(50, 150)
    end

    it "waypoint [0.25, 0.75], offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).waypoint(
    		[0.25, 0.75], [10, 20]).should == Make.point(60, 170)
    end

    it "waypoint [0.25, 0.75], offset [nil, 20]" do
    	Make.rect(100, 100, 200, 200).waypoint(
    		[0.25, 0.75], [nil, 20]).should == Make.point(50, 170)
    end

    it "waypoint [0.25, 0.75], offset 10" do
    	Make.rect(100, 100, 200, 200).waypoint(
    		[0.25, 0.75], 10).should == Make.point(60, 160)
    end

    it "grip [0.25, 0.75], no offset" do
    	Make.rect(100, 100, 200, 200).grip([0.25, 0.75]).should == Make.point(150, 250)
    end

    it "grip [0.25, 0.75], offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).grip(
    		[0.25, 0.75], [10, 20]).should == Make.point(160, 270)
    end

    it "grip [0.25, 0.75], offset [nil, 20]" do
    	Make.rect(100, 100, 200, 200).grip(
    		[0.25, 0.75], [nil, 20]).should == Make.point(150, 270)
    end

    it "grip [0.25, 0.75], offset 10" do
    	Make.rect(100, 100, 200, 200).grip(
    		[0.25, 0.75], 10).should == Make.point(160, 260)
    end
	end
	
  describe "position bottom_left" do
    it "waypoint :bottom_left, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:bottom_left).should == Make.point(0, 0)
    end

    it "grip :bottom_left, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:bottom_left).should == Make.point(100, 100)
    end

    it "#bottom_left, no offset" do
    	Make.rect(100, 100, 200, 200).bottom_left.should == Make.point(100, 100)
    end

    it "#bottom_left, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).bottom_left([10, 20]).should == Make.point(110, 120)
    end
  end
 
  describe "position bottom_center" do
    it "waypoint :bottom_center, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:bottom_center).should == Make.point(100, 0)
    end

    it "grip :bottom_center, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:bottom_center).should == Make.point(200, 100)
    end

    it "#bottom_center, no offset" do
    	Make.rect(100, 100, 200, 200).bottom_center.should == Make.point(200, 100)
    end

    it "#bottom_center, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).bottom_center([10, 20]).should == Make.point(210, 120)
    end
  end

  describe "position bottom_right" do
    it "waypoint :bottom_right, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:bottom_right).should == Make.point(200, 0)
    end

    it "grip :bottom_right, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:bottom_right).should == Make.point(300, 100)
    end

    it "#bottom_right, no offset" do
    	Make.rect(100, 100, 200, 200).bottom_right.should == Make.point(300, 100)
    end

    it "#bottom_right, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).bottom_right([10, 20]).should == Make.point(310, 120)
    end
  end
 
  describe "position center_left" do
    it "waypoint :center_left, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:center_left).should == Make.point(0, 100)
    end

    it "grip :center_left, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:center_left).should == Make.point(100, 200)
    end

    it "#center_left, no offset" do
    	Make.rect(100, 100, 200, 200).center_left.should == Make.point(100, 200)
    end

    it "#center_left, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).center_left([10, 20]).should == Make.point(110, 220)
    end
  end

  describe "position center" do
    it "waypoint :center, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:center).should == Make.point(100, 100)
    end

    it "grip :center, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:center).should == Make.point(200, 200)
    end

    it "#center, no offset" do
    	Make.rect(100, 100, 200, 200).center.should == Make.point(200, 200)
    end

    it "#center, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).center([10, 20]).should == Make.point(210, 220)
    end
  end
  
  describe "position center_right" do
    it "waypoint :center_right, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:center_right).should == Make.point(200, 100)
    end

    it "grip :center_right, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:center_right).should == Make.point(300, 200)
    end

    it "#center_right, no offset" do
    	Make.rect(100, 100, 200, 200).center_right.should == Make.point(300, 200)
    end

    it "#center_right, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).center_right([10, 20]).should == Make.point(310, 220)
    end
  end
  
  describe "position top_left" do
    it "waypoint :top_left, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:top_left).should == Make.point(0, 200)
    end

    it "grip :top_left, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:top_left).should == Make.point(100, 300)
    end

    it "#top_left, no offset" do
    	Make.rect(100, 100, 200, 200).top_left.should == Make.point(100, 300)
    end

    it "#top_left, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).top_left([10, 20]).should == Make.point(110, 320)
    end
  end

  describe "position top_center" do
    it "waypoint :top_center, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:top_center).should == Make.point(100, 200)
    end

    it "grip :top_center, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:top_center).should == Make.point(200, 300)
    end

    it "#top_center, no offset" do
    	Make.rect(100, 100, 200, 200).top_center.should == Make.point(200, 300)
    end

    it "#top_center, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).top_center([10, 20]).should == Make.point(210, 320)
    end
  end

  describe "position top_right" do
    it "waypoint :top_right, no offset" do
    	Make.rect(100, 100, 200, 200).waypoint(:top_right).should == Make.point(200, 200)
    end

    it "grip :top_right, no offset" do
    	Make.rect(100, 100, 200, 200).grip(:top_right).should == Make.point(300, 300)
    end

    it "#top_right, no offset" do
    	Make.rect(100, 100, 200, 200).top_right.should == Make.point(300, 300)
    end

    it "#top_right, offset [10, 20]" do
    	Make.rect(100, 100, 200, 200).top_right([10, 20]).should == Make.point(310, 320)
    end
  end
  
 end
