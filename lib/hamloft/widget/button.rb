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
          size: "btn-lg",
          media: false
        }
      end
      
      def button_classes
        classes = ["btn", "btn-#{@options[:style]}", @options[:size], @options[:type], "_typeloft_editable"]
        classes.push("btn-media") if @options[:media]
        classes.join(" ")
      end
      
      def button_options
        result = {class: button_classes, href: (@options[:href] or "#"), style: style_string(@options, :margin, :padding)}
        result["data-media"] = @options[:media] if @options[:media] and !@options[:media].empty?
        result
      end
    
    end
  end
end