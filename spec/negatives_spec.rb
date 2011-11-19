require 'spec_helper'

describe Negatives do

  describe '.extract' do
    before(:all) do
      stub_success('http://twitpic.com/foobar')
    end

    it 'returns nil when no match found' do
      Negatives.extract('foobar').should be_nil
    end

    it 'returns nil when no argument' do
      Negatives.extract(nil).should be_nil
    end

    it 'allows photo urls to pass through' do
      Negatives.extract('http://randomurl.com/image.jpg').should eq('http://randomurl.com/image.jpg')
    end

    it "shouldn't blow up on non-image urls" do
      Negatives.extract('http://something.com/about/').should be_nil
    end

    it 'returns the url when a match is found' do
      Negatives.extract('http://twitpic.com/foobar').should eq("http://twitpic.com/show/full/foobar")
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Negatives.adapter.should == Negatives::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Negatives.adapter = :typhoeus
      Negatives.adapter.should == :typhoeus
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Negatives.user_agent.should == Negatives::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Negatives.user_agent = 'Custom User Agent'
      Negatives.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do
    Negatives::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Negatives.configure do |config|
          config.send("#{key}=", key)
          Negatives.send(key).should == key
        end
      end
    end
  end

end