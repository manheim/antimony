# encoding: UTF-8
Gem::Specification.new do |s|
  s.name        = 'antimony'
  s.version     = '2.0.0'
  s.summary     = 'TN5250/AS400 automation'
  s.description = 'DSL for writing scripts to drive TN5250 green-screen applications'
  s.authors     = ['Andrew Terris', 'Adrienne Hisbrook', 'Lesley Dennison', 'Ryan Rosenblum', 'Lance Howard']
  s.email       = ''
  s.homepage    = 'https://github.com/manheim/antimony'
  s.files       = ['lib/antimony.rb', 'lib/antimony/keys.rb', 'lib/antimony/session.rb', 'lib/antimony/parser.rb']
  s.license     = 'MIT'

  s.add_runtime_dependency('activesupport', '~>4.2')
  # s.add_runtime_dependency('logging', '~> 1.2')
  # s.add_runtime_dependency('thor', '~> 0')
  s.add_development_dependency('rake', '~> 10.3')
  s.add_development_dependency('rspec', '~> 3.0')
  s.add_development_dependency('pry', '~> 0.10.1')
  s.add_development_dependency('rubocop', '~> 0.37.0')
end
