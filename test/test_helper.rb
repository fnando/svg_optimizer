# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "bundler/setup"
require "svg_optimizer"
require "securerandom"

require "minitest/utils"
require "minitest/autorun"

module InstanceHelpers
  SVG = <<~XML
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
      "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <?xml version="1.0" encoding="utf-8"?>
    <svg xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      %s
    </svg>
  XML
  def build_svg(content)
    SVG % content
  end

  def fixtures_path
    self.class.fixtures_path
  end
end

module ClassHelpers
  def with_svg_plugin(content)
    let(:file_path) { File.join(fixtures_path, content) }
    let(:input_content) do
      File.file?(file_path) ? File.read(file_path) : build_svg(content)
    end
    setup_plugin_test
  end

  def setup_plugin_test
    let(:input_xml) { Nokogiri::XML(input_content, &:noblanks) }
    let(:plugin) { plugin_class.new(input_xml) }
    let(:xml) { plugin.xml }
    setup { plugin.process }
  end

  def plugin_class(plugin_class)
    let(:plugin_class) { plugin_class }
  end

  def fixtures_path
    File.expand_path("fixtures", __dir__)
  end

  def test_with_fixture_set(name, plugin_class_to_be_tested)
    Dir.glob(File.join(fixtures_path, name, "*.svg")).each do |fixture|
      Class.new(Minitest::Test) do
        plugin_class plugin_class_to_be_tested
        let(:fixture_content) { File.read(fixture) }
        let(:input_content) { fixture_content.split("@@@")[0].strip }
        let(:expected_content) { fixture_content.split("@@@")[1].strip }
        let(:expected) do
          Nokogiri::XML(expected_content, &:noblanks).root.to_xml
        end
        let(:subject) { xml.root.to_xml }
        setup_plugin_test

        test "has expected output (#{fixture})" do
          assert_equal expected, subject
        end
      end
    end
  end
end

Minitest::Test.include(InstanceHelpers)
Minitest::Test.extend(ClassHelpers)
