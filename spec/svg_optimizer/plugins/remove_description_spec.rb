# frozen_string_literal: true

require "spec_helper"

describe SvgOptimizer::Plugins::RemoveDescription do
  with_svg_plugin "title_and_desc.svg"

  it { expect(xml.css("desc")).to be_empty }
end
