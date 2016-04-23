# frozen_string_literal: true
module SvgOptimizer
  module Plugins
    class Base
      attr_reader :xml

      def initialize(xml)
        @xml = xml
      end
    end
  end
end
