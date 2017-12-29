require 'pry'
require 'oauthio'

RSpec.describe Oauthio do
  it "has a version number" do
    expect(Oauthio::VERSION).not_to be nil
  end

  it 'has credentials' do
    Oauthio.set_credentials('xxx', 'bbb')

    expect(Oauthio.public_key).to eq 'xxx'
    expect(Oauthio.secret_key).to eq 'bbb'
  end
end
