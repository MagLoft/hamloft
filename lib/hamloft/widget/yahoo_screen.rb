module Hamloft
  module Widget
    class YahooScreen < Base

      def identifier
        "yahoo_screen"
      end

      def defaults
        {
          yahoo_screen_id: "apple-iwatch-iphone-6-135616256",
          width: "800",
          height: "600"
        }
      end
    
    end
  end
end
