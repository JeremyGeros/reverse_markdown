module ReverseMarkdown
  module Converters
    class Raise < Base
      def convert(node, index)
        raise UnknownTagError, "unknown tag: #{node.name}"
      end
    end
  end
end
