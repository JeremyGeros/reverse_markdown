module ReverseMarkdown
  module Converters
    class H < Base
      def convert(node, index)
        prefix = '#' * node.name[/\d/].to_i
        ["\n", prefix, ' ', treat_children(node), "\n"].join
      end
    end
  end
end
