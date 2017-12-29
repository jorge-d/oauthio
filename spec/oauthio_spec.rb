require 'spec_helper'

RSpec.describe Oauthio do
  it "has a version number" do
    expect(Oauthio::VERSION).not_to be nil
  end

  it '.set_credentials' do
    Oauthio.set_credentials('xxx', 'bbb')

    expect(Oauthio.public_key).to eq 'xxx'
    expect(Oauthio.secret_key).to eq 'bbb'
  end

  describe '.log_level' do
    it 'has a default value' do
      expect(Oauthio.log_level).to eq nil
    end

    it 'can be set' do
      [Oauthio::LEVEL_DEBUG, Oauthio::LEVEL_ERROR, Oauthio::LEVEL_INFO, nil].each do |val|
        Oauthio.log_level = val
        expect(Oauthio.log_level).to eq val
      end
    end

    it 'cannot be anything' do
      ['', 'abcd', 4242].each do |invalid_value|
        expect {
          Oauthio.log_level = invalid_value
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.logger' do
    it 'is not set by default' do
      expect(Oauthio.logger).to eq nil
    end

    it 'can be set' do
      logger = ::Logger.new(StringIO.new)
      Oauthio.logger = logger

      expect(Oauthio.logger).to eq logger
    end
  end
end
