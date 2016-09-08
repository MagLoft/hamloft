module Hamloft
  module Helpers

    def style_string(options, *args, &block)
      Hamloft::StyleBuilder.new(options, args).process(block)
    end
    
    def block(identifier, variables={})
      haml_contents = Hamloft.block_resolver.resolve(identifier, @_haml_locals)
      Hamloft.render(haml_contents, theme: @_haml_locals[:theme], base_path: @_haml_locals[:base_path], variables: variables)
    end

    # styles
    def asset(url)
      "#{asset_uri}/themes/#{@_haml_locals[:theme]}/#{url}"
    end
    
    def root_asset(url)
      "#{asset_uri}/#{url}"
    end
    
    def asset_uri
      @_haml_locals[:asset_uri] || Hamloft.asset_uri
    end
    
    def var(key, default=nil)
      variable(:variables, {})[key.to_sym] || default
    end
  
    def variable(key, default=false)
      @_haml_locals[key.to_sym] || default
    end
  
    def parse_html(key, type)
      if html = @_haml_locals[key.to_sym] and not Hamloft.template(type).nil?
        template = Hamloft.template(type).new(self, html)
        template.container do
          template.chunks.each do |chunk|
            template.process_chunk(chunk)
          end
        end
      end
    end

    def link(href, referrer="Baker", &block)
      if referrer and not referrer.empty? and not href.include?("referrer=")
        href = "#{href}#{href.include?("?") ? "&" : "?"}referrer=#{referrer}"
      end
      haml_tag :a, :href => href do
        block.call if block
      end
    end

    def font(font_face, &block)
      haml_tag :font, :face => font_face do
        block.call if block
      end
    end

    def style(*args, &block)
      style = nil
      if args[-1].class.name == "Hash"
        style_options = args.pop
        style = style_string(style_options, *style_options.keys)
      end
    
      classes = args.map{|a| "__#{a}"}
      haml_tag :span, :class => classes.join(" "), :style => style do
        block.call if block
      end    
    end

    # drop container

    def drop_container
      haml_tag :div, :class => "_typeloft_widget_drop_container"
    end
  
    # widgets

    def widget_block(widget, &block)
      haml_tag :div, widget.typeloft_widget_options do
        block.call(widget) if block
      end
    end
  end
end
