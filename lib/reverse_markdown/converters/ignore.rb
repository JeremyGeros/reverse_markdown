module ReverseMarkdown
  module Converters
    class Ignore < Base
      def convert(node, index)
        '' # noop
      end
    end
  end
end
