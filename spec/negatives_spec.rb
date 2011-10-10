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
end