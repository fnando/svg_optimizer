module SvgOptimizer
  module Plugins
    class RemoveEmptyTextNode < Base
      def process
        # xml.xpath("//text()").each(&method(:remove_if_empty))
        # require "pry"; binding.pry
      end

      private
      def remove_if_empty(node)
        node.children.remove if node.parent.elements.empty?
      end
    end
  end
end
