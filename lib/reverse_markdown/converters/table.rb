module ReverseMarkdown
  module Converters
    class Table < Base
      def convert(node, index)
        table_did_begin
        content = "\n\n" << treat_children(node) << "\n"
        table_did_end
        content
      end
    end
  end
end
