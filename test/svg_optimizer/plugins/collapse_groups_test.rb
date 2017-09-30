# frozen_string_literal: true

require "test_helper"

class CollapseGroupsTest < Minitest::Test
  test_with_fixture_set("collapse_groups", SvgOptimizer::Plugins::CollapseGroups)
end
