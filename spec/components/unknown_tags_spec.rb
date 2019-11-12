require 'spec_helper'

describe ReverseMarkdown do

  let(:input)    { File.read('spec/assets/unknown_tags.html') }
  let(:document) { Nokogiri::HTML(input) }
  let(:result)   { ReverseMarkdown.convert(input, {unknown_tags: unknown_tags}) }

  context 'with unknown_tags = :pass_through' do
    let(:unknown_tags) { :pass_through }

    it { expect(result).to include "<bar>Foo with bar</bar>" }
  end

  context 'with unknown_tags = :raise' do
    let(:unknown_tags) { :raise }

    it { expect { result }.to raise_error(ReverseMarkdown::UnknownTagError) }
  end

  context 'with unknown_tags = :drop' do
    let(:unknown_tags) { :drop }

    it { expect(result).to eq '' }
  end

  context 'with unknown_tags = :bypass' do
    let(:unknown_tags) { :bypass }

    it { expect(result).to eq "Foo with bar\n\n" }
  end

  context 'with unknown_tags = :something_wrong' do
    let(:unknown_tags) { :something_wrong }

    it { expect { result }.to raise_error(ReverseMarkdown::InvalidConfigurationError) }
  end
end

