module Hamloft
  module Widget
    class Button < Base

      def identifier
        "button"
      end

      def defaults
        {
          style: "primary",
          type: "btn-fit",
          size: "btn-lg"
        }
      end
    
    end
  end
end