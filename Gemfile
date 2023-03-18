# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.3'

gem 'newrelic_rpm', '~> 4.1'
gem 'rack', '>= 2.2.6.4'
gem 'sinatra', '~> 2.2', '>= 2.2.0' # Can't move to 2.0 until sinatra_auth_github does.
gem 'sinatra_auth_github', '~> 2.0', '>= 2.0.0'

group :test do
  gem 'rubocop', '>= 0.80.1'
end

group :development do
  gem 'foreman'
  gem 'pry'
  gem 'pry-remote'
  gem 'sinatra-contrib', '>= 2.2.0'
end
