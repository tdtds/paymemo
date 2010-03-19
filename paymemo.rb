#!/usr/bin/ruby
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

def get( cgi )
	db, = cgi.params['db']
	data = load( CGI::escape db )
	data['list'].reverse!

	print cgi.header(
		'status' => 'OK',
		'type' => 'application/json'
	)
	print data.to_json
end

def post( cgi )
	db = cgi.params['db'][0] || 'sample'
	item = cgi.params['item'][0] || 'dummy'
	amount = (cgi.params['amount'][0] || '0').to_i

	data = load( CGI::escape db )
	if amount != 0 then
		data['list'] << [item, amount, Time::now::strftime('%Y%m%d')]
		data['total'] += amount
		save( CGI::escape( db ), data )
	end

	print cgi.header(
		'status' => 'OK',
		'type' => 'application/json',
		'location' => './'
	)
end

cgi = CGI::new
case (cgi.request_method || 'POST').downcase
when 'post'
	post( cgi )
else
	get( cgi )
end
