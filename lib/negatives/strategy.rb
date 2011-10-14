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
      uri = URI.parse(url)
      @block.call(uri)
    end
  end
end