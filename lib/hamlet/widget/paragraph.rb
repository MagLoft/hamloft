module Hamlet
  module Widget
    class Paragraph < Base

      def identifier
        "paragraph"
      end

      def defaults
        {
          style: "default",
          align: "left",
          size: "md",
          margin_bottom: ""
        }
      end
    
    end
  end
end