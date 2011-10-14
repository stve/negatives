require 'net/http'

module Negatives
  class OembedStrategy < Strategy

    def process(url)
      # http://instagr.am/api/v1/oembed/?url=http://instagr.am/p/BT7lU/&maxwidth=500
      # uri = URI.parse(url)
      # response = Net::HTTP.get_response(uri)
      # doc = Nokogiri::HTML(response.body)
      @block.call(uri)
    end
  end
end