module SvgOptimizer
  module Plugins
    class RemoveHiddenElement < Base
      SELECTOR = %w[
        [display=none]
        [opacity='0']
        circle[r='0']
        ellipse[rx='0']
        ellipse[ry='0']
        rect[width='0']
        rect[height='0']
        pattern[width='0']
        pattern[height='0']
        image[width='0']
        image[height='0']
        path[d='']
        path:not([d])
        polyline[points='']
        polyline:not([points])
        polygon[points='']
        polygon:not([points])
      ].join(", ")

      def process
        xml.css(SELECTOR).remove
      end
    end
  end
end
