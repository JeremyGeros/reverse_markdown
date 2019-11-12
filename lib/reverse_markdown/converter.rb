module ReverseMarkdown
  class Converter
    def initialize(options = {})
      @options = options
      @config = Config.new
      @config.apply(options)
      @converters = ConverterRegistry.new(@config)
      yield self if block_given?
    end
    
    def register(tags, converter)
      @converters.register(tags, converter)
      self
    end

    def convert(input)
      root = case input
        when String                  then Nokogiri::HTML(input).root
        when Nokogiri::XML::Document then input.root
        when Nokogiri::XML::Node     then input
      end

      root or return ''
      result = @converters.lookup(root.name).convert(root, 0)
      cleaner.tidy(result, @options)
    end

    def cleaner
      @cleaner ||= Cleaner.new
    end
  end
end