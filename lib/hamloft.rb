require 'haml'
require 'erb'
require 'nokogiri'
require 'hamloft/engine'
require 'hamloft/style_builder'
require 'hamloft/helpers'
require 'hamloft/template'
require 'hamloft/widget'

module Hamloft
  @@_templates = {}
  @@_widgets = []
  @@_block_resolver = nil
  @@_asset_uri = nil

  def self.block_resolver=(resolver)
    @@_block_resolver = resolver
  end

  def self.block_resolver
    @@_block_resolver
  end

  def self.asset_uri=(asset_uri)
    @@_asset_uri = asset_uri
  end

  def self.asset_uri
    @@_asset_uri || '.'
  end

  def self.render(haml, variables = {})
    Hamloft::Engine.new(haml, remove_whitespace: true).render(Object.new, variables)
  end

  def self.register_template(key, template)
    @@_templates[key] = template
  end

  def self.register_widget(klass)
    @@_widgets.push(klass)
  end

  def self.widgets
    @@_widgets
  end

  def self.template(key)
    @@_templates[key]
  end
end
