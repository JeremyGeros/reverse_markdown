module ReverseMarkdown
  module Converters
    class Ignore < Base
      def convert(node, index)
        '' # noop
      end
    end

    register :colgroup, Ignore.new
    register :col,      Ignore.new
  end
end
