# frozen_string_literal: true

require "spec_helper"

describe SvgOptimizer::Plugins::RemoveUnusedNamespace do
  with_svg_plugin "unused_namespace.svg"

  let(:namespaces) do
    xml.root.namespace_definitions.each_with_object({}) do |ns, buffer|
      next unless ns.prefix
      buffer[ns.prefix] = ns.href
    end
  end

  it { expect(namespaces).to include("test" => "http://example.com/") }
  it { expect(namespaces).to include("test2" => "http://example2.com/") }

  it { expect(namespaces).not_to include("test3" => "http://example3.com/") }
  it { expect(namespaces).not_to include("test4" => "http://example4.com/") }
end
