# frozen_string_literal: true
require "spec_helper"

describe SvgOptimizer::Plugins::CleanupAttribute do
  with_svg_plugin %[<g a="b    \n\t\tc"/>]
  it { expect(xml.css("g").first["a"]).to eql("b c") }
end
