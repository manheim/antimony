module Antimony
  class Parser

    attr_accessor :screen_buffer, :row, :column

    ANSI_REGEX = /(\e\[.{1,2};?.{0,2}m|\e\[.{1}J|\e\[.{1,2}A|\e\[.{1,2}B|\e\[.{1,2}C|\e\[.{1,2}D|\e\[K|\e\[.{1,2};.{1,2}H|\e\[.{3}|.)/
    ESCAPE = "\e"
    ESC_CODE = /\e\[/
    SCREEN_SEPARATOR = '################################################################################'.freeze

    def initialize
      @screen_buffer = []
      @row = 0
      @column = 0
      map_blank_screen
    end

    def parse_ansi(data)
      return if data.eql?('')
      map_blank_screen
      data.split(ANSI_REGEX).each do |value|
        next if value.eql?('')
        if value.start_with?(ESCAPE)
          if value.end_with?('H')
            position = value.gsub(ESC_CODE, '').gsub('H', '')
            move_cursor_to(position.split(';'))
          end
        else
          begin
            print(value)
          rescue => e
            puts e.message
          end
        end
      end
      @screen_buffer
    end

    def value_at(row, column, length)
      adj_row = row - 1
      adj_column = column - 1
      adj_length = adj_column + (length - 1)
      @screen_buffer[adj_row][adj_column..adj_length].join
    end

    def screen_buffer_empty?
      @screen_buffer.uniq.count.eql?(1) ? true : false
    end

    def output
      if Antimony.show_output
        return if screen_buffer_empty?
        puts SCREEN_SEPARATOR
        @screen_buffer.each { |row| puts row.join }
        puts SCREEN_SEPARATOR
      end
    end

    private

    def map_blank_screen
      @screen_buffer = []
      24.times { @screen_buffer << (1..80).to_a.map { |_i| ' ' } }
      @row = 0
      @column = 0
    end

    def move_cursor_to(coordinates)
      @row = coordinates[0].to_i - 1
      @column = coordinates[1].to_i - 1
    end

    def print(text)
      return if text.start_with?(ESCAPE)
      text.chars.each do |char|
        advance_row if @column == 80
        @screen_buffer[@row][@column] = char
        @column += 1
      end
    end

    def advance_row
      @row += 1
      @column = 0
    end

  end
end