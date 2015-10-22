# encoding: UTF-8
require 'spec_helper'

describe 'Antimony Example Spec' do
  it 'should drive the green screen with formula' do
    formula = Antimony::Formula.new('example_formula', my_input: 'sample input value')
    formula.run
    expect(formula.outputs[:success]).to be(true)
  end
end
