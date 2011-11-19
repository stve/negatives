require 'negatives/configuration'
require 'negatives/strategy'
require 'negatives/redirection_strategy'
require 'negatives/dom_strategy'
require 'negatives/oembed_strategy'

module Negatives
  extend Configuration
  extend self

  MIME_TYPES = %w(image/jpeg image/gif image/pjpeg image/png)
  EXTENSIONS = %w(jpeg jpg gif png)

  @strategies = []

  # image services
  @strategies << Strategy.new(/yfrog\.com/) { |uri| "http://yfrog.com#{uri.path}:medium" }
  @strategies << Strategy.new(/twitpic\.com/) { |uri| "http://twitpic.com/show/full#{uri.path}" }
  @strategies << Strategy.new(/twitgoo\.com/) { |uri| "http://twitgoo.com/show/img#{uri.path}" }
  @strategies << Strategy.new(/img\.ly/) { |uri| "http://img.ly/show/full#{uri.path}" }
  @strategies << Strategy.new(/plixi\.com/) { |uri| "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=large&url=#{uri}" }
  @strategies << Strategy.new(/moby\.to/) { |uri| "http://moby.to#{uri.path}:full" }
  @strategies << Strategy.new(/imgur\.com/) { |uri| "http://i.imgur.com/#{uri.path.split('/').last}.jpg" }

  # oembed interpreters
  @strategies << OembedStrategy.new(/instagr\.am/) { |data| data.thumbnail_url }

  # dom interpreters
  @strategies << DomStrategy.new(/posterous\.com/) { |dom| dom.at_css('img[width="500"]')['src'] }

  # link shorteners
  @strategies << RedirectionStrategy.new(/bit\.ly/) { |uri| uri.to_s }
  @strategies << RedirectionStrategy.new(/fb\.me/) { |uri| uri.to_s }
  @strategies << RedirectionStrategy.new(/t\.co/) { |uri| uri.to_s }

  def extract(url)
    return unless url

    @strategies.each do |strategy|
      return strategy.process(url) if strategy.match?(url)
    end

    return url if image?(url)

    nil
  end

  private
  def image?(url)
    uri = URI.parse(url)
    EXTENSIONS.include?(uri.path.split('.').last)
  end
end
