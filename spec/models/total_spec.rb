# -*- coding: utf-8 -*-
require 'spec_helper'
require 'models/total'

describe 'PayMemo::Total' do
	describe '.add' do
		context '最初にwalletの追加をすると' do
			before do
				@payment = PayMemo::Total.add('sample1', 100)
			end
			subject{ @payment }

			its(:wallet) {should eq('sample1')}
			its(:amount) {should eq(100)}
		end

		context '既存のwalletに金額を追加すると' do
			before do
				PayMemo::Total.add('sample1', 100)
				@payment = PayMemo::Total.add('sample1', 500)
			end
			subject{ @payment }

			its(:wallet) {should eq('sample1')}
			its(:amount) {should eq(100+500)}
		end

		context 'walletが空の場合' do
			it {expect {PayMemo::Total.add('', 100)}.to raise_error(ArgumentError)}
		end
	end
end

