require 'negatives/client'

module Negatives
  class RedirectionStrategy < Strategy

    def process(url)
      uri = URI.parse(follow(url))
      @block.call(uri)
    end

    private
    def follow(url)
      response = request(url)
      response.env[:url]
    end

    def request(url)
      client.head(url)
    end

    def client
      Client.new
    end

  end
end