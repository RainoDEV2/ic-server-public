fx_version 'cerulean'
games { 'rdr3', 'gta5' }
version '1.0.0'


client_scripts {
	'@np-remotecalls/client/cl_main.lua',
	'client/*.lua'
}

server_scripts {
	'@np-remotecalls/server/sv_main.lua',
 	'server/*.lua'
}