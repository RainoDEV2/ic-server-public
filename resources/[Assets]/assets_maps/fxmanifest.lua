fx_version 'adamant'
games { 'gta5' }

this_is_a_map 'yes'

files {
    'stream/iciest -pillbox/interiorproxies.meta',
    "gabz_timecycle.xml",
}

data_file 'DLC_ITYP_REQUEST' 'stream/iciest -xmas/alamo_sea.ytyp'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle.xml'

client_scripts {
    "data/client.lua",
    "data/ipl.lua"
}