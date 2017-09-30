# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveEmptyContainer < Base
      ELEMENTS = %w[a defs g marker mask missing-glyph pattern switch symbol].freeze
      SELECTOR = ELEMENTS.map {|element| %[#{element}:empty] }.join(", ")

      def process
        while (nodes = xml.css(SELECTOR)).any?
          nodes.each(&method(:remove_node))
        end
      end

      private

      def remove_node(node)
        node.children.empty? && node.remove
        remove_node(node.parent) if node.parent
      end
    end
  end
end
