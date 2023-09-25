# frozen_string_literal: true

require "test_helper"

module RemoveHiddenElementTest
  class DisplayNoneTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <path display="none" d="..."/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("path")
    end
  end

  class OpacityZeroTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <path opacity="0" d="..."/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("path")
    end
  end

  class CircleTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <circle r="0"/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("circle")
    end
  end

  class EllipseTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <ellipse rx="0"/>
      <ellipse ry="0"/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("ellipse")
    end
  end

  class RectTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <rect width="0"/>
      <rect height="0"/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("rect")
    end
  end

  class PatternTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <pattern width="0"/>
      <pattern height="0"/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("pattern")
    end
  end

  class ImageTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <image width="0"/>
      <image height="0"/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("image")
    end
  end

  class PathTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::RemoveHiddenElement
    with_svg_plugin <<-SVG
      <path d=''/>
    SVG

    test "applies plugin" do
      assert_empty xml.css("path")
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
      assert_empty xml.root.css("*")
    end
  end
end
