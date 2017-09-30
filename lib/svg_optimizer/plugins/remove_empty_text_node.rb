# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveEmptyTextNode < Base
      def process
        xml.xpath("//text()").each(&method(:remove_if_empty))
      end

      private

      def remove_if_empty(node)
        node.remove if node.text.gsub(/\s/, "").empty?
      end
    end
  end
end
