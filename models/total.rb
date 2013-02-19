# -*- coding: utf-8; -*-
require 'mongo_mapper'

module PayMemo
	class Total
		include MongoMapper::Document

		key :wallet, type: String,  required: true , unique: true
		key :amount, type: Integer, required: true 
		timestamps!

		def self.add(wallet, amount)
			raise ArgumentError.new('wallet should not empty.') if !wallet || wallet.empty?

			total = Total.find_by_wallet(wallet)
			if total
				total[:amount] += amount
			else
				total = Total.new(wallet: wallet, amount: amount)
			end
			total.save!
			return total
		end
	end 
end


