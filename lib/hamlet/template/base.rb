module Hamlet
  module Template
    class Base
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
      
      def process_chunk(chunk)
        nil
      end
      
    end
  end
end
