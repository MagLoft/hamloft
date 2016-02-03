module Hamloft
  class Engine < Haml::Engine
    
    def render(scope = Object.new, locals = {}, &block)
      parent = scope.instance_variable_defined?('@haml_buffer') ? scope.instance_variable_get('@haml_buffer') : nil
      buffer = Haml::Buffer.new(parent, @options.for_buffer)

      if scope.is_a?(Binding) || scope.is_a?(Proc)
        scope_object = eval("self", scope)
        scope = scope_object.instance_eval{binding} if block_given?
      else
        scope_object = scope
        scope = scope_object.instance_eval{binding}
      end

      set_locals(locals.merge(:_hamlout => buffer, :_erbout => buffer.buffer), scope, scope_object)

      scope_object.instance_eval do
        extend Haml::Helpers
        extend Hamloft::Helpers
        
        # Inject widget helpers
        Hamloft.widgets.each do |widget|
          if defined?(widget::Helpers)
            extend widget::Helpers
          end
        end
        
        @haml_buffer = buffer
      end
      begin
        eval(@compiler.precompiled_with_return_value, scope, @options[:filename], @options[:line])
      rescue ::SyntaxError => e
        raise SyntaxError, e.message
      end
    ensure
      # Get rid of the current buffer
      scope_object.instance_eval do
        @haml_buffer = buffer.upper if buffer
      end
    end
    
  end
end
