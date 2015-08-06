module Hamloft
  module Widget
    class Columns < Base
      attr_reader :columns
      attr_reader :column_count
      attr_reader :total_columns

      def initialize(options)
        super(options)
        @column_count = 0
        column_array = @options[:columns].to_s.split("x")
        if column_array.length == 1
          @total_columns = column_array[0].to_i
          @columns = Array.new(@total_columns) { 12 / @total_columns }
        else
          @total_columns = column_array.length
          @columns = column_array
        end
      end
      
      def next_span
        value = @columns[@column_count]
        @column_count = @column_count + 1
        value
      end
      
      def row_options
        {
          class: "row row-#{@options[:style]}",
          style: style_string(@options, :margin_bottom)
        }
      end
      
      def identifier
        "columns"
      end

      def defaults
        {
          columns: "2",
          style: "default",
          margin_bottom: "",
          collapse_options: "sm"
        }
      end
      
    end
  end
end