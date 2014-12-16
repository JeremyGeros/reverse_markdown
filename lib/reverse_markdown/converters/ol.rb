module ReverseMarkdown
  module Converters
    class Ol < Base
      def convert(node, index)
        "\n" << treat_children(node)
      end
    end

    register :ol, Ol.new
    register :ul, Ol.new
  end
end
