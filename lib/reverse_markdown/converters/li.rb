module ReverseMarkdown
  module Converters
    class Li < Base
      def convert(node, index)
        content     = treat_children(node)
        indentation = indentation_for(node)
        prefix      = prefix_for(node)

        content.strip.lines.each_with_index.map do |line, index|
          if index == 0
            "#{indentation}#{prefix}#{line.sub(/\n*/m, "")}"
          elsif line =~ /^\s*$/
            "\n"
          else
            "  #{indentation}#{line.sub(/\n*/m, "")}"
          end
        end.join + "\n"
      end

      def prefix_for(node)
        if node.parent.name == 'ol'
          index = node.parent.xpath('li').index(node)
          "#{index.to_i + 1}. "
        else
          '- '
        end
      end

      def indentation_for(node)
        length = node.ancestors('ol').size + node.ancestors('ul').size
        '  ' * [length - 1, 0].max
      end
    end
  end
end
