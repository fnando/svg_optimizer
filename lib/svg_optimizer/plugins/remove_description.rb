# frozen_string_literal: true

module SvgOptimizer
  module Plugins
    class RemoveDescription < Base
      def process
        xml.css("desc").remove
      end
    end
  end
end
