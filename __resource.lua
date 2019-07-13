resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'BoneFive Injury System'

version '0.0.1'

client_scripts {
	'client/wounds.lua',
	'client/main.lua',
	'client/items.lua',
}

server_scripts {
	'server/woundssv.lua',
	'server/mainsv.lua',
	'server/itemssv.lua',
}

dependencies {
	'mythic_progbar',
	'mythic_notify',
}

exports {
    'IsInjuredOrBleeding',
}

server_exports {
    'GetCharsInjuries',
}
