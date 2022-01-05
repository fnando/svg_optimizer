# frozen_string_literal: true

require "test_helper"

module RemoveEditorNamespaceTest
  class RootNamespacesTest < Minitest::Test
    with_svg_plugin "namespaced_attribute.svg"
    plugin_class SvgOptimizer::Plugins::RemoveEditorNamespace

    test "applies plugin" do
      assert_includes xml.namespaces.values, "http://www.w3.org/2000/svg"
      assert_includes xml.namespaces.values, "http://www.w3.org/1999/xlink"
    end
  end

  class AttributeNamespacesTest < Minitest::Test
    with_svg_plugin "namespaced_attribute.svg"
    plugin_class SvgOptimizer::Plugins::RemoveEditorNamespace

    test "applies plugin" do
      refute xml.namespaces.key?("xmlns:sketch")
      refute xml.namespaces.key?("xmlns:sodipodi")
      refute xml.css("#Page-1").first.has_attribute?("sketch:type")
      refute xml.css("#Page-1").first.has_attribute?("type")
      refute xml.css("#Rectangle-1").first.has_attribute?("sketch:type")
      refute xml.css("#Rectangle-1").first.has_attribute?("sodipodi:type")
      refute xml.css("#Rectangle-1").first.has_attribute?("type")
    end
  end
end
