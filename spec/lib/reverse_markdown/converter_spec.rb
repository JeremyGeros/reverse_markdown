require 'spec_helper'

describe ReverseMarkdown::Converter do
  let(:converter) { ReverseMarkdown.new }

  it "supports custom converter registration" do
    converter.register(:p, Class.new(ReverseMarkdown::Converters::Base) do
      def convert(node, index)
        "custom"
      end
    end.new)

    input = "<div><p>some text</div></p>"
    expect(converter.convert("<div><p>some text</p></div>")).to eq("custom\n")
    expect(ReverseMarkdown.convert(input)).to eq("some text\n\n")
  end
end