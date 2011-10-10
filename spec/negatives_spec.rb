require 'spec_helper'

describe Negatives do
  describe '.extract' do
    before(:all) do
      stub_request(:get, 'http://twitpic.com/foobar').to_return(:status => 200, :body => "")
    end

    it 'returns nil when no match found' do
      Negatives.extract('foobar').should be_nil
    end

    it 'returns the url when a match is found' do
      Negatives.extract('http://twitpic.com/foobar').should eq("http://twitpic.com/show/full/foobar")
    end
  end
end