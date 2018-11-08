module ReverseMarkdown
  class ConverterRegistry
    def initialize(config)
      @config = config
      @default_converter = create_default_converter
      @default_converter.converters = self
      @converters = {}
    end

    def register(tag_names, converter)
      converter.converters = self

      Array(tag_names).each do |tag_name|
        @converters[tag_name.to_sym] = converter
      end
    end

    def lookup(tag_name)
      @converters[tag_name.to_sym] or @default_converter
    end

    private

    def create_default_converter
      case @config.unknown_tags.to_sym
      when :pass_through
        ReverseMarkdown::Converters::PassThrough.new
      when :drop
        ReverseMarkdown::Converters::Drop.new
      when :bypass
        ReverseMarkdown::Converters::Bypass.new
      when :raise
        ReverseMarkdown::Converters::Raise.new
      else
        raise InvalidConfigurationError, "unknown value #{@config.unknown_tags} for ReverseMarkdown.config.unknown_tags"
      end
    end
  end
end
