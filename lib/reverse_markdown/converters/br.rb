module ReverseMarkdown
  module Converters
    class Br < Base
      def convert(node, index)
        "  \n"
      end
    end

    register :br, Br.new
  end
end
