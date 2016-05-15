module ReverseMarkdown
  class Cleaner

    def tidy(string, options)
      result = remove_inner_whitespaces(string)
      result = remove_newlines(result)
      result = remove_leading_newlines(result)
      result = clean_tag_borders(result, options)
      result = remove_non_breaking_whitespace(result)
      clean_punctuation_characters(result)
    end

    def remove_newlines(string)
      string.gsub(/\n{3,}/, "\n\n")
    end

    def remove_leading_newlines(string)
      string.gsub(/\A\n+/, '')
    end

    def remove_inner_whitespaces(string)
      string.each_line.inject("") do |memo, line|
        memo + preserve_border_whitespaces(line) do
          line.strip.gsub(/[ \t]{2,}/, ' ')
        end
      end
    end

    def remove_non_breaking_whitespace(string)
      string.gsub(/&nbsp;/, ' ')
    end

    # Find non-asterisk content that is enclosed by two or
    # more asterisks. Ensure that only one whitespace occurs
    # in the border area.
    # Same for underscores and brackets.
    def clean_tag_borders(string, options)
      result = string.gsub(/\s?\*{2,}.*?\*{2,}\s?/) do |match|
        preserve_border_whitespaces(match, default_border: ' ') do
          match.strip.sub('** ', '**').sub(' **', '**')
        end
      end

      result = result.gsub(/\s?\_{2,}.*?\_{2,}\s?/) do |match|
        preserve_border_whitespaces(match, default_border: ' ') do
          match.strip.sub('__ ', '__').sub(' __', '__')
        end
      end

      result = result.gsub(/\s?~{2,}.*?~{2,}\s?/) do |match|
        preserve_border_whitespaces(match, default_border: ' ') do
          match.strip.sub('~~ ', '~~').sub(' ~~', '~~')
        end
      end

      result.gsub(/\s?\[.*?\]\s?/) do |match|
        preserve_border_whitespaces(match) do
          if options[:github_flavored]
            match.strip.sub('[', '[').sub(']', ']')
          else
            match.strip.sub('[ ', '[').sub(' ]', ']')
          end
        end
      end
    end

    def clean_punctuation_characters(string)
      string.gsub(/(\*\*|~~|__)\s([\.!\?'"])/, "\\1".strip + "\\2")
    end

    private

    def preserve_border_whitespaces(string, options = {}, &block)
      default_border = options.fetch(:default_border, '')
      string_start   = present_or_default(string[/\A\s*/], default_border)
      string_end     = present_or_default(string[/\s*\Z/], default_border)
      result         = yield
      string_start + result + string_end
    end

    def present_or_default(string, default)
      if string.nil? || string.empty?
        default
      else
        string
      end
    end

  end
end
