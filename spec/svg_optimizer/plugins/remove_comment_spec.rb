require "spec_helper"

describe SvgOptimizer::Plugins::RemoveComment do
  with_svg_plugin <<-SVG
    <!-- foo -->
    <g></g>
    <!-- bar -->
  SVG

  it { expect(xml.xpath("//comment()")).to be_empty }
end
