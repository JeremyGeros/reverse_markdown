module ReverseMarkdown
  module Converters
    class Div < Base
      def convert(node, index)
        "\n" << treat_children(node) << "\n"
      end
    end
  end
end
