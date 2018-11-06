# frozen_string_literal: true

begin
  require 'css_parser'

  module SvgOptimizer
    module Plugins
      class InlineStyles < Base
        def process
          xml.css("style").each do |style_node|
            css_parser.load_string! style_node.text
            style_node.remove
          end
          xml.xpath("//*[@class]").each(&method(:inline_style))
        end

        def inline_style(node)
          style = node.classes.inject([]) do |result, class_name|
            css_selector = ".#{class_name}"
            result << css_parser.find_by_selector(css_selector).join(';')
          end.compact.join(';')
          node.set_attribute('style', style)
          node.remove_attribute('class')
        end

        private

        def css_parser
          @css_parser ||= CssParser::Parser.new
        end
      end
    end
  end
rescue LoadError
  warn "To use InlineStyles plugin of SvgOptimizer, please add `gem 'css_parser'` to your Gemfile"
end
