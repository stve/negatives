require 'negatives/strategy'
require 'negatives/dom_strategy'
require 'negatives/oembed_strategy'
require 'negatives/redirection_strategy'

module Negatives
  extend self

  MIME_TYPES = %w(image/jpeg image/gif image/pjpeg image/png)
  EXTENSIONS = %w(jpeg jpg gif png)

  @matchers = []

  def extract(url)
    return unless url

    strategies.each do |strategy|
      return strategy.process(url) if strategy.match?(url)
    end

    return url if image?(url)

    nil
  end

  private
  def strategies
    return @matchers unless @matchers.empty?

    # link shorteners
    @matchers << RedirectionStrategy.new(/bit\.ly/) { |uri| uri.to_s }
    @matchers << RedirectionStrategy.new(/t\.co/) { |uri| uri.to_s }
    @matchers << RedirectionStrategy.new(/fb\.me/) { |uri| uri.to_s }

    # image services
    @matchers << Strategy.new(/yfrog\.com/) { |uri| "http://yfrog.com#{uri.path}:medium" }
    @matchers << Strategy.new(/twitpic\.com/) { |uri| "http://twitpic.com/show/full#{uri.path}" }
    @matchers << Strategy.new(/twitgoo\.com/) { |uri| "http://twitgoo.com/show/img#{uri.path}" }
    @matchers << Strategy.new(/img\.ly/) { |uri| "http://img.ly/show/full#{uri.path}" }
    @matchers << Strategy.new(/plixi\.com/) { |uri| "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=large&url=#{uri}" }
    @matchers << Strategy.new(/moby\.to/) { |uri| "http://moby.to#{uri.path}:full" }
    @matchers << Strategy.new(/imgur\.com/) { |uri| "http://i.imgur.com/#{uri.path.split('/').last}.jpg" }

    # oembed interpreters
    @matchers << OembedStrategy.new(/instagr\.am/) { |data| data.thumbnail_url }

    # dom interpreters
    @matchers << DomStrategy.new(/posterous\.com/) { |dom| dom.at_css('img[width="500"]')['src'] }

    @matchers
  end

  def image?(url)
    uri = URI.parse(url)
    EXTENSIONS.include?(uri.path.split('.').last)
  end
end
