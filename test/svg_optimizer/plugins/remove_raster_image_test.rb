# frozen_string_literal: true

require "test_helper"

class RemoveRasterImageTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::RemoveRasterImage
  with_svg_plugin <<-SVG
    <g>
      <image xlink:href="raster.jpg" width="100" height="100"/>
      <image xlink:href="raster.png" width="100" height="100"/>
      <image xlink:href="raster.gif" width="100" height="100"/>
      <image xlink:href="raster.svg" width="100" height="100"/>
    </g>
  SVG

  test "applies plugin" do
    assert_equal 1, xml.css("image").size
  end
end
