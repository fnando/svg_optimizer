require "spec_helper"

describe SvgOptimizer::Plugins::RemoveEditorNamespace do
  with_svg_plugin ""
  it { expect(xml.namespaces.values).not_to include("http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd") }
  it { expect(xml.namespaces.values).to include("http://www.w3.org/2000/svg") }
  it { expect(xml.namespaces.values).to include("http://www.w3.org/1999/xlink") }
end
