require "spec_helper"

describe SvgOptimizer do
  context "plugin selection" do
    it "applies all plugins" do
      svg = build_svg <<-SVG
        <!-- foo -->
        <g></g>
        <!-- bar -->
      SVG

      xml = Nokogiri::XML(SvgOptimizer.optimize(svg))

      expect(xml.xpath("//comment()")).to be_empty
      expect(xml.css("g")).to be_empty
    end

    it "applies just specified plugins" do
      plugins = [SvgOptimizer::Plugins::RemoveComment]
      svg = build_svg <<-SVG
        <!-- foo -->
        <g></g>
        <!-- bar -->
      SVG

      xml = Nokogiri::XML(SvgOptimizer.optimize(svg, plugins))

      expect(xml.xpath("//comment()")).to be_empty
      expect(xml.css("g").length).to eql(1)
    end
  end
end
