# frozen_string_literal: true

require "test_helper"

module RemoveHiddenElementTest
  class DisplayNoneTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <path display="none" d="..."/>
    SVG

    test "applies plugin" do
      assert xml.css("path").empty?
    end
  end

  class OpacityZeroTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <path opacity="0" d="..."/>
    SVG

    test "applies plugin" do
      assert xml.css("path").empty?
    end
  end

  class CircleTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <circle r="0"/>
    SVG

    test "applies plugin" do
      assert xml.css("circle").empty?
    end
  end

  class EllipseTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <ellipse rx="0"/>
      <ellipse ry="0"/>
    SVG

    test "applies plugin" do
      assert xml.css("ellipse").empty?
    end
  end

  class RectTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <rect width="0"/>
      <rect height="0"/>
    SVG

    test "applies plugin" do
      assert xml.css("rect").empty?
    end
  end

  class PatternTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <pattern width="0"/>
      <pattern height="0"/>
    SVG

    test "applies plugin" do
      assert xml.css("pattern").empty?
    end
  end

  class ImageTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <image width="0"/>
      <image height="0"/>
    SVG

    test "applies plugin" do
      assert xml.css("image").empty?
    end
  end

  class PathTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <path d=''/>
    SVG

    test "applies plugin" do
      assert xml.css("path").empty?
    end
  end

  class OtherHiddenElementsTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <path/>
      <polyline/>
      <polygon/>
    SVG

    test "applies plugin" do
      assert xml.root.css("*").empty?
    end
  end
end
