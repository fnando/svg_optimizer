# frozen_string_literal: true

require "spec_helper"

describe SvgOptimizer::Plugins::RemoveTitle do
  with_svg_plugin "title_and_desc.svg"

  it { expect(xml.css("title")).to be_empty }
end
