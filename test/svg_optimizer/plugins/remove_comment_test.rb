# frozen_string_literal: true

require "test_helper"

class RemoveCommentTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::RemoveComment

  with_svg_plugin <<-SVG
    <!-- foo -->
    <g></g>
    <!-- bar -->
  SVG

  test "applies plugin" do
    assert xml.xpath("//comment()").empty?
  end
end
