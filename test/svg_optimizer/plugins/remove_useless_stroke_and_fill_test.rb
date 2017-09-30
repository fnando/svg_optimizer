# frozen_string_literal: true

require "test_helper"

class RemoveUselessStrokeAndFillTest < Minitest::Test
  test_with_fixture_set("remove_useless_stroke_and_fill", SvgOptimizer::Plugins::RemoveUselessStrokeAndFill)
end
