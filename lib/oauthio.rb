require "oauthio/version"

module Oauthio
  @public_key = nil
  @secret_key = nil
  @csrf_tokens = [],
  @oauthd_url = 'https://oauth.io',
  @oauthd_base = '/auth'

  class << self
    attr_accessor :csrf_tokens

    attr_reader :public_key, :secret_key
  end

  def self.set_credentials pk, sk
    @public_key = pk
    @secret_key = sk
  end
end
