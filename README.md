# Oauthio

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/oauthio`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

WORK IN PROGRESS

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oauthio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oauthio

## Usage

Example:


```
# routes.rb
get 'oauth/:provider/signin', to: 'auth/oauth_callbacks#signin'
get 'oauth/redirect', to: 'auth/oauth_callbacks#redirect'

# controllers/auth/oauth_callbacks_controller.rb
 def signin
  # ..
  # check params[:provider] is enabled
  # ...

  session[:oauthio_state_token] = form_authenticity_token
  redirect_to Oauthio.auth_url('google', 'http://localhost:3000/oauth/redirect', session[:oauthio_state_token])
end

def redirect
  oauthio_payload = JSON.parse(params['oauthio'])

  if session[:oauthio_state_token].present? &&oauthio_payload['state'] == session[:oauthio_state_token]
    if oauthio_payload['status'] == 'success'
      oauth_client = Oauthio::Client.new 'google', oauthio_payload['data']['access_token']

      render json: oauth_client.me
    else
      render json: { error: "Invalid oauth.io status: #{oauthio_payload['status']}" }
    end
  else
    render json: { error: 'CSRF token does NOT match' }
  end
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/oauthio.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
