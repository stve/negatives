require 'spec_helper'

describe Negatives::OembedStrategy do
  describe '#process' do
    before do
      stub_redirect('http://yfrog.com/1234', 'http://yfrog.com/abc')
      stub_success('http://yfrog.com/abc')

      @uri = nil
      @strategy = Negatives::RedirectionStrategy.new(/instag\.am/) { |uri| @uri = uri }
    end

    it 'yields a URI' do
      pending
    end
  end
end