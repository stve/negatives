require 'faraday'
require 'faraday_stack/follow_redirects'

module Negatives
  class RedirectionStrategy < Strategy

    REDIRECT_LIMIT = 3

    def process(url)
      uri = URI.parse(resolve(url))
      @block.call(uri)
    end

    private
    def resolve(url)
      count = 0

      response = request(url)
      response.env[:url]
    end

    def request(url)
      uri = URI.parse(url)
      conn = Faraday.new "#{uri.scheme}://#{uri.host}" do |builder|
        builder.use FaradayStack::FollowRedirects
        builder.adapter(Faraday.default_adapter)
      end

      conn.get "#{uri.path}?#{uri.query}"
    end

  end
end