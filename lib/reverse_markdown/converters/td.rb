module ReverseMarkdown
  module Converters
    class Td < Base
      def convert(node, index)
        content = treat_children(node)
        " #{content} |"
      end
    end

    register :td, Td.new
    register :th, Td.new
  end
end
