module Negatives
  class Strategy

    attr_accessor :pattern, :block

    def initialize(pattern, &block)
      @pattern = pattern
      @block = block
    end

    def match?(url)
      @pattern.match(url)
    end

    def process(url)
      uri = URI.parse(url)
      @block.call(uri)
    end
  end
end