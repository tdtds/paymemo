module PayMemo
	class Payment
		include ::Mongoid::Document
		include ::Mongoid::Timestamps
		store_in collection: "pay_memo.payments"

		field :wallet, type: String
		field :item,   type: String
		field :amount, type: Integer
		validates_presence_of :wallet, :item, :amount
		validates_length_of :wallet, :item, minimum: 1
		validate :amount_not_zero

		def amount_not_zero
			errors(:amount, 'amount must be not zero') if amount == 0
		end

		def self.add(wallet, item, amount)
			payment = create(wallet: wallet, item: item, amount: amount)
			raise ArgumentError.new(payment.errors.messages) unless payment.valid?
			payment.save
			return payment
		end
	end 
end

