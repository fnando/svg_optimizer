# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class CleanupAttribute < Base
      def process
        xml.xpath("//*[@*]").each do |node|
          node.attributes.each do |_, attribute|
            cleanup_attribute attribute
          end
        end
      end

      def cleanup_attribute(attribute)
        attribute.value = attribute.value.strip.squeeze(" ")
      end
    end
  end
end
