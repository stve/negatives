require 'spec_helper'

describe Negatives::OembedStrategy do
  describe '#process' do
    before do
      @json = '{ "thumbnail_url" : "http://s3.com/gogo.jpg" }'
      stub_success('http://instagr.am/foo')
      stub_success('http://api.instagram.com/oembed?format=json&url=http://instagr.am/foo', @json)

      @oembed = nil
      @strategy = Negatives::OembedStrategy.new(/instagr\.am/) { |oembed| @oembed = oembed }
    end

    it 'yields a Hashie::Rash' do
      @strategy.process('http://instagr.am/foo')
      @oembed.should be_kind_of(Hashie::Rash)
    end
  end
end