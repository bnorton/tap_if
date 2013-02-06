require "spec_helper"

describe :tap_if do
  before do
    @foo = mock("foo", :bar => nil)
    @block = lambda {|*| @foo.bar }
  end

  it "should be a method on all objects" do
    Object.new.methods.should include(:tap_if)
    Object.methods.should include(:tap_if)
  end

  describe 'when the block takes no arguments' do
    it 'should execute the block' do
      @foo.should_receive(:bar)

      true.tap_if { @foo.bar }
    end
  end

  describe 'when the block takes some arguments' do
    before do
      @value = nil
      @block = lambda {|t| @value = t; @foo.bar }
    end

    it 'should execute the block' do
      @foo.should_receive(:bar)

      true.tap_if(&@block)
    end

    it 'should yield the caller' do
      "foo-true".tap_if(&@block)

      @value.should == "foo-true"
    end
  end

  describe "when the method evaluates to true" do
    [[Array.new, :empty?], [{:f => :d}, :key?, :f]].each do |type, *args|
      it "should tap #{type.inspect}.#{args.first}" do
        @foo.should_receive(:bar)

        type.tap_if(*args, &@block)
      end

      it "should return the value" do
        type.tap_if(*args, &@block).object_id.should == type.object_id
      end
    end
  end

  describe "when the method evaluates to false" do
    [[Array.new, :any?], [{:f => :d}, :key?, :x]].each do |type, *args|
      it "should not tap #{type.inspect}.#{args.first}" do
        @foo.should_not_receive(:bar)

        type.tap_if(*args, &@block)
      end

      it "should return the value" do
        type.tap_if(*args, &@block).object_id.should == type.object_id
      end
    end
  end

  describe "when the method is not defined" do
    [[nil, :any?], [[], :keys]].each do |type, *args|
      it "should not tap #{type.inspect}.#{args.first}" do
        @foo.should_not_receive(:bar)

        type.tap_if(*args, &@block)
      end
    end
  end

  describe "when the target is truthy" do
    [true, "", 1, [], {}, 0, :foo].each do |type|
      it "should tap #{type.inspect}" do
        @foo.should_receive(:bar)

        type.tap_if(&@block)
      end

      it "should return the value" do
        type.tap_if(&@block).object_id.should == type.object_id
      end
    end
  end

  describe "when the target is falsey" do
    [false, nil, def method; end].each do |type|
      it "should not tap #{type.inspect}" do
        @foo.should_not_receive(:bar)

        type.tap_if(&@block)
      end

      it "should return the value" do
        type.tap_if(&@block).object_id.should == type.object_id
      end
    end
  end
end
