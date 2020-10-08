require 'spec_helper'

describe ReverseMarkdown do

  let(:input)    { File.read('spec/assets/lists.html') }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseMarkdown.convert(input) }

  it { should match /\n- unordered list entry\n/ }
  it { should match /\n- unordered list entry 2\n/ }
  it { should match /\n1. ordered list entry\n/ }
  it { should match /\n2. ordered list entry 2\n/ }
  it { should match /\n1. list entry 1st hierarchy\n/ }
  it { should match /\n2. - nested unsorted list entry\n/ }
  it { should match /\n   - 1. deep nested list entry\n/ }

  context "nested list with no whitespace" do
    it { should include <<~NESTED_WS }
      - item a
      - item b
        - item bb
        - item bc
    NESTED_WS
  end

  context "nested list with lots of whitespace" do
    it { should include <<~NESTED_WS }
      - item wa
      - item wb 
        - item wbb
        - item wbc
    NESTED_WS
  end

  context "lists containing links" do
    it { should match /\n- \[1 Basic concepts\]\(Basic_concepts\)\n/ }
    it { should match /\n- \[2 History of the idea\]\(History_of_the_idea\)\n/ }
    it { should match /\n- \[3 Intelligence explosion\]\(Intelligence_explosion\)\n/ }
  end

  context "lists containing embedded <p> tags" do
    it { should match /\n- I want to have a party at my house!\n/ }
  end

  context "unordered list item containing multiple <p> tags" do
    it { should include <<~UL_WITH_PARAGRAPHS }
      - li 1, p 1

        li 1, p 2
      - li 2, p 1
    UL_WITH_PARAGRAPHS
  end

  context "ordered list item containing multiple <p> tags" do
    it { should include <<~OL_WITH_PARAGRAPHS }
      1. li 1, p 1

         li 1, p 2
      2. li 2, p 1
    OL_WITH_PARAGRAPHS
  end

  context 'it produces correct numbering' do
    it { should include <<~OL_WITH_PARAGRAPHS }
      1. one 
         1. one one
         2. one two
      2. two 
         1. two one 
            1. two one one
            2. two one two
         2. two two
      3. three
    OL_WITH_PARAGRAPHS
  end
end
