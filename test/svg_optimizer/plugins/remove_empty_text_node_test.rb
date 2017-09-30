# frozen_string_literal: true

require "test_helper"

describe SvgOptimizer::Plugins::RemoveEmptyTextNode do
  class GroupsWithEmptyTextNodesOnlyTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveEmptyTextNode
    with_svg_plugin %[<g>    \n\t\r\n  </g>]

    test "applies plugin" do
      assert xml.css("g").children.empty?
    end
  end

  class GroupsWithNonEmptyTextNodesTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveEmptyTextNode
    with_svg_plugin %[<g> Hello   \n\t\r\n  </g>]

    test "applies plugin" do
      refute xml.css("g").children.empty?
    end
  end
end
