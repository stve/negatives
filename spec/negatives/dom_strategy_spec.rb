require 'spec_helper'

describe Negatives::DomStrategy do
  describe '#process' do
    before do
      @html = "<html><body></body></html>"
      stub_request(:get, 'http://instagr.am/foo').to_return(:status => 200, :body => @html)

      @doc = nil
      @strategy = Negatives::DomStrategy.new(/instagra\.am/) { |doc| @doc = doc }
    end

    it 'yields a Nokogiri Document' do
      @strategy.process('http://instagr.am/foo')
      @doc.should be_kind_of(Nokogiri::HTML::Document)
    end
  end
end