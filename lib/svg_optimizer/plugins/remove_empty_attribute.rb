module SvgOptimizer
  module Plugins
    class RemoveEmptyAttribute < Base
      def process
        xml.xpath("//*[@*='']").each do |node|
          node.attributes.each do |name, value|
            remove_if_empty node, name
          end
        end
      end

      private
      def remove_if_empty(node, attr)
        node.remove_attribute(attr) if node[attr].empty?
      end
    end
  end
end
