# -*- coding: utf-8; -*-
#
# paymemo.rb
# https://github.com/tdtds/paymemo
#
# Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#
require 'sinatra/base'
require 'haml'
require 'json'
require 'omniauth'
require 'omniauth-twitter'
require 'rack/csrf'
require 'mongo_mapper'
require 'rack-session-mongo'
require 'dalli'

module PayMemo
	class App < Sinatra::Base
		set :haml, {format: :html5, escape_html: true}

		configure :production do
         @auth_twitter  = {
				:id => ENV['TWITTER_CONSUMER_ID'],
				:secret => ENV['TWITTER_CONSUMER_SECRET']
			}
			@db_uri = URI.parse(ENV['MONGOLAB_URI'])
		end

		configure :development, :test do
			Bundler.require :development
			register Sinatra::Reloader
			disable :protection

			@auth_twitter = Pit::get( 'auth_twitter', :require => {
					:id => 'your CONSUMER KEY of Twitter APP.',
					:secret => 'your CONSUMER SECRET of Twitter APP.',
				} )
			@db_uri = URI.parse('mongodb://localhost:27017/paymemo')
		end
		MongoMapper::connection = Mongo::Connection.from_uri(@db_uri.to_s)

		use(
			Rack::Session::Mongo,{
				:db => MongoMapper.connection.db('dbname'),
				:expire_after => 6 * 30 * 24 * 60 * 60,
				:secret => ENV['SESSION_SECRET']
			})

		use(
			OmniAuth::Strategies::Twitter,
			@auth_twitter[:id],
			@auth_twitter[:secret])

		use Rack::Csrf
	end
end

require_relative 'models/init'
require_relative 'routes/init'
PayMemo::App.run! if __FILE__ == $0
