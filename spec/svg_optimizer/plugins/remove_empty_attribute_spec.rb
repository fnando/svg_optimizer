# frozen_string_literal: true
require "spec_helper"

describe SvgOptimizer::Plugins::RemoveEmptyAttribute do
  with_svg_plugin <<-SVG
    <g attr1="" attr2=""/>
    <g attr3="" attr4=""/>
    <g namespace:attr="" />
  SVG

  it { expect(xml.xpath("//*[@*='']")).to be_empty }
end
