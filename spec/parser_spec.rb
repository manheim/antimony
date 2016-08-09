# encoding: UTF-8
require 'spec_helper'
require 'pry'

STREAM1 = File.read File.expand_path("#{RESOURCES_DIR}/sample_stream_1.txt", __FILE__)
EXPECT1 = File.read File.expand_path("#{RESOURCES_DIR}/sample_expect_1.txt", __FILE__)
SCREEN_SEPARATOR ='################################################################################'

describe Antimony::Parser, :parser do

  before(:each) { @parser = Antimony::Parser.new }

  it 'should initialize an empty screen buffer' do
    expect(@parser.screen_buffer.uniq.count).to eql(1)
  end

  it 'should parse ansi into text' do
    expect(@parser.parse_ansi(STREAM1).first.join).to include(EXPECT1)
  end

  it 'should return a snippet of screen text' do
    @parser.parse_ansi(STREAM1)
    expect(@parser.value_at(1, 36, 7)).to eql('Sign On')
  end

  describe '#screen_buffer_empty?' do
    it 'should return true when the screen buffer is empty' do
      expect(@parser.screen_buffer_empty?).to be true
    end

    it 'should return false when the screen buffer is not empty' do
      @parser.parse_ansi(STREAM1)
      expect(@parser.screen_buffer_empty?).to be false
    end
  end

  describe '#output' do
    it 'should return nil if Antimony.show_output is false' do
      Antimony.show_output = false
      @parser.parse_ansi(STREAM1)
      expect(@parser.output).to be nil
    end

    it 'should return nil if Antimony.show_output is uninitialized' do
      Antimony.show_output = nil
      @parser.parse_ansi(STREAM1)
      expect(@parser.output).to be nil
    end

    it 'should return nil if the screen buffer is empty' do
      Antimony.show_output = true
      @parser.parse_ansi('')
      expect(@parser.output).to be nil
    end

    it 'should print out the screen buffer if Anitmony.show_output is true' do
      Antimony.show_output = true
      @parser.parse_ansi(STREAM1)
      expect(STDOUT).to receive(:puts).exactly(26).times
      @parser.output
    end
  end

end