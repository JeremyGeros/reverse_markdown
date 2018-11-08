module ReverseMarkdown
  module Converters
    class Ol < Base
      def convert(node, index)
        "\n" << treat_children(node)
      end
    end
  end
end
