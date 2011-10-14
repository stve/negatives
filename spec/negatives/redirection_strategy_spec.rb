require 'spec_helper'

describe Negatives::RedirectionStrategy do
  describe '#process' do
    before do
      stub_redirect('http://yfrog.com/1234', 'http://yfrog.com/abc')
      stub_success('http://yfrog.com/abc')

      @uri = nil
      @strategy = Negatives::RedirectionStrategy.new(/yfrog/) { |uri| @uri = uri }
    end

    it 'follows redirects' do
      @strategy.process('http://yfrog.com/1234')
      @uri.to_s.should eq('http://yfrog.com/abc')
    end

    it 'yields a URI' do
      @strategy.process('http://yfrog.com/abc')
      @uri.should be_kind_of(URI)
    end
  end
end