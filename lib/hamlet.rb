require "haml"
require "erb"
require "nokogiri"
require "hamlet/engine"
require "hamlet/style_builder"
require "hamlet/helpers"
require "hamlet/template"
require "hamlet/widget/base"
require "hamlet/widget/container"
require "hamlet/widget/columns"
require "hamlet/widget/image"
require "hamlet/widget/heading"
require "hamlet/widget/button"
require "hamlet/widget/paragraph"
require "hamlet/widget/banner"
require "hamlet/widget/youtube"
require "hamlet/widget/yahoo_screen"
require "hamlet/widget/horizontal_rule"

module Hamlet
  @@_templates = {}
  
  def self.render(haml, variables={})
    Hamlet::Engine.new(haml).render(Object.new, variables)
  end
  
  def self.register_template(key, template)
    @@_templates[key] = template
  end
  
  def self.template(key)
    @@_templates[key]
  end
  
end
