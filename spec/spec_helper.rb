# -*- coding: utf-8 -*-
#
# spec_helper.rb
#
# Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..')).untaint
Bundler.require(:default, :test) if defined?(Bundler)

RSpec.configure do |config|
	Mongoid::Config.load_configuration({
		clients: {
			default: {
				uri: 'mongodb://localhost:27017/paymemo_test'
			}
		}
	})
end

