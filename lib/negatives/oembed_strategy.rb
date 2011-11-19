require 'roe'

module Negatives
  class OembedStrategy < Strategy

    def process(url)
      oembed_data = Roe.resolve(url)
      @block.call(oembed_data)
    end
  end
end