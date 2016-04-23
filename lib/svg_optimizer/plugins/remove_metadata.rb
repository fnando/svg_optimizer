# frozen_string_literal: true
module SvgOptimizer
  module Plugins
    class RemoveMetadata < Base
      def process
        xml.css("metadata").remove
      end
    end
  end
end
