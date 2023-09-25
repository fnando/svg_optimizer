# frozen_string_literal: true

require "test_helper"

module RemoveEmptyContainerTest
  class InnerElementsTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveEmptyContainer
    with_svg_plugin "<g><marker><a/></marker></g>"

    test "applies plugin" do
      assert_empty xml.root.css("*")
    end
  end
end
