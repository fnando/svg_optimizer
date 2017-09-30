# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveUnusedNamespace < Base
      def process
        xml.root.namespace_definitions
          .select(&:prefix)
          .each(&method(:remove_unused_ns))
      end

      def remove_unused_ns(ns)
        return if xml.xpath("//#{ns.prefix}:*").any?
        source = xml.root.to_s.gsub(/ *xmlns:#{ns.prefix}=".*?"/, "")
        xml.root = Nokogiri::XML(source).root
      end
    end
  end
end
