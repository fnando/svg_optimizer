# frozen_string_literal: true

require "test_helper"

module RemoveEmptyTextNodeTests
  class GroupsWithEmptyTextNodesOnlyTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveEmptyTextNode
    with_svg_plugin %[<g>    \n\t\r\n  </g>]

    test "applies plugin" do
      assert_empty xml.css("g").children
    end
  end

  class GroupsWithNonEmptyTextNodesTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveEmptyTextNode
    with_svg_plugin %[<g> Hello   \n\t\r\n  </g>]

    test "applies plugin" do
      refute_empty xml.css("g").children
    end
  end
end
