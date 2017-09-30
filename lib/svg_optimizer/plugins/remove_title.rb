# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveTitle < Base
      def process
        xml.xpath("//title").remove
      end
    end
  end
end
