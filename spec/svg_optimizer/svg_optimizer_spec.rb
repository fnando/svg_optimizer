require "spec_helper"

describe SvgOptimizer do
  describe ".optimize" do
    let(:svg) do
      RSpecHelpers::SVG % <<-SVG
        <!-- foo -->
        <circle r="" cx="" />
        <g />
        <!-- bar -->
      SVG
    end

    it "should include all plugins by default" do
      contents = SvgOptimizer.optimize(svg)
      xml = Nokogiri::XML(contents)

      expect(xml.xpath("//comment()")).to be_empty
      expect(xml.xpath("//*[@*='']")).to be_empty
      expect(xml.root.css("g")).to be_empty
    end

    it "should exclude a single plugin" do
      contents = SvgOptimizer.optimize(svg, without: :remove_comment)
      xml = Nokogiri::XML(contents)

      expect(xml.xpath("//comment()")).not_to be_empty
      expect(xml.xpath("//*[@*='']")).to be_empty
      expect(xml.root.css("g")).to be_empty
    end

    it "should exclude multiple plugins" do
      contents = SvgOptimizer.optimize(svg, without: [:remove_comment, :remove_empty_attribute] )
      xml = Nokogiri::XML(contents)

      expect(xml.xpath("//comment()")).not_to be_empty
      expect(xml.xpath("//*[@*='']")).not_to be_empty
      expect(xml.root.css("g")).to be_empty
    end

    it "should include a single plugins" do
      contents = SvgOptimizer.optimize(svg, with: :remove_comment)
      xml = Nokogiri::XML(contents)

      expect(xml.xpath("//comment()")).to be_empty
      expect(xml.xpath("//*[@*='']")).not_to be_empty
      expect(xml.root.css("g")).not_to be_empty
    end

    it "should include multiple plugins" do
      contents = SvgOptimizer.optimize(svg, with: [:remove_comment, :remove_empty_attribute])
      xml = Nokogiri::XML(contents)

      expect(xml.xpath("//comment()")).to be_empty
      expect(xml.xpath("//*[@*='']")).to be_empty
      expect(xml.root.css("g")).not_to be_empty
    end
  end
end

