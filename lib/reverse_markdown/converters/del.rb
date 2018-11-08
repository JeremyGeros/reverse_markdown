module ReverseMarkdown
  module Converters
    class Del < Base
      def convert(node, index)
        content = treat_children(node)
        if content.strip.empty? || already_crossed_out?(node)
          content
        else
          "~~#{content}~~"
        end
      end

      def already_crossed_out?(node)
        node.ancestors('del').size > 0 || node.ancestors('strike').size > 0
      end
    end
  end
end
