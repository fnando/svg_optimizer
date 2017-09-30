# frozen_string_literal: true

require "test_helper"

class CleanupIdTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::CleanupId
  with_svg_plugin "cleanup_id.svg"

  test "applies plugin" do
    assert_equal "a", xml.css("linearGradient").first["id"]
    assert_equal "url(#a)", xml.css("circle").first["fill"]
    assert xml.css("circle[id]").empty?
    assert xml.css("g[id]").empty?
    assert_equal 2, xml.css("tref[xlink|href='#b']").size
    assert_equal "b", xml.css("text").first["id"]
  end
end
