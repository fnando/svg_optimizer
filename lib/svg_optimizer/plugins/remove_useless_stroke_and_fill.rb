# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveUselessStrokeAndFill < Base
      SELECTOR = %w[circle ellipse line path polygon polyline rect].join(",")
      STROKE_ATTRS = %w[stroke stroke-opacity stroke-width stroke-dashoffset]
      FILL_ATTRS = %w[fill-opacity fill-rule]

      def process
        return if xml.css("style, script").any?

        xml.css(SELECTOR).each do |node|
          remove_useless_attributes(node)
        end
      end

      private

      def remove_useless_attributes(node)
        return if inherited_attribute(node, "id")
        remove_stroke(node) if remove_stroke?(node)
        remove_fill(node) if remove_fill?(node)
      end

      def remove_stroke(node)
        STROKE_ATTRS.each { |attr| node.delete(attr) }
        node["stroke"] = "none" if decline_inherited_stroke?(node)
      end

      def remove_fill(node)
        FILL_ATTRS.each { |attr| node.delete(attr) }
        node["fill"] = "none" if decline_inherited_fill?(node)
      end

      def decline_inherited_stroke?(node)
        (inherited_attribute(node.parent, "stroke") || "none") != "none"
      end

      def decline_inherited_fill?(node)
        !inherited_attribute(node, "fill") || node.has_attribute?("fill")
      end

      def remove_stroke?(node)
        return true if (inherited_attribute(node, "stroke") || "none") == "none"
        return true if inherited_attribute(node, "stroke-opacity") == "0"
        return inherited_attribute(node, "stroke-width") == "0"
      end

      def remove_fill?(node)
        fill = inherited_attribute(node, "fill")
        return true if fill == "none"
        return true if inherited_attribute(node, "fill-opacity") == "0"
        return !fill
      end

      def inherited_attribute(node, attr)
        return if node.nil? || node.document?
        return node[attr] if node.has_attribute?(attr)
        inherited_attribute(node.parent, attr)
      end
    end
  end
end
