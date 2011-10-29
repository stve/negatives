require 'net/http'
require 'nokogiri'

module Negatives
  class DomStrategy < RedirectionStrategy

    def process(url)
      response = request(url)
      doc = Nokogiri::HTML(response.body)
      @block.call(doc)
    end
  end
end