local beds = {
    { x = 356.73, y = -585.71, z = 43.11, h = -20.0, taken = false },
    { x = 360.51, y = -586.66, z = 43.11, h = -20.0, taken = false },
    { x = 353.12, y = -584.66, z = 43.50, h = -20.0, taken = false },
	{ x = 349.62, y = -583.53, z = 43.022, h = -20.0, taken = false },
	{ x = 344.80, y = -581.12, z = 43.02, h = 80.0, taken = false },
	{ x = 334.09, y = -578.43, z = 43.01, h = 80.0, taken = false },
	{ x = 323.64, y = -575.16, z = 43.02, h = -20.0, taken = false },
	{ x = 326.97, y = -576.229, z = 43.02, h = -20.0, taken = false },
	{ x = 354.24, y = -592.74, z = 43.11, h = 160.0, taken = false },
	{ x = 357.34, y = -594.45, z = 43.11, h = 160.0, taken = false },
	{ x = 350.80, y = -591.72, z = 43.11, h = 160.0, taken = false },
	{ x = 346.89, y = -591.01, z = 42.58, h = 160.0, taken = false },
}

local bedsTaken = {}
local injuryBasePrice = 100
ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('bonefive:server:RequestBed')
AddEventHandler('bonefive:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('bonefive:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('bonefive:server:RPRequestBed')
AddEventHandler('bonefive:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('bonefive:client:RPSendToBed', source, k, v)
                return
            else
                --TriggerEvent('mythic_chat:server:System', source, 'That Bed Is Taken')
		TriggerClientEvent('esx:showNotification', source, '~r~That Bed Is Taken')
            end
        end
    end

    if not foundbed then
        --TriggerEvent('mythic_chat:server:System', source, 'Not Near A Hospital Bed')
	TriggerClientEvent('esx:showNotification', source, '~r~Not Near A Hospital Bed')		
    end
end)

RegisterServerEvent('bonefive:server:EnteredBed')
AddEventHandler('bonefive:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

	-- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.removeBank(totalBill)
        TriggerClientEvent('esx:showNotification', src, '~w~You Were Billed For ~r~$' .. totalBill .. ' ~w~For Medical Services & Expenses')
	TriggerClientEvent('bonefive:client:FinishServices', src)
end)

RegisterServerEvent('bonefive:server:LeaveBed')
AddEventHandler('bonefive:server:LeaveBed', function(id)
    beds[id].taken = false
end)
