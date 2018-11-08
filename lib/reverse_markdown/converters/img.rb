module ReverseMarkdown
  module Converters
    class Img < Base
      def convert(node, index)
        alt   = node['alt']
        src   = node['src']
        title = extract_title(node)
        " ![#{alt}](#{src}#{title})"
      end
    end
  end
end
