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
