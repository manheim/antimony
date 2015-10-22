module Antimony
  class Session
    def initialize(host)
      @cursor_position = 0
      @screen_text = blank_screen
      @session_log = []

      @connection = Net::Telnet.new('Host' => host, 'Timeout' => 10)

      update_screen
    end

    def close
      @connection.close
    end

    def send_keys(keys, count = 1, text = true)
      count.times { @connection.print keys }
      update_screen
      add_text(keys) if text
      log_screen
      print_screen if Antimony.configuration.show_output
    end

    def value_at(row, column, length)
      start_index = ((row - 1) * 80) + (column - 1)
      end_index = start_index + length - 1
      @screen_text[start_index..end_index].join
    end

    def screen_text
      @screen_text.join
    end

    def printable_screen_text
      @screen_text.join.scan(LINE)
    end

    def print_screen
      puts SCREEN_SEPARATOR
      puts printable_screen_text
      puts SCREEN_SEPARATOR
    end

    def session_log
      txt = EMPTY.clone
      @session_log.each_with_index do |entry, i|
        txt += LOG_SEPARATOR + ENTER
        txt += "#{i}: #{ENTER}"
        txt += entry + ENTER
      end
      txt += LOG_SEPARATOR
      txt
    end

    def log(text)
      @session_log.push(text)
    end

    def log_screen
      log(printable_screen_text.join("\n"))
    end

    private

    def update_screen
      @screen_data = receive_data
      @screen_text = blank_screen if @screen_data.include?('[2J')
      parse_ansi
    end

    def add_text(text)
      text.chars.each do |char|
        @screen_text[@cursor_position] = char
        @cursor_position += 1
      end
    end

    def receive_data
      whole = []
      whole.push(@chunk) while chunk
      whole.join
    end

    def chunk
      @chunk = @connection.waitfor RECEIVE_OPTS
    rescue # rubocop:disable Lint/HandleExceptions
    end

    def cursor_position(esc)
      esc_code = /\e\[/
      pos = esc.gsub(esc_code, EMPTY).gsub(H, EMPTY).split(SEMICOLON)
      row_index = pos[0].to_i - 1
      col_index = pos[1].to_i - 1
      (row_index * 80) + col_index
    end

    def parse_ansi
      ansi = @screen_data.scan(ANSI_REGEX).map do |e|
        {
          value: e[0],
          type: e[0].include?(ESCAPE) ? :esc : :chr
        }
      end

      ansi.each do |e|
        if (e[:type] == :esc) && (e[:value].end_with? H)
          @cursor_position = cursor_position(e[:value])
        elsif e[:type] == :chr
          @screen_text[@cursor_position] = e[:value]
          @cursor_position += 1
        end
      end
      @screen_text
    end

    def blank_screen
      (1..1920).to_a.map { |_i| SPACE }
    end
  end
end
