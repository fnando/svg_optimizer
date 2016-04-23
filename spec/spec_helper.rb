# frozen_string_literal: true
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "bundler/setup"
require "svg_optimizer"

module RSpecHelpers
  SVG = <<-XML
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<?xml version="1.0" encoding="utf-8"?>
<svg xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  %s
</svg>
  XML

  def fixtures_path
    File.expand_path("../fixtures", __FILE__)
  end

  def setup_plugin_test
    let(:input_xml) { Nokogiri::XML(input_content, &:noblanks) }
    let(:plugin) { described_class.new(input_xml) }
    let(:xml) { plugin.xml }
    before { plugin.process }
  end

  def with_svg_plugin(content)
    let(:file_path) { File.join(fixtures_path, content) }
    let(:input_content) { File.file?(file_path) ? File.read(file_path) : SVG % content }
    setup_plugin_test
  end

  def test_with_fixture_set(name)
    Dir.glob(File.join(fixtures_path, name, '*.svg')).each do |fixture|
      context "output from fixture: #{fixture}" do
        let(:fixture_content) { File.read(fixture) }
        let(:input_content) { fixture_content.split('@@@')[0].strip }
        let(:expected_content) { fixture_content.split('@@@')[1].strip }
        let(:expected) { Nokogiri::XML(expected_content, &:noblanks).root.to_xml }
        subject { xml.root.to_xml }
        setup_plugin_test

        it { is_expected.to eq(expected) }
      end
    end
  end

end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = "random"
  config.extend RSpecHelpers
  config.include RSpecHelpers
end
