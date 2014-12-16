module ReverseMarkdown
  module Converters
    class Base
      def treat_children(node)
        node.children.each_with_index.inject('') do |memo, pair|
          child = pair[0]
          index = pair[1]
          memo << treat(child, index)
        end
      end

      def treat(node, index)
        ReverseMarkdown::Converters.lookup(node.name).convert(node, index)
      end

      def escape_keychars(string)
        string.gsub(/[\*\_]/, '*' => '\*', '_' => '\_')
      end

      def extract_title(node)
        title = escape_keychars(node['title'].to_s)
        title.empty? ? '' : %[ "#{title}"]
      end
    end
  end
end
