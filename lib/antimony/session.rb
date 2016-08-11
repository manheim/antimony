# encoding: UTF-8
module Antimony
  class Session
    include Antimony::Keys

    attr_accessor :config, :connection, :responses, :parser

    RECEIVE_OPTS = { 'Match' => /.{20}/, 'Timeout' => 1 }.freeze
    TAB = "\t"
    HOME = "\x0F"
    REDRAW_SCREEN = "\x1B\x4C"

    def initialize(host)
      @responses = []
      @config = load_config(host)
      @parser = Antimony::Parser.new
      establish_connection
    end

    def send_key(key, count = 1)
      count.times { @connection.print(key) }
      unless [TAB, HOME, REDRAW_SCREEN].include?(key)
        output_screen
      end
    end
    alias_method :send_keys, :send_key

    def redraw_screen
      send_key(REDRAW_SCREEN)
      receive_data
      @parser.parse_ansi(@responses.last)
    end

    def output_screen
      if Antimony.show_output
        redraw_screen
        @parser.output
      end
    end

    def screen_text
      text = ''
      redraw_screen
      @parser.screen_buffer.each { |row|  text << row.join }
      text
    end

    def value_at(row, column, length)
      redraw_screen
      @parser.value_at(row, column, length)
    end

    def close
      @connection.close if @connection
    end

    private

    def load_config(host)
      if host.is_a?(Hash)
        return host.with_indifferent_access
      elsif File.exist?("#{Antimony.path}/config/hosts.yml")
        host_data = YAML.load_file("#{Antimony.path}/config/hosts.yml")[host.to_s]
        host_data = host_data.with_indifferent_access unless host_data.nil?
        return host_data
      end
      ActiveSupport::HashWithIndifferentAccess.new
    end

    def establish_connection
      @connection = Net::Telnet.new('Host' => @config[:url], 'Timeout' => @config[:timeout].to_i)
      output_screen
    end

    def receive_data
      whole = []
      whole.push(@chunk) while chunk
      @responses << whole.join
    end

    def chunk
      @chunk = @connection.waitfor(RECEIVE_OPTS)
      rescue # rubocop:disable Lint/HandleExceptions
    end
  end
end
