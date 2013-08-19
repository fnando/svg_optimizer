module SvgOptimizer
  module Plugins
    class RemoveRasterImage < Base
      SELECTOR = %w[
        image[xlink|href$='.jpg']
        image[xlink|href$='.jpeg']
        image[xlink|href$='.gif']
        image[xlink|href$='.png']
      ].join(", ")

      def process
        xml.css(SELECTOR).remove
      end
    end
  end
end
