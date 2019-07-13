RegisterNetEvent("bonefive:items:gauze")
AddEventHandler("bonefive:items:gauze", function(item)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "firstaid_action",
        duration = 3000,
        label = "Packing Wounds",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            TriggerEvent('bonefive:client:RemoveBleed')
            TriggerEvent('bonefive:client:FieldTreatBleed')
        end
    end)
end)

RegisterNetEvent("bonefive:items:bandage")
AddEventHandler("bonefive:items:bandage", function(item)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "firstaid_action",
        duration = 5000,
        label = "Using Bandage",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
            SetEntityHealth(PlayerPedId(), newHealth)
            TriggerEvent('bonefive:client:ReduceBleed')
        end
    end)
end)

RegisterNetEvent("bonefive:items:firstaid")
AddEventHandler("bonefive:items:firstaid", function(item)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "firstaid_action",
        duration = 10000,
        label = "Using First Aid",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_stat_pack_01"
        },
    }, function(status)
        if not status then
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
            SetEntityHealth(PlayerPedId(), newHealth)
            TriggerEvent('bonefive:client:FieldTreatLimbs')
        end
    end)
end)

RegisterNetEvent("bonefive:items:medkit")
AddEventHandler("bonefive:items:medkit", function(item)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "firstaid_action",
        duration = 20000,
        label = "Using Medkit",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_ld_health_pack"
        },
    }, function(status)
        if not status then
			SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('bonefive:client:FieldTreatLimbs')
            TriggerEvent('bonefive:client:ResetLimbs')
        end
    end)
end)

RegisterNetEvent("bonefive:items:vicodin")
AddEventHandler("bonefive:items:vicodin", function(item)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "firstaid_action",
        duration = 2000,
        label = "Taking vicodin",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('bonefive:client:UsePainKiller', 1)
        end
    end)
end)

RegisterNetEvent("bonefive:items:hydrocodone")
AddEventHandler("bonefive:items:hydrocodone", function(item)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "firstaid_action",
        duration = 2000,
        label = "Taking hydrocodone",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('bonefive:client:UsePainKiller', 2)
        end
    end)
end)

RegisterNetEvent("bonefive:items:morphine")
AddEventHandler("bonefive:items:morphine", function(item)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "firstaid_action",
        duration = 2000,
        label = "Taking morphine",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('bonefive:client:UsePainKiller', 6)
            TriggerEvent('bonefive:client:UseAdrenaline', 2)
        end
    end)
end)
