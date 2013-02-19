# -*- coding: utf-8; -*-
#
# routes/init.rb : initialize routes
#
# Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
# You can modify and distribue this under GPL.
#

require_relative 'payment'
require_relative 'total'

#def load( db )
#	begin
#		JSON::parse( open( "#{db}.json", 'r:utf-8', &:read ) )
#	rescue Errno::ENOENT
#		{'total' => 0, 'list' => []}
#	end
#end
#
#def save( db, data )
#	open( "#{db}.json", 'w' ){|f| f.write( data.to_json ) }
#end
#
#data['list'] << [item, amount, Time::now::strftime('%Y%m%d')]
#data['total'] += amount
#save( CGI::escape( db ), data )
#
