module Hamloft
  module Widget
    class Banner < Base

      def identifier
        "banner"
      end

      def defaults
        {
          style: "dark",
          alignment: "center"
        }
      end
    
    end
  end
end
