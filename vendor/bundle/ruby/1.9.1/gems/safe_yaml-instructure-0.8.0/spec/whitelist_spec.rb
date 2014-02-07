require File.join(File.dirname(__FILE__), "spec_helper")

describe SafeYAML::Whitelist do
  let(:whitelist) { SafeYAML::Whitelist.new }

  it "should start with the default whitelist" do
    whitelist.allowed.size.should > 0
  end

  it "should allow inserting and deleting tags" do
    whitelist.check('test1', nil).should == nil
    whitelist.add('test1')
    whitelist.check('test1', nil).should == :cacheable
    whitelist.remove('test1')
    whitelist.check('test1', nil).should == nil
  end

  it "should allow using a block" do
    whitelist.add('test1') { |val| val == 'ok' }
    whitelist.check('test1', 'bad').should == nil
    whitelist.check('test1', 'ok').should == :allowed
    whitelist.check('test1', 'bad').should == nil
    whitelist.remove('test1')
    whitelist.check('test1', 'ok').should == nil
  end

  it "overwrites on second add" do
    whitelist.add('test1') { |val| val == 'ok' }
    whitelist.add('test1') { |val| val == 'second' }
    whitelist.check('test1', 'ok').should == nil
    whitelist.check('test1', 'second').should == :allowed
  end

  it "should allow caching the block response" do
    counter = 0
    whitelist.add('test1') { |val| val == 'ok' && (counter += 1) && :cacheable }
    whitelist.check('test1', 'bad').should == nil
    whitelist.check('test1', 'ok').should == :cacheable
    whitelist.check('test1', 'bad').should == nil
    whitelist.check('test1', 'ok').should == :cacheable
    whitelist.check('test1', 'ok').should == :cacheable
    counter.should == 1
    whitelist.remove('test1')
    whitelist.check('test1', 'ok').should == nil
  end
end
