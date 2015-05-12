antimony
========

Antimony is a DSL allowing developers to write automated workflows for TN5250 mainframe applications.

## Formulas

Formulas describe automated processes and are loaded from the `formulas` directory.

Simply provide the filename and any inputs to `Antimony::Formula.new` and call `run`

## Usage

#### Prepare Formula
```ruby
@formula = Antimony::Formula.new('process_unit', { value: 'sample' })
```

#### Run Formula
```ruby
@formula.run
```

#### Access inputs and outputs
```ruby
@formula.inputs # {}
@formula.outputs # {}
```
## Inputs

Formulas expose `@inputs` which contains the hash provided during initialization. This hash can be accessed outside of a formula via the `inputs` method on the formula object.

## Outputs

Formulas expose `@outputs` which is a hash that can be used to save outputs from the execution of a formula. This hash can be accessed outside of a formula via the `outputs` method on the formula object.

## Logging

Running a formula will automatically log the screens that it traversed and the final screen after completion to `log/formulas/formula_name.log` These logs will contain only the most recent execution.

## Commands

#### Send string to terminal
```ruby
send_keys(string, [count])      # send string to terminal 'count' times
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
print_screen                    # print current screen
printable_screen_text           # get pretty-print version of screen text
```

#### Logging
```ruby
session_log                     # get the log of the session
log(message)                    # log a message to the session log
log_screen                      # log the current screen to the session log
```

## Examples
### Example formula (login.rb) for a login workflow
```ruby
session 'hostname.com' do
  send_keys 'USERNAME'
  send_keys 'PASSWORD'
  enter
  @outputs[:success] = screen_text.include? 'SUCCESSFUL LOGIN'
end
```
### Example of modularizing use of formulas (note: login.rb formula is pulled into this one - lookup.rb)
```ruby
require 'login'
session 'hostname.com' do
  login #login formula is invoked/run
  send_keys 'MENU1'
  enter
  send_keys '02'
  enter
  send_keys inputs[:work_order_number]
  enter
  f5
  outputs[:success] = screen_text.include?(inputs[:status])
end
```
### Example RSpec test calling the formula
```ruby
context 'Given I am an Admin And I have a Completed work order' do
  it 'When I lookup the work order Then the completed status is displayed'
      lookup_formula = Antimony::Formula.new('lookup', {work_order_number: '12345', status: 'COMPLETED'})
      lookup_formula.run
      expect(lookup_formula.outputs[:success]).to be_true
  end
end
```