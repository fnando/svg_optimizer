# frozen_string_literal: true

require "test_helper"

class RemoveEmptyAttributeTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::RemoveEmptyAttribute
  with_svg_plugin <<-SVG
    <g attr1="" attr2=""/>
    <g attr3="" attr4=""/>
    <g namespace:attr="" />
  SVG

  test "applies plugin" do
    assert xml.xpath("//*[@*='']").empty?
  end
end
