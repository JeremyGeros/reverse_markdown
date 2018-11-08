module ReverseMarkdown
  module Converters
    class Bypass < Base
      def convert(node, index)
        treat_children(node)
      end
    end
  end
end
