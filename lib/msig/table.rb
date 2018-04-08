require "matrix"

module Msig
  class Table
    def initialize(column_separator="|")
      @rows = []
      @column_separator = column_separator
    end

    def add_row(row)
      @rows << row
    end

    def to_lines
      max_row_size = @rows.map(&:size).max

      _rows = []

      #expand each row as necessary
      @rows.each do |row|
        _row = row + Array.new((max_row_size - row.size), "")
        _rows << _row
      end

      tmatrix = Matrix[*_rows]
      new_columns = []
      tmatrix.column_count.times do |i|
        column = tmatrix.column(i)
        max_column_size = column.map(&:size).max

        _new_column = []
        column.to_a.each do |column_value|
          _new_column << pad(column_value, max_column_size)
        end

        new_columns << _new_column
      end

      t2matrix = Matrix[*new_columns].transpose

      t2matrix.to_a.map do |row|
        row.join(@column_separator)
      end
    end

    private
    def pad(string, size)
      string.ljust(size, " ")
    end
  end
end
