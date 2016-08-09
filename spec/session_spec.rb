# encoding: UTF-8
require 'spec_helper'
require 'pry'

STREAM1 = File.read File.expand_path("#{RESOURCES_DIR}/sample_stream_1.txt", __FILE__)

describe Antimony::Session, :session do
  before do
    Antimony.show_output = false

    @telnet = double(Net::Telnet)

    allow(@telnet).to receive(:print)

    allow(Net::Telnet).to receive(:new).and_return(@telnet)

    @session = Antimony::Session.new(url: 'as400.foo.com', timeout: 10)
  end

  describe '::new' do
    it 'should create Telnet session' do
      expect(Net::Telnet).to receive(:new)
        .with('Host' => 'as400.foo.com', 'Timeout' => 10)
        .and_return(@telnet)
      Antimony::Session.new(url: 'as400.foo.com', timeout: 10)
    end
  end

  describe '#close' do
    it 'should close terminal session' do
      expect(@telnet).to receive(:close)
      @session.close
    end
  end

  describe '#send_key' do
    it 'should send keys to terminal' do
      expect(@telnet).to receive(:print).with('boom!')
      @session.send_key('boom!')
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

end
