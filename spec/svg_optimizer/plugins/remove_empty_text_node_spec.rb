# frozen_string_literal: true

require "spec_helper"

describe SvgOptimizer::Plugins::RemoveEmptyTextNode do
  context "groups with empty text nodes only" do
    with_svg_plugin %[<g>    \n\t\r\n  </g>]
    it { expect(xml.css("g").children).to be_empty }
  end

  context "groups with non-empty nodes" do
    with_svg_plugin %[<g> Hello   \n\t\r\n  </g>]
    it { expect(xml.css("g").children).not_to be_empty }
  end
end
