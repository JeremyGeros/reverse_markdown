require 'base64'

module ReverseMarkdown
  module Converters
    class Pre < Base
      def convert(node, index)
        "\n\n    " << node.text.strip.lines.to_a.join("    ") << "\n\n"
      end
    end

    class GithubPre < Base
      def convert(node, index)
        "```\n" << node.text.strip << "\n```\n"
      end
    end
  end
end
