module ReverseMarkdown
  module Converters
    class Hr < Base
      def convert(node, index)
        "\n* * *\n"
      end
    end

    register :hr, Hr.new
  end
end
