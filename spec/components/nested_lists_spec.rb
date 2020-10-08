require 'spec_helper'

describe ReverseMarkdown do
  let(:input)    { File.read('spec/assets/nested_lists.html') }
  let(:document) { Nokogiri::HTML(input) }

  subject { ReverseMarkdown.convert(input) }

  it { should eq <<~NESTED_LIST }
    some text before the list

    - Item 1
    - Item 2

    1. First level

       With a paragraph
    2. First level
    3. First level

       With a paragraph
    4. First level
    5. First level
    6. First level
    7. First level
    8. First level
    9. First level
    10. First level
        - Second level
        - Second level

          With a paragraph
          1. Third level

             With a paragraph
    11. First level

    some text after the list

  NESTED_LIST
end
