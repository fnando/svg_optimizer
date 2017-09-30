# frozen_string_literal: true

require "spec_helper"

describe SvgOptimizer::Plugins::RemoveHiddenElement do
  context "display: none" do
    with_svg_plugin <<-SVG
      <path display="none" d="..."/>
    SVG

    it { expect(xml.css("path")).to be_empty }
  end

  context "opacity: 0" do
    with_svg_plugin <<-SVG
      <path opacity="0" d="..."/>
    SVG

    it { expect(xml.css("path")).to be_empty }
  end

  context "circle" do
    with_svg_plugin <<-SVG
      <circle r="0"/>
    SVG

    it { expect(xml.css("circle")).to be_empty }
  end

  context "ellipse" do
    with_svg_plugin <<-SVG
      <ellipse rx="0"/>
      <ellipse ry="0"/>
    SVG

    it { expect(xml.css("ellipse")).to be_empty }
  end

  context "rect" do
    with_svg_plugin <<-SVG
      <rect width="0"/>
      <rect height="0"/>
    SVG

    it { expect(xml.css("rect")).to be_empty }
  end

  context "pattern" do
    with_svg_plugin <<-SVG
      <pattern width="0"/>
      <pattern height="0"/>
    SVG

    it { expect(xml.css("pattern")).to be_empty }
  end

  context "image" do
    with_svg_plugin <<-SVG
      <image width="0"/>
      <image height="0"/>
    SVG

    it { expect(xml.css("image")).to be_empty }
  end

  context "<path d=''/>" do
    with_svg_plugin <<-SVG
      <path d=''/>
    SVG

    it { expect(xml.css("path")).to be_empty }
  end

  context "other hidden elements" do
    with_svg_plugin <<-SVG
      <path/>
      <polyline/>
      <polygon/>
    SVG

    it { expect(xml.root.css("*")).to be_empty }
  end
end
