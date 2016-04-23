# frozen_string_literal: true
require "spec_helper"

describe SvgOptimizer::Plugins::RemoveRasterImage do
  with_svg_plugin <<-SVG
    <g>
      <image xlink:href="raster.jpg" width="100" height="100"/>
      <image xlink:href="raster.png" width="100" height="100"/>
      <image xlink:href="raster.gif" width="100" height="100"/>
      <image xlink:href="raster.svg" width="100" height="100"/>
    </g>
  SVG

  it { expect(xml.css("image").size).to eql(1) }
end
