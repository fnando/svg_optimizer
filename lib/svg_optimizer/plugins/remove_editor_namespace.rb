# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveEditorNamespace < Base
      NAMESPACES = [
        "http://ns.adobe.com/AdobeIllustrator/10.0/",
        "http://ns.adobe.com/AdobeSVGViewerExtensions/3.0/",
        "http://ns.adobe.com/Extensibility/1.0/",
        "http://ns.adobe.com/Flows/1.0/",
        "http://ns.adobe.com/GenericCustomNamespace/1.0/",
        "http://ns.adobe.com/Graphs/1.0/",
        "http://ns.adobe.com/ImageReplacement/1.0/",
        "http://ns.adobe.com/SaveForWeb/1.0/",
        "http://ns.adobe.com/Variables/1.0/",
        "http://ns.adobe.com/XPath/1.0",
        "http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd",
        "http://www.bohemiancoding.com/sketch/ns",
        "http://www.inkscape.org/namespaces/inkscape"
      ].freeze

      def process
        xml.namespaces.each do |full_name, href|
          _, name = full_name.split(":")
          next unless NAMESPACES.include?(href)

          remove_namespaced_attributes(name, href)
        end

        xml.root.namespace_definitions.each do |namespace|
          remove_namespace(namespace) if NAMESPACES.include?(namespace.href)
        end
      end

      def remove_namespaced_attributes(name, href)
        xml.xpath("//@*[namespace-uri()='#{href}']").each do |node|
          remove_matching_attribute(node, name)
        end

        xml.xpath("//*[@#{name}:*]").each do |node|
          remove_matching_attribute(node, name)
        end
      end

      def remove_namespace(namespace)
        source = xml.root.to_s.gsub(/ *xmlns:#{namespace.prefix}=".*?"/, "")
        xml.root = Nokogiri::XML(source).root
      end

      def remove_matching_attribute(node, name)
        node.attributes.each_value do |attr|
          next unless attr.namespace

          attr.remove if attr.namespace.prefix == name
        end
      end
    end
  end
end
