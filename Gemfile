# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.1'

gem 'newrelic_rpm', '~> 4.1'
gem 'rack'
gem 'sinatra', '~> 1.0' # Can't move to 2.0 until sinatra_auth_github does.
gem 'sinatra_auth_github', '~> 1.2'

group :test do
  gem 'rubocop'
end

group :development do
  gem 'foreman'
  gem 'pry'
  gem 'sinatra-contrib'
end
