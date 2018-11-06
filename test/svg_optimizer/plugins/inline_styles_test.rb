# frozen_string_literal: true

require "test_helper"
require "svg_optimizer/plugins/inline_styles"

class InlineStylesTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::InlineStyles
  with_svg_plugin %[<svg id="test" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <style>.st0{fill:red;}</style>
  <rect width="100" height="100" class="st0" />
</svg>]

  test "inlines style" do
    assert_equal "fill: red;", xml.at("rect").attributes['style'].value
  end

  test "removes class" do
    assert_nil xml.at("rect").attributes['class']
  end

  test "removes style tag" do
    assert_nil xml.at("style")
  end
end
