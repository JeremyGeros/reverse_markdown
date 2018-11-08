module ReverseMarkdown
  module Converters
    class Strong < Base
      def convert(node, index)
        content = treat_children(node)
        if content.strip.empty? || already_strong?(node)
          content
        else
          "**#{content}**"
        end
      end

      def already_strong?(node)
        node.ancestors('strong').size > 0 || node.ancestors('b').size > 0
      end
    end
  end
end
