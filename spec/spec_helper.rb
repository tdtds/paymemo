# -*- coding: utf-8 -*-
#
# spec_helper.rb
#
# Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..')).untaint
Bundler.require :test if defined?(Bundler)

RSpec.configure do |config|
	require 'mongo_mapper'
	require 'uri'
	require 'pathname'

	uri = URI('mongodb://localhost:27017/paymemo_test')
	dbname = Pathname(uri.path).basename.to_s
	MongoMapper::connection = Mongo::Connection.from_uri(uri.to_s)
	MongoMapper::database = dbname
	config.before(:each) do
		MongoMapper.database.collections.each {|collection| collection.remove rescue nil}
	end
end

