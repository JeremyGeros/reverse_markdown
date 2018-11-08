require 'spec_helper'

describe ReverseMarkdown::Converters::Del do
  let(:converter) do
    ReverseMarkdown.new(github_flavored: github_flavored)
  end

  context 'with github_flavored = true' do
    let(:github_flavored) { true }

    it 'converts the input as expected' do
      input = '<del>deldeldel</del>'
      expect(converter.convert(input)).to eq ' ~~deldeldel~~ '
    end

    it 'skips empty tags' do
      input = '<del></del>'
      expect(converter.convert(input)).to eq ''
    end
  end

  context 'with github_flavored = false' do
    let(:github_flavored) { false }

    it 'does not convert anything' do
      input = '<del>deldeldel</del>'
      expect(converter.convert(input)).to eq 'deldeldel'
    end
  end
end
