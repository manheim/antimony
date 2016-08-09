antimony
========

[![Gem Version](http://img.shields.io/gem/v/antimony.svg)](https://rubygems.org/gems/antimony)
[![Build Status](http://img.shields.io/travis/manheim/antimony.svg)](https://travis-ci.org/manheim/antimony)
[![Code Climate](https://codeclimate.com/github/manheim/antimony/badges/gpa.svg)](https://codeclimate.com/github/manheim/antimony)
[![Coverage Status](https://coveralls.io/repos/manheim/antimony/badge.svg?branch=master)](https://coveralls.io/r/manheim/antimony?branch=master)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)


Antimony is a DSL allowing developers to write automated workflows for TN5250 mainframe applications.

## Installation

Add this line to your Gemfile:
```ruby
gem 'antimony'
```
Then install the gem manually:
```ruby 
gem install antimony
```
or via Bundler:
```ruby
bundle install
```

## Configuration
Set options:
```ruby
Antimony.configure do |config|
  config.path = 'path/to/your/host/configuration' # path to the dir containing your hosts.yml file (see below) 
  config.show_output = true # screen will print to terminal (otherwise no automatic output)
end
```

You can (optionally) define a YAML file of host data:

(This file must be named hosts.yml)
```yaml
---
host_1:
    :url: 'host.foo.com'
    username: 'username'
    password: 'password'
host_2:
    :url: 'host.bar.com'
    username: 'username'
    password: 'password'
```

## Usage
Initialize a session and send commands
```ruby
# Initialize the session
@session = Antimony::Session.new(url: 'your_host_name', timeout: 10)
# or, using hosts.yml config file
@session = Antimony::Session.new(:host_1)

# Send some commands
@session.send_keys('your_username')
@session.tab
@session.send_keys('your_password')
@session.enter

# And finally close the session
@session.close
```

## Commands

#### Send string to terminal
```ruby
send_key(string, [count])      # send string to terminal 'count' times
# aliased to send_keys
```

#### Keyboard methods
```ruby
enter([count])                  # send enter key 'count' times
tab([count])                    # send tab key 'count' times
backspace([count])              # send backspace key 'count' times
arrow_up([count])               # send arrow up key 'count' times
arrow_down([count])             # send arrow down key 'count' times
arrow_right([count])            # send arrow right key 'count' times
arrow_left([count])             # send arrow left key 'count' times
f{1-24}([count])                # send function key 'count' times
```

#### Current screen data
```ruby
value_at(row, column, length)   # get the string value at a given row and column
screen_text                     # get current screen as a string
output_screen                   # print current screen
```

## Authors
* Andrew Terris https://github.com/aterris
* Adrienne Hisbrook https://github.com/ahisbrook
* Lesley Dennison <ldennison@thoughtworks.com>
* Ryan Rosenblum https://github.com/rrosenblum
* Lance Howard https://github.com/lkhoward
