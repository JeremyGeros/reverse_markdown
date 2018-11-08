module ReverseMarkdown
  class Converter
    def initialize(options = {})
      @options = options
      @config = Config.new
      @config.apply(options)
      @converters = ConverterRegistry.new(@config)
    end
    
    def register(tag, converter)
      @converters.register(tag, converter)
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