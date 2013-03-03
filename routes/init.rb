# -*- coding: utf-8; -*-
#
# routes/init.rb : initialize routes
#
# Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#
module PayMemo
	class App < Sinatra::Base
		before do
			if request.path !~ %r|^/auth/| && !session[:user]
				redirect '/auth/twitter'
			end
		end

		get '/auth/twitter/callback' do
			session.clear
			twitter_user = request.env['omniauth.auth']['extra']['raw_info']['screen_name']
			if ENV['ALLOW_USERS'].split(/,\s*/).index(twitter_user)
				session[:user] = twitter_user
			end
			redirect '/'
		end

		get '/' do
			haml :index
		end

		#
		# returning total amount and recent 5 items with json format.
		#
		get '/:wallet.json' do
			wallet = params[:wallet]
			list = Payment.where(wallet: wallet).sort(:created_at.desc).limit(5)
			total = Total.find_by_wallet(wallet).amount rescue 0

			{'list' => list, 'total' => total}.to_json
		end

		#
		# receiving new amount then returning new total and a item with json format.
		#
		post '/:wallet' do
			puts "post to #{params[:wallet]}"
			wallet = params[:wallet]
			item = params[:item]
			amount = (params[:amount] || '0').to_i
			result = {}

			if amount != 0
				result['list'] = [Payment.add(wallet, item, amount)]
			else
				result['list'] = []
			end
			result['total'] = Total.add(wallet, amount).amount
			result.to_json
		end
	end
end
