# frozen_string_literal: true

require "spec_helper"

describe SvgOptimizer::Plugins::RemoveEditorNamespace do
  describe "root namespaces" do
    with_svg_plugin ""
    it { expect(xml.namespaces.values).not_to include("http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd") }
    it { expect(xml.namespaces.values).to include("http://www.w3.org/2000/svg") }
    it { expect(xml.namespaces.values).to include("http://www.w3.org/1999/xlink") }
  end

  describe "attribute namespaces" do
    with_svg_plugin "namespaced_attribute.svg"
    it { expect(xml.css("#Page-1").first.has_attribute?("sketch:type")).to be_falsy }
    it { expect(xml.css("#Page-1").first.has_attribute?("type")).to be_falsy }
    it { expect(xml.css("#Rectangle-1").first.has_attribute?("sketch:type")).to be_falsy }
    it { expect(xml.css("#Rectangle-1").first.has_attribute?("type")).to be_falsy }
  end
end
