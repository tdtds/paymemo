# -*- coding: utf-8 -*-
require 'spec_helper'
require 'models/payment'

describe 'PayMemo::Payment' do
	describe '.add' do
		context 'アイテムの追加をすると' do
			before do
				@payment = PayMemo::Payment.add('sample1', 'item1', 100)
			end
			subject{ @payment }

			its(:wallet) {should eq('sample1')}
			its(:item)   {should eq('item1')}
			its(:amount) {should eq(100)}
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
