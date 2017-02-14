require 'spec_helper'
require 'models/total'

describe 'PayMemo::Total', :type => :model do
	before do
		PayMemo::Total.delete_all
	end

	describe '.add' do
		context '最初にwalletの追加をすると' do
			before do
				@payment = PayMemo::Total.add('sample1', 100)
			end
			subject{ @payment }

			describe '#wallet' do
			  subject { super().wallet }
			  it {is_expected.to eq('sample1')}
			end

			describe '#amount' do
			  subject { super().amount }
			  it {is_expected.to eq(100)}
			end
		end

		context '既存のwalletに金額を追加すると' do
			before do
				PayMemo::Total.add('sample1', 100)
				@payment = PayMemo::Total.add('sample1', 500)
			end
			subject{ @payment }

			describe '#wallet' do
			  subject { super().wallet }
			  it {is_expected.to eq('sample1')}
			end

			describe '#amount' do
			  subject { super().amount }
			  it {is_expected.to eq(100+500)}
			end
		end

		context 'walletが空の場合' do
			it {expect {PayMemo::Total.add('', 100)}.to raise_error(ArgumentError)}
		end
	end
end

