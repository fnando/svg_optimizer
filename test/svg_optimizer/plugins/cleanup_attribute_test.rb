# frozen_string_literal: true

require "test_helper"

class CleanupAttributeTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::CleanupAttribute
  with_svg_plugin %[<g a="b    \n\t\tc"/>]

  test "applies plugin" do
    assert_equal "b c", xml.css("g").first["a"]
  end
end
