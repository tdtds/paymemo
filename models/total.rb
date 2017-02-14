module PayMemo
	class Total
		include ::Mongoid::Document
		include ::Mongoid::Timestamps
		store_in collection: "pay_memo.totals"

		field :wallet, type: String
		field :amount, type: Integer
		validates_presence_of :wallet
		validates_uniqueness_of :wallet

		def self.add(wallet, amount)
			total = find_or_create_by(wallet: wallet)
			raise ArgumentError.new(total.errors.messages) unless total.valid?
			total.update_attributes!(
				wallet: wallet,
				amount: (total.amount || 0) + amount
			)
			total.save
			return total
		end
	end 
end
