# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveEditorNamespace < Base
      NAMESPACES = %w[
        http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd
        http://www.inkscape.org/namespaces/inkscape
        http://ns.adobe.com/AdobeIllustrator/10.0/
        http://ns.adobe.com/Graphs/1.0/
        http://ns.adobe.com/AdobeSVGViewerExtensions/3.0/
        http://ns.adobe.com/Variables/1.0/
        http://ns.adobe.com/SaveForWeb/1.0/
        http://ns.adobe.com/Extensibility/1.0/
        http://ns.adobe.com/Flows/1.0/
        http://ns.adobe.com/ImageReplacement/1.0/
        http://ns.adobe.com/GenericCustomNamespace/1.0/
        http://ns.adobe.com/XPath/1.0
        http://www.bohemiancoding.com/sketch/ns
      ]

      def process
        namespaces = xml.namespaces
        remove_namespaced_attributes
        xml.remove_namespaces!

        namespaces.each do |name, value|
          next if NAMESPACES.include?(value)

          _, name = name.split(":")
          xml.root.add_namespace name, value
        end
      end

      def namespaces_to_be_removed
        xml.namespaces.map do |name, value|
          _, name = name.split(":")
          name if NAMESPACES.include?(value)
        end.compact
      end

      def remove_namespaced_attributes
        namespaces_to_be_removed.each do |ns|
          xml.xpath("//*[@#{ns}:*]").each do |node|
            node.attributes.each do |_, attr|
              next unless attr.namespace
              attr.remove if attr.namespace.prefix == ns
            end
          end
        end
      end
    end
  end
end
