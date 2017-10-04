# frozen_string_literal: true

require "test_helper"

module RemoveUnusedNamespaceTest
  class UnusedNamespaceTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveUnusedNamespace
    with_svg_plugin "unused_namespace.svg"

    let(:namespaces) do
      xml.root.namespace_definitions.each_with_object({}) do |ns, buffer|
        next unless ns.prefix
        buffer[ns.prefix] = ns.href
      end
    end

    test "applies plugin" do
      assert_equal "http://example.com/", namespaces["test"]
      assert_equal "http://example2.com/", namespaces["test2"]

      refute namespaces.key?("test3")
      refute namespaces.key?("test4")
    end
  end

  class NamespaceInUseTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveUnusedNamespace
    with_svg_plugin "namespace_in_use.svg"

    let(:namespaces) do
      xml.root.namespace_definitions.each_with_object({}) do |ns, buffer|
        next unless ns.prefix
        buffer[ns.prefix] = ns.href
      end
    end

    test "applies plugin" do
      assert_equal "http://www.w3.org/1999/xlink", namespaces["xlink"]
    end
  end
end
