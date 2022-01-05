# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class CleanupId < Base
      LETTERS = %w[
        a b c d e f g h i j k l m n o p q r s t u v w x y z
        A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
      ].freeze

      IDS = LETTERS.dup.concat(LETTERS.combination(2).to_a).freeze
      XLINK_NAMESPACE = "http://www.w3.org/1999/xlink"

      def ids
        @ids ||= IDS.dup
      end

      def process
        # If there's a <script> or <style>, don't mess with ids.
        return if xml.css("script, style").any?

        # SVG can have ids as arrays.
        # Skip id optimization if that's the case.
        return if xml.css("[id^='[']").size.nonzero?

        # Replace the ids otherwise.
        xml.css("[id]").each(&method(:cleanup_id))
      end

      def cleanup_id(node)
        # Keep ids if there's no available id.
        # This means that 1300+ ids have been used so far. CRAZY!
        return if ids.empty?

        old_id = node[:id]
        new_id = ids.shift
        node[:id] = new_id

        remove_unused_id(
          node,
          replace_url_references(old_id, new_id),
          replace_href_references(old_id, new_id)
        )
      end

      def remove_unused_id(node, has_url_refs, has_href_refs)
        return if has_url_refs
        return if has_href_refs

        node.remove_attribute("id")
      end

      def replace_url_references(old_id, new_id)
        nodes = xml.xpath(%{//*[@*="url(##{old_id})"]})

        nodes.each do |node|
          node.attributes.map(&:last).each do |attr|
            attr.value = %[url(##{new_id})] if attr.value == %[url(##{old_id})]
          end
        end

        nodes.any?
      end

      def xlink_namespace?
        xml.root.namespace_definitions.map(&:href).include?(XLINK_NAMESPACE)
      end

      def replace_href_references(old_id, new_id)
        scopes = ["[href='##{old_id}']"]
        scopes << "[xlink|href='##{old_id}']" if xlink_namespace?

        nodes = xml.css(scopes.join(","))

        nodes.each do |node|
          node.attributes.map(&:last).each do |attr|
            attr.value = "##{new_id}" if attr.value == "##{old_id}"
          end
        end

        nodes.any?
      end
    end
  end
end
