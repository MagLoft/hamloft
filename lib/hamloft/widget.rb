module Hamloft
  class Widget
    include Hamloft::Helpers
    attr_accessor :options

    def identifier
      "base"
    end

    def defaults
      {}
    end

    def initialize(options)
      @options = defaults.merge(options)
    end
  
    def typeloft_widget_options
      attributes = {
        :class => "_typeloft_widget",
        :"data-widget-identifier" => identifier
      }
      @options.each do |k, v|
        attributes["data-attribute-#{k}"] = v
      end
      attributes
    end
  
  end
end
