module Antimony
  class Formula
    LOG_PARENT_PATH = Dir.pwd + '/log'
    LOG_PATH = "#{LOG_PARENT_PATH}/formulas"
    FORMULAS_PATH = Dir.pwd + '/formulas'

    attr_accessor :inputs, :outputs, :formula_log

    def initialize(name, inputs = {})
      ($LOAD_PATH.unshift FORMULAS_PATH) unless $LOAD_PATH.include? FORMULAS_PATH

      @inputs = indifferent_hash(inputs)
      @outputs = {}

      init_log(name)

      helper_path = "#{FORMULAS_PATH}/formula_helper.rb"

      eval File.read(helper_path) if File.exist?(helper_path)

      @formula = File.read("#{FORMULAS_PATH}/#{name}.rb")
    end

    def run
      eval(@formula)
    end

    def session(host)
      @connection = Antimony::Session.new(host)
      yield if block_given?
      @log.info @connection.session_log
      @connection.close
      @connection = nil
    end

    private

    def init_log(name)
      Dir.mkdir LOG_PARENT_PATH unless Dir.exist? LOG_PARENT_PATH
      Dir.mkdir LOG_PATH unless Dir.exist? LOG_PATH
      @log = Logging.logger[name]
      layout = Logging.layouts.pattern(pattern: "%m\n")
      @log.add_appenders(Logging.appenders.file("#{LOG_PATH}/#{name}.log",           truncate: true,
                                                                                     layout: layout))
    end

    def method_missing(name, *args, &block)
      fail 'No active connection!' unless @connection
      @connection.send(name, *args, &block)
    end

    def indifferent_hash(hash)
      {}.tap do |new_hash|
        hash.each do |key, value|
          value = indifferent_hash(value) if value.is_a?(Hash)
          new_hash[key.to_sym] = value
          new_hash[key.to_s] = value
        end
      end
    end
  end
end
