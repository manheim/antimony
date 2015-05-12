# encoding 'ASCII-8bit'
lib_path = File.expand_path('../antimony', __FILE__)
($LOAD_PATH.unshift lib_path) unless $LOAD_PATH.include? lib_path

require 'bundler'
Bundler.require(:default)

# Misc
require 'net/telnet'
require 'logging'

# Gem
require "#{lib_path}/config.rb"
require "#{lib_path}/formula.rb"
require "#{lib_path}/session.rb"

module Antimony
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Antimony::Config.new.tap { |config| config.show_output = false }
  end

  def self.configure
    yield configuration if block_given?
  end

  # Constants
  ANSI_REGEX = /(\e\[.{1,2};?.{0,2}m|\e\[.{1}J|\e\[.{1,2}A|\e\[.{1,2}B|\e\[.{1,2}C|\e\[.{1,2}D|\e\[K|\e\[.{1,2};.{1,2}H|\e\[.{3}|.)/.freeze # rubocop:disable Metrics/LineLength
  SCREEN_SEPARATOR = '################################################################################'.freeze
  LOG_SEPARATOR    = '================================================================================'.freeze

  SPACE = ' '.freeze
  EMPTY = ''.freeze
  RECEIVE_OPTS = { 'Match' => /.{20}/, 'Timeout' => 1 }.freeze

  ENTER = "\n".freeze
  TAB = "\t".freeze
  ESCAPE = "\e".freeze

  H = 'H'.freeze

  SEMICOLON = ';'.freeze

  LINE = /.{80}/.freeze

  class Session
    KEYBOARD_METHODS = {
      f1: "\x1B\x31".freeze,
      f2: "\x1B\x32".freeze,
      f3: "\x1B\x33".freeze,
      f4: "\x1B\x34".freeze,
      f5: "\x1B\x35".freeze,
      f6: "\x1B\x36".freeze,
      f7: "\x1B\x37".freeze,
      f8: "\x1B\x38".freeze,
      f9: "\x1B\x39".freeze,
      f10: "\x1B\x30".freeze,
      f11: "\x1B\x2D".freeze,
      f12: "\x1B\x3D".freeze,
      f13: "\x1B\x21".freeze,
      f14: "\x1B\x40".freeze,
      f15: "\x1B\x23".freeze,
      f16: "\x1B\x24".freeze,
      f17: "\x1B\x25".freeze,
      f18: "\x1B\x5E".freeze,
      f19: "\x1B\x26".freeze,
      f20: "\x1B\x2A".freeze,
      f21: "\x1B\x28".freeze,
      f22: "\x1B\x29".freeze,
      f23: "\x1B\x5F".freeze,
      f24: "\x1B\x2B".freeze,
      enter: "\n".freeze,
      tab: "\t".freeze,
      backspace: "\177".freeze,
      arrow_up: "\e[A".freeze,
      arrow_down: "\e[B".freeze,
      arrow_right: "\e[C".freeze,
      arrow_left: "\e[D".freeze
    }

    KEYBOARD_METHODS.each do |key, val|
      define_method(key) { |count = 1| send_keys val, count, false }
    end
  end
end
