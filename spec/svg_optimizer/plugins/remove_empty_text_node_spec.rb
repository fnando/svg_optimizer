require "spec_helper"

describe SvgOptimizer::Plugins::RemoveEmptyTextNode do
  with_svg_plugin %[<g>    \n\t\r\n  </g>]
  xit { expect(xml.css("g").children).to be_empty }
end
