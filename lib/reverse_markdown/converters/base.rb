module ReverseMarkdown
  module Converters
    class Base
      attr_writer :converters

      def treat_children(node)
        @table_did_begin = false
        node.children.each_with_index.inject('') do |memo, pair|
          child = pair[0]
          index = pair[1]
          memo << treat(child, index)
        end
      end

      def treat(node, index)
        # Handle nil here be transforming it to empty string
        # This can be nil when it's an empty table.
        @converters.lookup(node.name).convert(node, index) || ''
      end
      
      def table_did_begin
        @table_has_heading = false
        @table_did_begin = true
      end
      
      def table_did_end
        @table_did_begin = false
        @table_has_heading = false
      end
      
      def table_has_heading
        @table_has_heading
      end
      
      def did_insert_table_heading
        @table_has_heading = true
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
