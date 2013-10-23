module SvgOptimizer
  module Plugins
    class RemoveEmptyTextNode < Base
      def process
        xml.xpath("//text()")
          .each(&method(:remove_if_empty))
      end

      private
      def remove_if_empty(node)
        node.remove if node.text.squeeze.empty?
      end
    end
  end
end
