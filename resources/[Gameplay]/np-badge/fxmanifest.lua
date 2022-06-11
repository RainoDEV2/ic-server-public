fx_version 'bodacious'
game 'gta5'

ui_page {
    'html/ui.html',
}


client_scripts {
    'client/client.lua',
	'@np-remotecalls/client/cl_main.lua',
}


server_scripts {
	'@np-remotecalls/server/sv_main.lua',
    'server/server.lua',
}


files {
	'html/ui.html',
	'html/assets/*.png',
	'html/css/*.css',
	'html/js/*.js',

}