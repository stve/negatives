require 'spec_helper'

describe Negatives::Strategy do
  describe '.new' do
    it 'initializes with a regex and a proc' do
      strategy = Negatives::Strategy.new(/yfrog/) { |uri| }
      strategy.regex.should be_kind_of(Regexp)
      strategy.block.should be_kind_of(Proc)
    end
  end

  describe '#match?' do
    before(:all) do
      @strategy = Negatives::Strategy.new(/yfrog/) { |uri| }
    end

    it 'returns true when a match' do
      @strategy.match?('http://yfrog.com').should be_true
    end

    it 'return false when no match' do
      @strategy.match?('http://twitpic.com').should be_false
    end
  end

  describe '#process' do
    before do
      stub_success('http://twitpic.com/omg')
      stub_success('http://yfrog.com/abc')

      stub_redirect('http://yfrog.com/1234', 'http://yfrog.com/abc')

      @uri = nil
      @strategy = Negatives::Strategy.new(/yfrog/) { |uri| @uri = uri }
    end

    it 'yields a URI' do
      @strategy.process('http://twitpic.com/omg')
      @uri.should be_kind_of(URI)
      @uri.path.should eq('/omg')
    end

    it 'follows redirects' do
      @strategy.process('http://yfrog.com/1234')
      @uri.to_s.should eq('http://yfrog.com/abc')
    end
  end
end