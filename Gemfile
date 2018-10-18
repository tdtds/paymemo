source 'https://rubygems.org'

ruby '~> 2.5.2'

gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'hamlit', require: 'hamlit'
gem 'omniauth', require: 'omniauth'
gem 'omniauth-twitter', require: 'omniauth-twitter'
gem 'mongoid', "~> 7.0", require: 'mongoid'
gem 'bson_ext'
gem 'rack_csrf', require: 'rack/csrf'
gem 'dalli', require: 'rack/session/dalli'
gem 'memcachier', require: 'memcachier'

group :development, :test do
	gem 'rake'
	gem 'guard-rspec'
	gem 'sinatra-reloader', require: 'sinatra/reloader'
	gem 'dotenv', require: 'dotenv'
	gem 'pry'
end
