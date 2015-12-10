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

  def with_svg_plugin(content)
    let(:file_path) { File.expand_path("../fixtures/#{content}", __FILE__) }
    let(:input_xml) { Nokogiri::XML(File.file?(file_path) ? File.read(file_path) : SVG % content) }
    let(:plugin) { described_class.new(input_xml) }
    let(:xml) { plugin.xml }
    before { plugin.process }
  end
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"
  config.extend RSpecHelpers
end
