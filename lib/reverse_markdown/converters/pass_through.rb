module ReverseMarkdown
  module Converters
    class PassThrough < Base
      def convert(node, index)
        node.to_s
      end
    end
  end
end
