require "spec_helper"

describe SvgOptimizer::Plugins::RemoveEmptyAttribute do
  with_svg_plugin <<-SVG
    <g attr1="" attr2=""/>
    <g attr3="" attr4=""/>
  SVG

  it { expect(xml.xpath("//*[@*='']")).to be_empty }
end
