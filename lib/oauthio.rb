require 'logger'

require "oauthio/version"

module Oauthio
  @public_key = nil
  @secret_key = nil
  @csrf_tokens = [],
  @oauthd_url = 'https://oauth.io',
  @oauthd_base = '/auth'

  @log_level = nil
  @logger = nil

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  class << self
    attr_accessor :csrf_tokens

    attr_reader :public_key, :secret_key, :log_level
  end

  def self.set_credentials pk, sk
    @public_key = pk
    @secret_key = sk
  end

  def self.log_level
    @log_level
  end

  def self.log_level=(val)
    if !val.nil? && ![LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO].include?(val)
      raise ArgumentError, "log_level should only be set to `nil`, `debug` or `info`"
    end
    @log_level = val
  end


  def self.logger
    @logger
  end

  def self.logger=(val)
    @logger = val
  end

end
