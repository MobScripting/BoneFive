ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

----
ESX.RegisterUsableItem('gauze', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('gauze', 1)

	TriggerClientEvent('bonefive:gauze', source)
end)

ESX.RegisterUsableItem('bandage', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bandage', 1)

	TriggerClientEvent('bonefive:bandage', source)
end)

ESX.RegisterUsableItem('firstaid', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('firstaid', 1)

	TriggerClientEvent('bonefive:firstaid', source)
end)

ESX.RegisterUsableItem('medkit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('medkit', 1)

	TriggerClientEvent('bonefive:medkit', source)
end)

ESX.RegisterUsableItem('vicodin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vicodin', 1)

	TriggerClientEvent('bonefive:vicodin', source)
end)

ESX.RegisterUsableItem('hydrocodone', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hydrocodone', 1)

	TriggerClientEvent('bonefive:hydrocodone', source)
end)

ESX.RegisterUsableItem('morphine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('morphine', 1)

	TriggerClientEvent('bonefive:morphine', source)
end)