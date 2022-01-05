# frozen_string_literal: true

require "test_helper"

class RemoveTitleTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::RemoveTitle
  with_svg_plugin "title_and_desc.svg"

  test "applies plugin" do
    assert xml.css("title").empty?
  end
end

class RemoveTitleFromSpriteTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::RemoveTitle
  with_svg_plugin "cleanup_title.svg"

  test "applies plugin" do
    assert xml.css("title").empty?
  end
end
