require 'roe'

module Negatives
  class OembedStrategy < RedirectionStrategy

    def process(url)
      oembed_data = Roe.resolve(follow(url))
      @block.call(oembed_data)
    end
  end
end