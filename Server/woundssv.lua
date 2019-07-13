local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('bonefive:SyncInjuries')
AddEventHandler('bonefive:SyncInjuries', function(data)
    playerInjury[source] = data
end)