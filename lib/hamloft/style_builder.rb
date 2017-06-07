module Hamloft
  class StyleBuilder
    attr_accessor :options
    attr_accessor :styles

    def initialize(options, styles = [])
      @options = {}
      @styles = {}

      # expand margins
      if styles.include?(:margin)
        styles |= %i[margin_top margin_right margin_bottom margin_left]
        styles.reject! { |_style| styles === :margin }
      end

      # expand paddings
      if styles.include?(:padding)
        styles |= %i[padding_top padding_right padding_bottom padding_left]
        styles.reject! { |_style| styles === :padding }
      end

      # build sanitized options
      options.each do |k, v|
        @options[sanitize_style(k)] = v
      end

      # add initial styles
      add_multi(styles)
    end

    def process(block = nil)
      block.call(self) if block
      result = @styles.map { |k, v| "#{k}: #{v};" }.join(' ')
      result.empty? ? nil : result
    end

    def add_multi(styles)
      styles.each do |style|
        add(style)
      end
    end

    def add(style, value = nil, template = nil)
      style = sanitize_style(style)

      # handle empty value field
      if (!value || value.empty?) && !(!(@options[style]) || @options[style].empty?)
        value = @options[style]
      end

      # apply template
      if value && !value.empty? && template && !template.empty?
        value = ERB.new(template).result(binding)
      end

      @styles[style] = value if value && !value.empty?
    end

    def sanitize_style(value)
      value.to_s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1-\2')
           .gsub(/([a-z\d])([A-Z])/, '\1-\2')
           .tr('_', '-').downcase
    end
  end
end
