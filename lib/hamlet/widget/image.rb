module Hamlet
  module Widget
    class Image < Base

      def identifier
        "image"
      end

      def defaults
        {
          style: "img-responsive",
          align: "center",
          source: false,
          magnify: false,
          margin_bottom: "0"
        }
      end
    
    end
  end
end