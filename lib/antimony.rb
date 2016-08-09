require 'active_support/all'
require 'net/telnet'
require 'yaml'
require_relative 'antimony/keys'
require_relative 'antimony/session'
require_relative 'antimony/parser'

module Antimony
  class << self

    attr_accessor :path, :show_output

    ##
    # Set the path & options.
    #
    # Antimony.configure do |config|
    #   config.path = <path to your antimony directory>
    #   config.show_output = true
    # end
    #
    def configure
      yield self if block_given?
    end

  end
end
