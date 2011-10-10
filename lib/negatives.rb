require 'negatives/strategy'
require 'negatives/dom_strategy'

module Negatives
  extend self

  @matchers = []

  def extract(url)
    strategies.each do |strategy|
      return strategy.process(url) if strategy.match?(url)
    end

    nil
  end

  def strategies
    return @matchers unless @matchers.empty?

    # link shorteners
    @matchers << Strategy.new(/bit\.ly/) { |uri| uri.to_s }
    @matchers << Strategy.new(/t\.co/) { |uri| "http://yfrog.com#{uri.path}:medium" }
    @matchers << Strategy.new(/fb\.me/) { |uri| "http://yfrog.com#{uri.path}:medium" }

    # image services
    @matchers << Strategy.new(/yfrog\.com/) { |uri| "http://yfrog.com#{uri.path}:medium" }
    @matchers << Strategy.new(/twitpic\.com/) { |uri| "http://twitpic.com/show/full#{uri.path}" }
    @matchers << Strategy.new(/twitgoo\.com/) { |uri| "http://twitgoo.com/show/img#{uri.path}" }
    @matchers << Strategy.new(/img\.ly/) { |uri| "http://img.ly/show/full#{uri.path}" }
    @matchers << Strategy.new(/plixi\.com/) { |uri| "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=large&url=#{uri}" }
    @matchers << Strategy.new(/moby\.to/) { |uri| "http://moby.to/#{uri.path}:full" }

    # dom interpreters
    # @matchers << DomStrategy.new(/instagr\.am/) { |dom| dom.at('img.photo)[:src] }
    # @matchers << DomStrategy.new(/instagr\.am/) { |dom| dom.at('img[width=500])[:src] }

    @matchers
  end
end
