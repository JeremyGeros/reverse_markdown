module ReverseMarkdown
  module Converters
    class Em < Base
      def convert(node, index)
        content = treat_children(node)
        if content.strip.empty? || already_italic?(node)
          content
        else
          "_#{content}_"
        end
      end

      def already_italic?(node)
        node.ancestors('italic').size > 0 || node.ancestors('em').size > 0
      end
    end
  end
end
