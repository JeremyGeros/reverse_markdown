module ReverseMarkdown
  module Converters
    class Tr < Base
      def convert(node, index)
        content = treat_children(node).rstrip
        result  = "|#{content}\n"
        (table_header_row?(node) || index == 0 || !table_has_heading) ? result + underline_for(node) : result
      end

      def table_header_row?(node)
        node.element_children.all? {|child| child.name.to_sym == :th}
      end

      def underline_for(node)
        did_insert_table_heading
        "| " + (['---'] * node.element_children.size).join(' | ') + " |\n"
      end
    end

    register :tr, Tr.new
  end
end
