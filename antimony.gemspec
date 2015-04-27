  Gem::Specification.new do |s|
    s.name        = 'antimony'
    s.version     = '0.0.9'
    s.summary     = "TN5250/AS400 automation"
    s.description = "DSL for writing scripts to drive TN5250 green-screen applications"
    s.authors     = ["Andrew Terris", "Adrienne Hisbrook", "Lesley Dennison"]
    s.email       = ''
    s.homepage    = 'http://github.ove.local/Auction2/antimony'
    s.files       = ["lib/antimony.rb", "lib/antimony/formula.rb", "lib/antimony/session.rb", "lib/antimony/config.rb"]
    s.bindir      = 'bin'
    s.executables << 'sb'

    s.add_runtime_dependency 'logging'
    s.add_runtime_dependency 'thor'
  end
