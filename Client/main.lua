--Temp Config until config file is written
local hostpicalCheckin = {x = 308.06161499023, y = -595.19683837891, z = 43.291839599609, h = 180.4409942627}
local pillboxTeleports = {
    { x = 325.48892211914, y = -598.75372314453, z = 43.291839599609, h = 64.513374328613, text = 'Press ~INPUT_CONTEXT~ ~s~to go to lower Pillbox Entrance' },
    { x = 355.47183227539, y = -596.26495361328, z = 28.773477554321, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
    { x = 359.57849121094, y = -584.90911865234, z = 28.817169189453, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
}

--DO NOT CHANGE FROM THIS POINT ON
local bedOccupying = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--All Server events need to be written

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Gets the player out of the bed
function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict, getOutAnim, 8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(5000)
    CleadPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('bonefive:LeaveBed', bedOccupying)

    bedOccupying = nil
    bedOccupyingData = nil
end

RegisterNetEvent('bonefive:RCheckPos')
AddEventHandler('bonefive:RCheckPos', function()
    TriggerServerEvent('bonefive:RRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('bonefive:RSendToBed')
AddEventHandler('bonefive:RSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.5)

    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict, inBedAnim, 8.0, -8.0, -1, 1, 0, false, false, false)
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0, true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)
            PrintHelpText('Press ~INPUT_VEH_DUCK~ to get up')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('bonefive:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.3)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict, inBedAnim, 8.0, -8.0, -1, 1, 0, false, false, false)
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0, true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()

        exports['mythic_notify']:DoHudText('inform', 'You are being treated')
        Citizen.Wait(5000)
        TriggerServerEvent('bonefive:EnteredBed')
    end)
end)

RegisterNetEvent('bonefive:FinishServices')
AddEventHandler('mythic_hospital:FinishServices', function()
    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    TriggerEvent('bonefive:RemoveBleed')
    TriggerEvent('bonefive:ResetLimbs')
    exports['mythic_notify']:DoHudText('inform', 'You\'ve been treated & billed')
    LeaveBed()
end)

RegisterNetEvent('bonefive:ForceLeaveBed')
AddEventHandler('bonefive:ForceLeaveBed', function()
    LeaveBed()
end)
-- Disable The Native Auto-Heal
SetPlayerHealthRechargeMultiplier(PlayerPedId(), 0.0)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
			local plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
            if distance < 10 then
               --DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)

                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if distance < 1 then
                        --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in') -- Doesnt look as good
			ESX.Game.Utils.DrawText3D(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z + 0.5), '[E] Check in', 0.4)
                        if IsControlJustReleased(0, 54) then
                            if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
										coords = { x = 0.10, y = 0.02, z = 0.08 },
										rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
										coords = { x = 0.12, y = 0.0, z = 0.001 },
										rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        TriggerServerEvent('bonefive:RequestBed')
                                    end
                                end)
                            else
                                exports['mythic_notify']:DoHudText('error', 'You do not need medical attention')
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
    end
end)