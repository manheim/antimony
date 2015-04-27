require 'rspec/core/rake_task'

namespace :spec do

  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = Dir['spec/**/*_spec.rb'].reject{ |f| f['example_spec.rb'] }
  end

  task :all => [:unit, :integration]
end

task :pry do
  main_path = File.expand_path('../lib/antimony.rb', __FILE__)
  system "bundle exec pry -r #{main_path}"
end
