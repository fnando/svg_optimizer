require "spec_helper"

describe SvgOptimizer::Plugins::CleanupId do
  with_svg_plugin "cleanup_id.svg"

  it { expect(xml.css("linearGradient").first["id"]).to eql("a") }
  it { expect(xml.css("circle").first["fill"]).to eql("url(#a)") }
  it { expect(xml.css("circle[id]")).to be_empty }
  it { expect(xml.css("g[id]")).to be_empty }
  it { expect(xml.css("tref[xlink|href='#b']").size).to eql(2) }
  it { expect(xml.css("text").first["id"]).to eql("b") }
end
