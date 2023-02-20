fx_version 'cerulean'

game 'gta5'
lua54 'yes'

name 'CombatTagged'
author 'Mindexas#0001'
version 'v0.1'
description 'A framework-standalone radio UI for FiveM'
repository 'https://github.com/antond15/ac_radio'


server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
}

client_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	'client/redzone.lua',
	'client/redzone2.lua',
	'client/combat.lua',
}

shared_script '@ox_lib/init.lua'server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }


server_script '@salty_tokenizer/init.lua'
client_script '@salty_tokenizer/init.lua'