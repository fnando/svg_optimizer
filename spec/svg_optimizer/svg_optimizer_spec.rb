require "spec_helper"

describe SvgOptimizer do
  context "file saving" do
    let(:input) { "/tmp/#{SecureRandom.uuid}.svg" }
    let(:output) { "/tmp/#{SecureRandom.uuid}.svg" }
    let(:raw_svg) { build_svg("<!-- foo --><text>SVG</text>") }
    let(:output_svg) { SvgOptimizer.optimize(raw_svg) }

    before do
      File.open(input, "w") {|file| file << raw_svg }
    end

    it "overrides existing file with optimized version" do
      SvgOptimizer.optimize_file(input)
      expect(File.read(input)).to eq(output_svg)
    end

    it "saves new file file with optimized version" do
      SvgOptimizer.optimize_file(input, output)
      expect(File.read(input)).to eq(raw_svg)
      expect(File.read(output)).to eq(output_svg)
    end
  end

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
