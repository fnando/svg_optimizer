module SvgOptimizer
  module Plugins
    class CleanupAttribute < Base
      def process
        xml.xpath("//*[@*]").each do |node|
          node.attributes.each do |name, value|
            cleanup_attribute node, name
          end
        end
      end

      def cleanup_attribute(node, attr)
        node[attr] = node[attr].strip.squeeze(" ")
      end
    end
  end
end
