require "haml"
require "erb"
require "nokogiri"
require "hamloft/engine"
require "hamloft/options"
require "hamloft/style_builder"
require "hamloft/helpers"
require "hamloft/template"
require "hamloft/widget/base"
require "hamloft/widget/container"
require "hamloft/widget/columns"
require "hamloft/widget/image"
require "hamloft/widget/heading"
require "hamloft/widget/button"
require "hamloft/widget/paragraph"
require "hamloft/widget/banner"
require "hamloft/widget/youtube"
require "hamloft/widget/yahoo_screen"
require "hamloft/widget/horizontal_rule"

module Hamloft
  @@_templates = {}
  
  def self.render(haml, variables={})
    Hamloft::Engine.new(haml, remove_whitespace: true).render(Object.new, variables)
  end
  
  def self.register_template(key, template)
    @@_templates[key] = template
  end
  
  def self.template(key)
    @@_templates[key]
  end
  
end
