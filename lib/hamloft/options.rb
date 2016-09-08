module Hamloft
  class Options
    @defaults = {
      asset_uri: "http://localhost:3000"
    }

    def self.defaults
      @defaults
    end

    attr_accessor :asset_uri

    def initialize(values = {}, &block)
      defaults.each {|k, v| instance_variable_set :"@#{k}", v}
      values.reject {|k, v| !defaults.has_key?(k) || v.nil?}.each {|k, v| send("#{k}=", v)}
      yield if block_given?
    end

    def [](key)
      send key
    end

    def []=(key, value)
      send "#{key}=", value
    end

    private

    def defaults
      self.class.defaults
    end
  end
end
