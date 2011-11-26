require 'net/http'
require 'nokogiri'

module Negatives
  class DomStrategy < Strategy

    def process(url)
      response = request(url)
      doc = Nokogiri::HTML(response.body)
      @block.call(doc)
    end

    private
    def request(url)
      client.get(url)
    end

    def client
      Client.new
    end
  end
end