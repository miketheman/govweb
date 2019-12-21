# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.3'

gem 'newrelic_rpm', '~> 4.1'
gem 'rack', '>= 1.6.12'
gem 'sinatra', '~> 1.4', '>= 1.4.8' # Can't move to 2.0 until sinatra_auth_github does.
gem 'sinatra_auth_github', '~> 1.2', '>= 1.2.0'

group :test do
  gem 'rubocop'
end

group :development do
  gem 'foreman'
  gem 'pry'
  gem 'pry-remote'
  gem 'sinatra-contrib', '>= 1.4.7'
end
