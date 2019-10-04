# paymemo.rb
# https://github.com/tdtds/paymemo
#
# Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#
Bundler.require(:default, ENV['RACK_ENV'] || :development)
require 'json'

module PayMemo
	class App < Sinatra::Base
		set :haml, {format: :html5}
		db_uri = 'mongodb://localhost:27017/paymemo'

		configure :production do
			db_uri = ENV['MONGOLAB_URI'] || ENV['MONGODB_URI']
		end

		configure :development, :test do
			Dotenv.load # set ALLOW_USERS, WALLETS and TWITTER_CONSUMER_*
			register Sinatra::Reloader
			disable :protection
		end

		configure do
			Mongoid::Config.load_configuration({
				clients:{
					default:{
						uri: db_uri
						options:{retry_writes: false}
					}
				}
			})

			session_expire = 60 * 60 * 24 * 30 - 1
			use Rack::Session::Dalli, cache: Dalli::Client.new, expire_after: session_expire

			twitter_id = ENV['TWITTER_CONSUMER_ID']
			twitter_secret = ENV['TWITTER_CONSUMER_SECRET']
			use OmniAuth::Strategies::Twitter, twitter_id, twitter_secret

			use Rack::Csrf
			helpers do
				def csrf_meta
					{:name => "_csrf", :content => Rack::Csrf.token(env)}
				end

				def csrf_input
					{:type => 'hidden', :name => '_csrf', :value => Rack::Csrf.token(env)}
				end
			end
		end
	end
end

require_relative 'models/init'
require_relative 'routes/init'
PayMemo::App.run! if __FILE__ == $0
