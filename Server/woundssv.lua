local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('bonefive:server:SyncInjuries')
AddEventHandler('bonefive:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)