# frozen_string_literal: true

require "test_helper"

class SvgOptimizerTest
  class FileSavingTest < Minitest::Test
    let(:input) { "/tmp/#{SecureRandom.uuid}.svg" }
    let(:output) { "/tmp/#{SecureRandom.uuid}.svg" }
    let(:raw_svg) { build_svg("<!-- foo --><text>SVG</text>") }
    let(:output_svg) { SvgOptimizer.optimize(raw_svg) }

    setup do
      File.open(input, "w") {|file| file << raw_svg }
    end

    test "overrides existing file with optimized version" do
      SvgOptimizer.optimize_file(input)
      assert_equal File.read(input), output_svg
    end

    test "saves new file file with optimized version" do
      SvgOptimizer.optimize_file(input, output)

      assert_equal raw_svg, File.read(input)
      assert_equal output_svg, File.read(output)
    end
  end

  class PluginSelectionTest < Minitest::Test
    test "applies all plugins" do
      svg = build_svg <<-SVG
        <!-- foo -->
        <g></g>
        <!-- bar -->
      SVG

      xml = Nokogiri::XML(SvgOptimizer.optimize(svg))

      assert_empty xml.xpath("//comment()")
      assert_empty xml.css("g")
    end

    test "applies just specified plugins" do
      plugins = [SvgOptimizer::Plugins::RemoveComment]
      svg = build_svg <<-SVG
        <!-- foo -->
        <g></g>
        <!-- bar -->
      SVG

      xml = Nokogiri::XML(SvgOptimizer.optimize(svg, plugins))

      assert_empty xml.xpath("//comment()")
      assert_equal 1, xml.css("g").size
    end
  end
end
