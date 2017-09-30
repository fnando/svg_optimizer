# frozen_string_literal: true

require "test_helper"

class RemoveDescriptionTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::RemoveDescription
  with_svg_plugin "title_and_desc.svg"

  test "applies plugin" do
    assert xml.css("desc").empty?
  end
end
