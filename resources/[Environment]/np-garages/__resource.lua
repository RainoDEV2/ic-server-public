resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

server_scripts {
	'@np-remotecalls/server/sv_main.lua',
	'server/sv_*.lua'
}

client_scripts {
	'@np-remotecalls/client/cl_main.lua',
	'client/cl_*.lua'
}

shared_scripts {
	'shared/sh_*.lua'
}