# frozen_string_literal: true

require "test_helper"

module RemoveEditorNamespaceTest
  class RootNamespacesTest < Minitest::Test
    with_svg_plugin "namespaced_attribute.svg"
    plugin_class SvgOptimizer::Plugins::RemoveEditorNamespace

    test "applies plugin" do
      refute xml.namespaces.values.include?("http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd")
      assert xml.namespaces.values.include?("http://www.w3.org/2000/svg")
      assert xml.namespaces.values.include?("http://www.w3.org/1999/xlink")
    end
  end

  class AttributeNamespacesTest < Minitest::Test
    with_svg_plugin "namespaced_attribute.svg"
    plugin_class SvgOptimizer::Plugins::RemoveEditorNamespace

    test "applies plugin" do
      refute xml.css("#Page-1").first.has_attribute?("sketch:type")
      refute xml.css("#Page-1").first.has_attribute?("type")
      refute xml.css("#Rectangle-1").first.has_attribute?("sketch:type")
      refute xml.css("#Rectangle-1").first.has_attribute?("type")
    end
  end
end
