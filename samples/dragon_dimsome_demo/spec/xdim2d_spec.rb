puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "Dim2d" do
  before do
    @dim = Make.dim2d(100, 200)
  end

  describe "#to_ary" do
    it "should allow parallel assigment" do
      one, two = Make.dim2d(10, 20)
      one.should == 10.0
      two.should == 20.0
    end
  end

  describe "#==" do
    it "works" do
      dim = Make.dim2d(100, 200)
      dim.should == @dim
    end
	end

  describe "::make" do
    it "works with 2 nums" do
    	dim = Make.dim2d(100, 200)
### switching on global $test_cg_dims!!!
    	dim.inspect.should == ($test_cg_dims ?
    		"#<CGSize width=100.0 height=200.0>" :
    		"Dimsome::RubyDim2d(100, 200)")
#     	dim.inspect.should == "Dimsome::RubyDim2d(100, 200)"
    	dim.to_ary.should == [100, 200]
    end
    it "works with no args" do
      dim = Make.dim2d()
      dim.to_ary.should == [0, 0]
    end
    it "works with 1 num_pair" do
      dim = Make.dim2d([100, 200])
      dim.should == @dim
    end
    it "works with something that repond_to?(:to_ary)" do
      dim = Make.dim2d(@dim)
      dim.should == @dim
    end
  end
end
