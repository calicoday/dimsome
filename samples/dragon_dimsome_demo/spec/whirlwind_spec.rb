# The 'Whirl-wind Tour' from the [README for the original Bacon](https://github.com/leahneukirchen/bacon)

describe 'A new array' do
  before do
    @ary = Array.new
  end

  it 'should be empty' do
    @ary.should.be.empty
    @ary.should.not.include 1
  end

  it 'should have zero size' do
    @ary.size.should.equal 0
    @ary.size.should.be.close 0.1, 0.5
  end

  it 'should raise on trying fetch any index' do
#     lambda { @ary.fetch 0 }.
#       should.raise(IndexError).
#       message.should.match(/out of array/)

    # Alternatively:
#     should.raise(NameError) { @ary.fetch 0 }
    should.raise(IndexError) { @ary.fetch 0 }
  end

  it 'should have an object identity' do
    @ary.should.not.be.same_as Array.new
  end

  # Custom assertions are trivial to do, they are lambdas returning a
  # boolean vale:
  palindrome = lambda { |obj| obj == obj.reverse }
  it 'should be a palindrome' do
    @ary.should.be.a palindrome
  end

  it 'should have super powers' do
    should.flunk "no super powers found"
  end
end