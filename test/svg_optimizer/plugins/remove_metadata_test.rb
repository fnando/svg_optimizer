# frozen_string_literal: true

require "test_helper"

class RemoveMetadataTest < Minitest::Test
  plugin_class SvgOptimizer::Plugins::RemoveMetadata
  with_svg_plugin <<-SVG
    <metadata></metadata>
    <!-- foo -->
    <metadata></metadata>
  SVG

  test "applies plugin" do
    assert xml.css("metadata").empty?
  end
end
