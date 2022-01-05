# frozen_string_literal: true

require "test_helper"

class Issue8Test < Minitest::Test
  test "processes file" do
    raw_svg = File.read("./test/fixtures/issue_8.svg")
    SvgOptimizer.optimize(raw_svg)
  end
end
