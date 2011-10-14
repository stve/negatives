require 'net/http'
require 'nokogiri'

module Negatives
  class DomStrategy < Strategy

    def process(url)
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      doc = Nokogiri::HTML(response.body)
      @block.call(doc)
    end
  end
end