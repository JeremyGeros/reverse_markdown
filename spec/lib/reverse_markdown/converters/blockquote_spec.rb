require 'spec_helper'

describe ReverseMarkdown::Converters::Blockquote do
  let(:converter) { ReverseMarkdown.new }

  it 'converts nested elements as well' do
    input = "<blockquote><ul><li>foo</li></ul></blockquote>"
    result = converter.convert(input)
    expect(result).to eq "> - foo"
  end

  it 'can deal with paragraphs inside' do
    input = "<blockquote><p>Some text.</p><p>Some more text.</p></blockquote>"
    result = converter.convert(input)
    expect(result).to eq "> Some text.\n> \n> Some more text."
  end
end
