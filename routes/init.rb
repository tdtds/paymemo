# -*- coding: utf-8; -*-
#
# routes/init.rb : initialize routes
#
# Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#
module PayMemo
	class App < Sinatra::Base
		get '/' do
			haml :index
		end

		#
		# returning total amount and recent 5 items with json format.
		#
		get '/:wallet.json' do
			wallet = params[:wallet]
			list = Payment.where(wallet: wallet)
			total = 0 #Payment.total(wallet)

			{'list' => list, 'total' => total}.to_json
		end

		#
		# receiving new amount then returning new total and a item with json format.
		#
		post '/:wallet' do
			wallet = params[:wallet]
			item = params[:item]
			amount = (params[:amount] || '0').to_i
			result = {}

			if amount != 0
				result['list'] = [Payment.add(wallet, item, amount)]
			else
				result['list'] = []
			end
			result['total'] = Payment.total(:wallet)
			result.to_json
		end
	end
end
