module Hamlet
  class Options

    @defaults = {
      :asset_uri            => "http://localhost:3000"
    }

    # The default option values.
    # @return Hash
    def self.defaults
      @defaults
    end

    attr_accessor :asset_uri

    def initialize(values = {}, &block)
      defaults.each {|k, v| instance_variable_set :"@#{k}", v}
      values.reject {|k, v| !defaults.has_key?(k) || v.nil?}.each {|k, v| send("#{k}=", v)}
      yield if block_given?
    end

    # Retrieve an option value.
    # @param key The value to retrieve.
    def [](key)
      send key
    end

    # Set an option value.
    # @param key The key to set.
    # @param value The value to set for the key.
    def []=(key, value)
      send "#{key}=", value
    end

    private

    def defaults
      self.class.defaults
    end

  end
end
