def load( db )
	begin
		JSON::parse( open( "#{db}.json", 'r:utf-8', &:read ) )
	rescue Errno::ENOENT
		{'total' => 0, 'list' => []}
	end
end

def save( db, data )
	open( "#{db}.json", 'w' ){|f| f.write( data.to_json ) }
end


