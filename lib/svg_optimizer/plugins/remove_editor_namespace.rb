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
      ]

      def process
        namespaces = xml.namespaces
        xml.remove_namespaces!

        namespaces.each do |name, value|
          next if NAMESPACES.include?(value)

          _, name = name.split(":")
          xml.root.add_namespace name, value
        end
      end
    end
  end
end
