module Hamlet
  module Widget
    class HorizontalRule < Base

      def identifier
        "horizontal_rule"
      end

      def defaults
        {
          style: 'solid',
          color: 'dark',
          max_height: 'inherit'
        }
      end
    
    end
  end
end