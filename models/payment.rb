# -*- coding: utf-8; -*-
require 'mongo_mapper'

module PayMemo
	class Payment
		include MongoMapper::Document

		key :wallet, type: String,  required: true 
		key :item,   type: String,  required: true 
		key :amount, type: Integer, required: true 
		timestamps!

		def self.add(wallet, item, amount)
			raise ArgumentError.new('wallet should not empty.') if !wallet || wallet.empty?
			raise ArgumentError.new('wallet should not empty.') if !item || item.empty?
			raise ArgumentError.new('amount should not zero.') if amount == 0

			payment = Payment.new(wallet: wallet, item: item, amount: amount)
			payment.save!
			return payment
		end
	end 
end

