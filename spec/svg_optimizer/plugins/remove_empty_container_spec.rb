# frozen_string_literal: true
require "spec_helper"

describe SvgOptimizer::Plugins::RemoveEmptyContainer do
  context "inner elements" do
    with_svg_plugin "<g><marker><a/></marker></g>"
    it { expect(xml.root.css("*")).to be_empty }
  end
end
