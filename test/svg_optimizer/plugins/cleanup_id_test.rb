# frozen_string_literal: true

require "test_helper"

module CleanupIdTest
  class CleanupIdWithXLinkNamespaceTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::CleanupId
    with_svg_plugin "cleanup_id.svg"

    test "applies plugin" do
      assert_equal "a", xml.css("linearGradient").first["id"]
      assert_equal "url(#a)", xml.css("circle").first["fill"]
      assert_empty xml.css("circle[id]")
      assert_empty xml.css("g[id]")
      assert_equal 2, xml.css("tref[xlink|href='#b']").size
      assert_equal "b", xml.css("text").first["id"]
    end
  end

  class CleanupIdWithoutXLinkNamespaceTest < Minitest::Test
    plugin_class SvgOptimizer::Plugins::CleanupId
    with_svg_plugin "cleanup_id_without_xlink.svg"

    test "applies plugin" do
      svg = File.read("./test/fixtures/cleanup_id_without_xlink_expected.svg")
      assert_equal svg.to_s.chomp, xml.root.to_s
    end
  end
end
