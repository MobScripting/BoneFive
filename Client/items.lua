RegisterNetEvent("bonefive:gauze")
AddEventHandler("bonefive:gauze", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Packing Wounds",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
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
            TriggerEvent('bonefive:RemoveBleed')
        end
    end)
end)

RegisterNetEvent("bonefive:bandage")
AddEventHandler("bonefiv:bandage", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 5000,
        label = "Using Bandage",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bad_small",
        }
    }, function(status)
        if not status then
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
            local health = GetEntityHealth(PlayerPedId())
            local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
            SetEntityHealth(PlayerPedId(), newHealth)
            TriggerEvent('bonefive:ReduceBleed')
        end
    end)
end)

RegisterNetEvent("bonefive:firstaid")
AddEventHandler("bonefive:firstaid", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 10000,
        label = "Using First Aid",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
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
            TriggerEvent('bonefive:FieldTreatLimbs')
            TriggerEvent('bonefive:RemoveBleed')
        end
    end)
end)

RegisterNetEvent("bonefive:medkit")
AddEventHandler("bonefive:medkit", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 20000,
        label = "Using Medkit",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
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
            TriggerEvent('bonefive:FieldTreatLimbs')
            TriggerEvent('bonefive:RemoveBleed')
        end
    end)
end)

RegisterNetEvent("bonefive:vicodin")
AddEventHandler("bonefive:vicodin", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking vicodin",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
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
            TriggerEvent('bonefive:UsePainKiller', 1)
        end
    end)
end)

RegisterNetEvent("bonefive:hydrocodone")
AddEventHandler("bonefive:hydrocodone", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking hydrocodone",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
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
            TriggerEvent('bonefive:UsePainKiller', 2)
        end
    end)
end)

RegisterNetEvent("bonefive:morphine")
AddEventHandler("bonefive:morphine", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking morphine",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
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
            TriggerEvent('bonefive:UsePainKiller', 6)
            TriggerEvent('bonefive:UserAdrenaline', 3)
        end
    end)
end)