# frozen_string_literal: true

require "test_helper"

class Issue8Test < Minitest::Test
  test "processes string when marked as trusted" do
    raw_svg = File.read("./test/fixtures/issue_8.svg")

    SvgOptimizer.optimize(raw_svg, trusted: true)
  end

  test "processes file when marked as trusted" do
    Dir.mktmpdir do |dir|
      FileUtils.cp("./test/fixtures/issue_8.svg", dir)

      SvgOptimizer.optimize_file(File.join(dir, "issue_8.svg"), trusted: true)
    end
  end

  test "does not process string by default" do
    raw_svg = File.read("./test/fixtures/issue_8.svg")

    assert_raises(Nokogiri::XML::SyntaxError) do
      SvgOptimizer.optimize(raw_svg)
    end
  end

  test "does not process file by default" do
    Dir.mktmpdir do |dir|
      FileUtils.cp("./test/fixtures/issue_8.svg", dir)

      assert_raises(Nokogiri::XML::SyntaxError) do
        SvgOptimizer.optimize_file(File.join(dir, "issue_8.svg"))
      end
    end
  end
end
