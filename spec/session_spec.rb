# encoding: UTF-8
require 'spec_helper'
require 'pry'

STREAM1 = File.read File.expand_path("#{RESOURCES_DIR}/sample_stream_1.txt", __FILE__)

EXPECT1 = File.read File.expand_path("#{RESOURCES_DIR}/sample_expect_1.txt", __FILE__)

describe Antimony::Session, :session do
  before do
    @telnet = double(Net::Telnet)

    allow(@telnet).to receive(:print)

    allow(Net::Telnet).to receive(:new).and_return(@telnet)

    allow_any_instance_of(Antimony::Session).to receive(:receive_data).and_return(STREAM1)

    @session = Antimony::Session.new('')
  end

  describe '::new' do
    it 'should create Telnet session' do
      expect(Net::Telnet).to receive(:new)
        .with('Host' => '', 'Timeout' => 10)
        .and_return(@telnet)
      Antimony::Session.new('')
    end
  end

  describe '#close' do
    it 'should close terminal session' do
      expect(@telnet).to receive(:close)
      @session.close
    end
  end

  describe '#send_keys' do
    it 'should send keys to terminal' do
      expect(@telnet).to receive(:print).with('boom!')
      @session.send_keys 'boom!'
    end
  end

  describe '#enter' do
    it 'should send newline key to terminal' do
      expect(@telnet).to receive(:print).with("\n")
      @session.enter
    end
  end

  describe '#tab' do
    it 'should send tab key to terminal' do
      expect(@telnet).to receive(:print).with("\t")
      @session.tab
    end
  end

  describe '#value_at' do
    it 'should retrieve the value at row, column, length' do
      value = @session.value_at(6, 17, 4)
      expect(value).to eq('User')
    end
  end

  describe 'private#parse_ansi' do
    it 'should parse ansi into text' do
      expect(@session.screen_text).to eq(EXPECT1)
    end
  end
end
