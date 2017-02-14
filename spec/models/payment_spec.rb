require 'spec_helper'
require 'models/payment'

describe 'PayMemo::Payment', :type => :model do
	before do
		PayMemo::Payment.delete_all
	end

	describe '.add' do
		context 'アイテムの追加をすると' do
			before do
				@payment = PayMemo::Payment.add('sample1', 'item1', 100)
			end
			subject{ @payment }

			describe '#wallet' do
			  subject { super().wallet }
			  it {is_expected.to eq('sample1')}
			end

			describe '#item' do
			  subject { super().item }
			  it {is_expected.to eq('item1')}
			end

			describe '#amount' do
			  subject { super().amount }
			  it {is_expected.to eq(100)}
			end
		end

		context 'walletが空の場合' do
			it {expect {PayMemo::Payment.add('', 'item2', 100)}.to raise_error(ArgumentError)}
		end

		context 'itemが空の場合' do
			it {expect {PayMemo::Payment.add('sample1', '', 100)}.to raise_error(ArgumentError)}
		end

		context '価格0円の場合' do
			it {expect {PayMemo::Payment.add('sample1', 'item3', 0)}.to raise_error(ArgumentError)}
		end
	end
end
