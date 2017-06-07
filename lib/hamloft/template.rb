module Hamloft
  class Template
    attr_accessor :haml, :html, :doc

    def initialize(haml, html)
      self.haml = haml
      self.html = html
      self.doc = Nokogiri::HTML.fragment(self.html)
    end

    def chunks
      []
    end

    def container(&block)
      yield(block)
    end

    def process_chunk(_chunk)
      nil
    end
  end
end
