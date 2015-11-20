module Hamloft
  module Helpers

    def style_string(options, *args, &block)
      Hamloft::StyleBuilder.new(options, args).process(block)
    end

    # styles
    def asset(url)
      "#{Hamloft::Options.defaults[:asset_uri]}/themes/#{@_haml_locals[:theme]}/#{url}"
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
    # <a href="http://www.google.com/?referrer=Baker" class="">

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

    def column(row, &block)
      # get and increase span
      next_span = row.next_span
      if next_span
        phone_cols = (row.options[:collapse_options] == "xs") ? next_span : "12"
        haml_tag :div, :class => "column col-#{phone_cols} col-tablet-#{next_span} col-#{row.options[:collapse_options]}-#{next_span}" do
          block.call if block
          drop_container
        end
      else
        haml_tag :pre do
          haml_concat "ERROR: Row does not allow column at position #{row.column_count}"
        end
      end
    end

    def columns_widget(options={}, &block)
      widget_block(Widget::Columns.new(options)) do |widget|
        haml_tag :div, widget.row_options do
          block.call(widget) if block
        end
      end
    end
    
    def columns_widget_compose(key, options={}, &block)
      columns_widget = Widget::Columns.new(options)
      items = variable(key, [])
      # calculate row and column count
      row_count = (items.length.to_f / columns_widget.total_columns).ceil
      col_count = columns_widget.total_columns
      (0...row_count).each do |row_index|
        columns_widget(options) do |row|
          (0...col_count).each do |col_index|
            index = (row_index * col_count) + col_index
            block.call(row, items[index]) if not items[index].nil?
          end
        end
      end
    end

    def container_widget(options={}, &block)
      widget_block(Widget::Container.new(options)) do |widget|
        haml_tag :section, widget.container_options do
          haml_tag :div, widget.image_options do
            block.call if block
            drop_container
          end
        end
      end
    end
  
    def banner_widget(options={}, &block)
      widget_block(Widget::Banner.new(options)) do |widget|
        haml_tag :div, :class => "banner-outer align-#{widget.options[:alignment]}" do
          haml_tag :div, :class => "banner banner-#{widget.options[:style]}" do
            block.call if block
            drop_container
          end
        end
      end
    end
  
    def youtube_widget(options={}, &block)
      widget_block(Widget::Youtube.new(options)) do |widget|
        haml_tag :div, class: "flex-video widescreen", style: style_string(widget.options, :margin, :padding) do
          haml_tag :iframe, src: "http://www.youtube.com/embed/#{widget.options[:youtube_id]}", type: "text/html", style: "max-width: 100%; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%;", allowfullscreen: "", frameborder: "0", webkitallowfullscreen: "", mozallowfullscreen: ""
        end
      end
    end
  
    def yahoo_screen_widget(options={}, &block)
      widget_block(Widget::YahooScreen.new(options)) do |widget|
        haml_tag :div, class: "flex-video widescreen", style: style_string(widget.options, :margin, :padding) do
          haml_tag :iframe, src: "http://screen.yahoo.com/#{widget.options[:yahoo_screen_id]}.html?format=embed", type: "text/html", style: "max-width: 100%; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%;", allowfullscreen: "", frameborder: "0", webkitallowfullscreen: "", mozallowfullscreen: ""
        end
      end
    end
  
    def image_widget_link(options={})
      widget_block(Widget::Image.new(options)) do |widget|
        haml_tag :div, :class => "image-widget align-#{widget.options[:align]}" do
          link options[:href] do
            haml_tag :img, style: style_string(widget.options, :margin, :padding), class: "image #{widget.options[:style]} #{widget.options[:magnify] ? "magnific-image" : ""}", src: widget.options[:source]
          end
          haml_tag :div, :class => "image-drop-target"
        end
      end
    end

    def horizontal_rule_widget(options={})
      widget_block(Widget::HorizontalRule.new(options)) do |widget|
        haml_tag :hr, style: "max-height: #{widget.options[:max_height]}", class: "#{widget.options[:style]} #{widget.options[:color]}"
      end
    end

    def image_widget(options={})
      widget_block(Widget::Image.new(options)) do |widget|
        haml_tag :div, :class => "image-widget align-#{widget.options[:align]}", style: style_string(widget.options, :margin, :padding) do
          haml_tag :img, class: "image #{widget.options[:style]} #{widget.options[:magnify] ? "magnific-image" : ""}", src: widget.options[:source]
          haml_tag :div, class: "image-drop-target"
        end
      end
    end
  
    def heading_widget(options={}, contents=nil, &block)
      if options.class.name == "String"
        contents = options
        options = {}
      end
      widget_block(Widget::Heading.new(options)) do |widget|
        haml_tag :header, :class => "#{widget.options[:style]} align-#{widget.options[:align]}", style: style_string(widget.options, :margin, :padding) do
          haml_tag widget.options[:type], :class => "_typeloft_editable _typeloft_widget_autoselect" do
            haml_concat(contents) if contents
            block.call if block
          end
        end
      end
    end
  
    def paragraph_widget(options={}, contents=nil, &block)
      if options.class.name == "String"
        contents = options
        options = {}
      end
      widget_block(Widget::Paragraph.new(options)) do |widget|
        haml_tag :div, :style => style = style_string(widget.options, :margin, :padding), :class => "paragraph _typeloft_editable _typeloft_widget_autoselect #{widget.options[:style]} align-#{widget.options[:align]} size-#{widget.options[:size]}" do
          haml_concat(contents) if contents
          block.call if block
        end
      end
    end
  
    def button_widget(options={}, contents=nil, &block)
      if options.class.name == "String"
        contents = options
        options = {}
      end
      widget_block(Widget::Button.new(options)) do |widget|
        haml_tag :a, class: "btn btn-#{widget.options[:style]} #{widget.options[:type]} #{widget.options[:size]} _typeloft_editable", href: (widget.options[:href] or "#"), style: style_string(widget.options, :margin, :padding) do
          haml_concat(contents) if contents
          block.call if block
        end
      end
    end
  
  end
end
