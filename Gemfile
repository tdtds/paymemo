source 'https://rubygems.org'

ruby ENV['CUSTOM_RUBY_VERSION'] || '2.2.4'

gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'hamlit', require: 'hamlit'
gem 'omniauth', require: 'omniauth'
gem 'omniauth-twitter', require: 'omniauth-twitter'
gem 'mongo_mapper', require: 'mongo_mapper'
gem 'bson_ext'
gem 'rack_csrf', require: 'rack/csrf'
gem 'rack-session-mongo', require: 'rack-session-mongo'
gem 'dalli', require: 'dalli'

group :development, :test do
	gem 'rake'
	gem 'rspec'
	gem 'autotest'
	gem 'sinatra-reloader', require: 'sinatra/reloader'
	gem 'pit', require: 'pit'
	gem 'pry'
end
