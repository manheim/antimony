# encoding: UTF-8
require 'spec_helper'

describe Antimony do

  describe '#configure' do
    it 'should set configuration options' do
      Antimony.configure do |config|
        config.path = '/foo/bar'
        config.show_output = true
      end
      expect(Antimony.path).to eql('/foo/bar')
      expect(Antimony.show_output).to be true
    end
  end
end