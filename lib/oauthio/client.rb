require 'httparty'

module Oauthio
  class Client
    attr_accessor :provider, :access_token

    def initialize provider, access_token
      @provider = provider
      @access_token = access_token
    end

    def me
      HTTParty.get "#{Oauthio.endpoint_url}/#{@provider}/me", headers: {
        'oauthio' => "k=#{Oauthio.public_key}&access_token=#{@access_token}",
        'Content-Type' => 'application/json'
      }
    end
  end
end
