#!/usr/bin/ruby
#
# paymemo.rb
#
# Copyright (C) 2010 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#
require 'rubygems'
require 'cgi'
require 'json'

def load( db )
	begin
		JSON::parse( open( "#{db}.json", &:read ) )
	rescue Errno::ENOENT
		{'total' => 0, 'list' => []}
	end
end

def save( db, data )
	open( "#{db}.json", 'w' ){|f| f.write( data.to_json ) }
end

#
# returning total amount and recent 5 items with json format.
#
def get( cgi )
	db, = cgi.params['db']
	data = load( CGI::escape db )
	data['list'] = data['list'].reverse[0,5]

	print cgi.header(
		'status' => 'OK',
		'type' => 'application/json',
		'cache-control' => 'no-cache'
	)
	print data.to_json
end

#
# receiving new amount then returning new total and a item with json format.
#
def post( cgi )
	db = cgi.params['db'][0] || 'sample'
	item = cgi.params['item'][0] || 'dummy'
	amount = (cgi.params['amount'][0] || '0').to_i

	data = load( CGI::escape db )
	if amount != 0 then
		data['list'] << [item, amount, Time::now::strftime('%Y%m%d')]
		data['total'] += amount
		save( CGI::escape( db ), data )

		data['list'] = data['list'].reverse[0,1]
	else
		data['list'] = [] # returning empty list
	end
	print cgi.header(
		'status' => 'OK',
		'type' => 'application/json',
		'cache-control' => 'no-cache'
	)
	print data.to_json
end

cgi = CGI::new
case (cgi.request_method || 'POST').downcase
when 'post'
	post( cgi )
else
	get( cgi )
end
