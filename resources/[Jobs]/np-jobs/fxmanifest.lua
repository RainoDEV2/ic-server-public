fx_version 'bodacious'
games { 'rdr3', 'gta5' }

server_export 'AddJob' 

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/cursor.png',
	'html/background.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
}

client_scripts {
   '@np-remotecalls/client/cl_main.lua',
  'client/cl_*.lua'
}

server_scripts {
  '@np-remotecalls/server/sv_main.lua',
  'server/sv_*.lua'
}