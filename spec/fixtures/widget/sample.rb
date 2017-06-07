class SampleWidget < Hamloft::Widget
  include Hamloft::Helpers
  attr_accessor :options

  def identifier
    'sample'
  end

  module Helpers
    def sample_widget(options = {}, contents = nil, &block)
      widget_block(SampleWidget.new(options)) do |_widget|
        haml_tag :div, class: 'sample' do
          haml_concat(contents) if contents
          yield if block
        end
      end
    end
  end
end
