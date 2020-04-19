puts "dims greeting: #{$dimsome_greeting}" if $give_greeting

describe "ModUtil" do
  before do
  	# we need an object of a class that includes ModPairs
    @dim = Make.dim2d(100, 200)
  end

  describe "#numeric_pair" do
    it "should work given numeric pair [100, 200]" do
      pair = @dim.numeric_pair([100, 200])
      pair.should == [100, 200]
    end
    it "should work given numeric pair [nil, 200]" do
      pair = @dim.numeric_pair([nil, 200])
      pair.should == [nil, 200]
    end
    it "should work given numeric pair [100, nil]" do
      pair = @dim.numeric_pair([100, nil])
      pair.should == [100, nil]
    end
    it "should work given numeric" do
      pair = @dim.numeric_pair(100)
      pair.should == [100, 100]
    end
    it "should work given numeric pair plus [nil, 200, nil, 'a', 345]" do
      pair = @dim.numeric_pair([nil, 200, nil, 'a', 345])
      pair.should == [nil, 200]
    end
    it "should work given obj that respond_to? :to_ary" do
    	class Thingamy
    		def to_ary() [nil, 200] end
    	end
    	pair = @dim.numeric_pair(Thingamy.new)
    	pair.should == [nil, 200]
    end
    ### currently numeric_pair DOES work given nil, returns [nil, nil] for no-op arith!!!
    it "should work given nil" do
      pair = @dim.numeric_pair(nil)
      pair.should == [nil, nil]
    end
    it "should return nil given short array [100]" do
      pair = @dim.numeric_pair([100])
      pair.should == nil
    end
    it "should return nil given obj that doesn't respond_to? :to_ary" do
    	s = "ooga booga"
    	# here in case some diff ruby String DOES respond_to? somehow:
    	s.respond_to?(:to_ary).should == false
    	pair = @dim.numeric_pair(false)
    	pair.should == nil
    end
  end

  describe "#strict_numeric_pair" do
    it "should work given numeric pair [100, 200]" do
      pair = @dim.strict_numeric_pair([100, 200])
      pair.should == [100, 200]
    end
    it "should return nil given nil" do
      pair = @dim.strict_numeric_pair(nil)
      pair.should == nil
    end
    it "should return nil given numeric pair with nil [nil, 200]" do
      pair = @dim.strict_numeric_pair([nil, 200])
      pair.should == nil
    end
    it "should return nil given numeric pair with nil [100, nil]" do
      pair = @dim.strict_numeric_pair([nil, 200])
      pair.should == nil
    end
  end

#   describe "#strict_numeric_pair_pair" do
#   end

  describe "::Pair#inspect" do
    it "should work on Make.dim2d(100.3, 200.456)" do
      dim = Make.dim2d(100.3, 200.456)
      s = dim.inspect
### switching on global $test_cg_dims!!!
      s.should == ($test_cg_dims ?
      	"#<CGSize width=100.3 height=200.456>" :
      	"Dimsome::RubyDim2d(100.3, 200.456)")
#       s.should == "Dimsome::RubyDim2d(100.3, 200.456)"
    end
  end

  describe "::Pair#insp" do
    it "should work on Make.dim2d(100.3, 200.456)" do
      dim = Make.dim2d(100, 200)
      s = dim.insp
### switching on global $test_cg_dims!!!
      s.should == ($test_cg_dims ?
      	"CGSize~(100, 200)" :
      	"RubyDim2d~(100, 200)")
#       s.should == "RubyDim2d~(100, 200)"
    end
  end

#   describe "::Rect#inspect" do
#   end
# 	
#   describe "::Rect#insp" do
#   end

end