require 'digest'
require 'nokogiri'
require 'reverse_markdown/version'
require 'reverse_markdown/errors'
require 'reverse_markdown/cleaner'
require 'reverse_markdown/config'
require 'reverse_markdown/converter_registry'
require 'reverse_markdown/converters/base'
require 'reverse_markdown/converters/a'
require 'reverse_markdown/converters/blockquote'
require 'reverse_markdown/converters/br'
require 'reverse_markdown/converters/bypass'
require 'reverse_markdown/converters/code'
require 'reverse_markdown/converters/del'
require 'reverse_markdown/converters/div'
require 'reverse_markdown/converters/drop'
require 'reverse_markdown/converters/em'
require 'reverse_markdown/converters/h'
require 'reverse_markdown/converters/hr'
require 'reverse_markdown/converters/ignore'
require 'reverse_markdown/converters/img'
require 'reverse_markdown/converters/li'
require 'reverse_markdown/converters/ol'
require 'reverse_markdown/converters/p'
require 'reverse_markdown/converters/pass_through'
require 'reverse_markdown/converters/pre'
require 'reverse_markdown/converters/raise'
require 'reverse_markdown/converters/strong'
require 'reverse_markdown/converters/table'
require 'reverse_markdown/converters/td'
require 'reverse_markdown/converters/text'
require 'reverse_markdown/converters/tr'
require 'reverse_markdown/converter'

module ReverseMarkdown
  def self.new(options = {})
    converter = ReverseMarkdown::Converter.new(options)
    register_defaults(converter, github_flavored: options[:github_flavored])
    converter
  end

  def self.convert(input, options = {})
    converter = self.new(options)
    converter.convert(input)
  end

  def self.register_defaults(converter, github_flavored: false)
    converter.register :a, Converters::A.new
    converter.register :blockquote, Converters::Blockquote.new
    converter.register :br, Converters::Br.new
    converter.register :document, Converters::Bypass.new
    converter.register :html, Converters::Bypass.new
    converter.register :body, Converters::Bypass.new
    converter.register :span, Converters::Bypass.new
    converter.register :thead, Converters::Bypass.new
    converter.register :tbody, Converters::Bypass.new
    converter.register :code, Converters::Code.new

    del_converter = github_flavored ? Converters::Del.new : Converters::Bypass.new
    converter.register :strike, del_converter
    converter.register :del, del_converter

    converter.register :div, Converters::Div.new
    converter.register :em, Converters::Em.new
    converter.register :i, Converters::Em.new
    converter.register :h1, Converters::H.new
    converter.register :h2, Converters::H.new
    converter.register :h3, Converters::H.new
    converter.register :h4, Converters::H.new
    converter.register :h5, Converters::H.new
    converter.register :h6, Converters::H.new
    converter.register :hr, Converters::Hr.new
    converter.register :colgroup, Converters::Ignore.new
    converter.register :col, Converters::Ignore.new
    converter.register :img, Converters::Img.new
    converter.register :li, Converters::Li.new
    converter.register :ol, Converters::Ol.new
    converter.register :ul, Converters::Ol.new
    converter.register :p, Converters::P.new

    if github_flavored
      converter.register :pre, Converters::GithubPre.new
    else
      converter.register :pre, Converters::Pre.new
    end

    converter.register :strong, Converters::Strong.new
    converter.register :b, Converters::Strong.new
    converter.register :table, Converters::Table.new
    converter.register :td, Converters::Td.new
    converter.register :th, Converters::Td.new
    converter.register :text, Converters::Text.new
    converter.register :tr, Converters::Tr.new
  end
end