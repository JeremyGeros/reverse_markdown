module ReverseMarkdown
  module Converters
    class Blockquote < Base
      def convert(node, index)
        content = treat_children(node).strip
        content = ReverseMarkdown::Cleaner.new.remove_newlines(content)
        '> ' << content.lines.to_a.join('> ')
      end
    end
  end
end
