module ReverseMarkdown
  module Converters
    class Li < Base
      def convert(node, index)
        content     = treat_children(node)
        prefix      = prefix_for(node)

        content.strip.lines.each_with_index.map do |line, index|
          if index == 0
            "#{prefix}#{line.sub(/\n*/m, "")}"
          elsif line == "\n"
            # We only need empty lines between items when it's a paragraph inside the list (handled below)
            nil
          else
            # For ordered lists, the indentation needs to match the line above it, e.g. 3 spaces to indent
            # a paragraph after "3. " (not two spaces).
            # See https://docs.gitlab.com/ee/user/markdown.html#lists
            indentation = " " * prefix.size

            # For paragraphs in the same <li>, we need to add newlines first
            indentation = "\n\n#{indentation}" unless line =~ /- |\d+\. /

            # Nested list item
            "#{indentation}#{line.sub(/\n*/m, "")}"
          end
        end.compact.join + "\n"
      end

      def prefix_for(node)
        if node.parent.name == 'ol'
          index = node.parent.xpath('li').index(node)
          "#{index.to_i + 1}. "
        else
          '- '
        end
      end
    end
  end
end
