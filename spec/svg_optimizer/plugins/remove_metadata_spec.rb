require "spec_helper"

describe SvgOptimizer::Plugins::RemoveMetadata do
  with_svg_plugin <<-SVG
    <metadata></metadata>
    <!-- foo -->
    <metadata></metadata>
  SVG

  it { expect(xml.css("metadata")).to be_empty }
end
