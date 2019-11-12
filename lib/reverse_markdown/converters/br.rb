module ReverseMarkdown
  module Converters
    class Br < Base
      def convert(node, index)
        "  \n"
      end
    end
  end
end
