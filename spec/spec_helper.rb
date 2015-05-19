if ENV['COVERAGE'] == 'true'
  require 'coveralls'
  Coveralls.wear!
end

lib_path = File.expand_path('../../lib', __FILE__)
require "#{lib_path}/antimony"

RESOURCES_DIR = File.expand_path('../resources', __FILE__)

RSpec.configure do |config|
  # Spec Filtering
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.order = :random

  # Output
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
