require 'spec_helper'

describe ReverseMarkdown::Converters::Li do
  it 'does not fail without a valid parent context' do
    input = Nokogiri::XML.parse("<li>foo</li>").root
    result = ReverseMarkdown.convert(input, 0)
    expect(result).to eq "- foo\n"
  end
end
