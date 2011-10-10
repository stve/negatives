require 'net/http'

module Negatives
  class Strategy

    attr_accessor :regex, :block

    def initialize(regex, &block)
      @regex = regex
      @block = block
    end

    def match?(url)
      !(url =~ @regex).nil?
    end

    def process(url)
      uri = URI.parse(redirect(url))
      @block.call(uri)
    end

    def redirect(url)
      response = Net::HTTP.get_response(URI.parse(url))

      count = 0
      while count < 3 && response.kind_of?(Net::HTTPRedirection)
        url = response['location']
        response = Net::HTTP.get_response(URI.parse(url))

        count += 1
      end

      url
    end
  end
end