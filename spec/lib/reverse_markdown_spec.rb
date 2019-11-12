require 'spec_helper'

describe ReverseMarkdown do
  let(:input)    { File.read('spec/assets/minimum.html') }
  let(:document) { Nokogiri::HTML(input) }

  it "parses nokogiri documents" do
    expect { ReverseMarkdown.convert(document) }.not_to raise_error
  end

  it "parses nokogiri elements" do
    expect { ReverseMarkdown.convert(document.root) }.not_to raise_error
  end

  it "parses string input" do
    expect { ReverseMarkdown.convert(input) }.not_to raise_error
  end

  it "behaves in a sane way when root element is nil" do
    expect(ReverseMarkdown.convert(nil)).to eq ''
  end

  it 'keeps spaces inside []' do
    result = ReverseMarkdown.convert("<p>[ ]</p>", unknown_tags: 
    :bypass, github_flavored: true)
    expect(result).to eq "[ ]\n\n"
  end

  it 'converts &nbsp; to space' do
    result = ReverseMarkdown.convert("<p>[&nbsp;]</p>", unknown_tags: 
    :bypass, github_flavored: true)
    expect(result).to eq "[ ]\n\n"
  end

end
