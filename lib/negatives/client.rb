require 'faraday'
require 'faraday_stack/follow_redirects'

module Negatives
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options = {})
      options = Negatives.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def request(url)
      uri = URI.parse(url)

      connection(uri).get "#{uri.path}?#{uri.query}"
    end

    def connection(uri)
      Faraday.new(merged_options(uri)) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use FaradayStack::FollowRedirects
        builder.use Faraday::Response::RaiseError
        builder.adapter(adapter)
      end
    end

    def merged_options(uri)
      connection_options.merge({
        :headers => {
          'User-Agent' => user_agent
        },
        :proxy => proxy,
        :url => "#{uri.scheme}://#{uri.host}"
      })
    end

  end
end