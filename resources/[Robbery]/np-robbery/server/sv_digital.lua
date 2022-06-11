math.randomseed(os.time())

cooldown = false


digital = {
    [1] = {
        state = false,
        event = "np-digital:client:attemptHack",
        icon = "fas fa-bolt",
        label = "Electrical Box!",
        distance = 1.5,
        coords = {x = 1152.7, y = -433.22, z = 67.01, width = 0.6, height = 0.2, h = 345, minZ = 64.01, maxZ = 68.1},
        item = "electronickit",
    },
    [2] = {
        state = false,
        event = "np-digital:client:hackLaptop",
        icon = "fas fa-laptop",
        label = "Insert USB into Laptop",
        distance = 1.5,
        coords = {x = 1129.41, y = -468.84, z = 62.81, width = 0.4, height = 0.6, h = 357, minZ = 59.21, maxZ = 63.21},
        item = "usbdevice",
    },
    [3] = {
        state = false,
        code = math.random(00000000000000000000000000,99999999999999999999999999999999999999),
        event = "np-digital:client:safe",
        icon = "fas fa-user-shield",
        label = "Interact with Safe!",
        distance = 1.5,
        coords = {x = 1134.53, y = -462.75, z = 62.81, width = 0.8, height = 0.6, h = 346, minZ = 59.01, maxZ = 63.01},
    },
    [4] = {
        state = false,
        event = "np-laptop:usb",
        icon = "fas fa-laptop",
        label = "Insert USB",
        distance = 1.0,
        coords = {x = 1135.24, y = -468.93, z = 66.49, width = 0.4, height = 0.4, h = 5, minZ = 63.09, maxZ = 67.09},
    },
    [5] = {
        state = true,
        event = "np-digital:loot",
        icon = "fas fa-hands",
        label = "Loot!",
        parms = 5,
        distance = 1.0,
        coords = {x = 1129.3, y = -475.59, z = 66.48, width = 1.4, height = 0.8, h = 345, minZ = 63.88, maxZ = 67.88},
    },
    [6] = {
        state = true,
        event = "np-digital:loot",
        icon = "fas fa-hands",
        label = "Loot!",
        parms = 6,
        distance = 1.0,
        coords = {x = 1129.68, y = -473.67, z = 66.48, width = 1.6, height = 1, h = 345, minZ = 63.88, maxZ = 67.88},
    },
    [7] = {
        state = true,
        event = "np-digital:loot",
        icon = "fas fa-hands",
        label = "Loot!",
        parms = 7,
        distance = 1.0,
        coords = {x = 1133.14, y = -473.28, z = 66.48, width = 1.8, height = 1.2, h = 345, minZ = 63.28, maxZ = 67.28},
    }
}

local loottable = {
    [1] = { item = 'cpu', chance = 80, amount = math.random(1,3)},
    [2] = { item = 'powersupply', chance = 100, amount = math.random(1,3)},
    [3] = { item = 'electronics', chance = 80, amount = math.random(5, 10)},
},


remoteCalls.register("np-digital:recieveCoords", function()
    print(json.encode(digital))
    return digital
end)

remoteCalls.register("np-digital:hackDigital", function(index, bool)
    digital[index].state = bool
end)

remoteCalls.register("np-digital:loot", function(params)
    local src = source
    local loot = {}
    print(digital[params].state)
    for i = 1, #loottable do
        if randomChance(loottable[i].chance) then
            table.insert(loot, loottable[i].item)
            digital[params].state = true
            TriggerClientEvent('player:receiveItem', src, tostring(loottable[i].item), loottable[i].amount)
        end
    end
    return loot
end)

-- RegisterCommand('closedigital')

remoteCalls.register('np-digitalden:enableLooting', function()
    for i = 5, 7 do
        digital[i].state = false
        print(digital[i].state)
    end
end)

remoteCalls.register("np-digital:changeCode", function()
    local stuff = math.random(0000,9999)
    digital[3].code = stuff
    return stuff
end)

remoteCalls.register("np-digital:startCooldown", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local job = user:getVar("job")
    if job == "police" then
        Citizen.CreateThread(function()
            if not cooldown then
                cooldown = true
                TriggerEvent('np-doors:changeLock-status', 208, true)
                Citizen.SetTimeout(3000 * 60, function()
                    cooldown = false
                    for i = 1,4 do
                        digital[i].state = false
                    end
                end)
            else
                TriggerClientEvent('DoShortHudText', src, 'Digital already in cooldown!', 2)
            end
        end)
    end
end)

remoteCalls.register("np-digital:getCooldown", function()
    return cooldown
end)


function randomChance(percent)
    math.randomseed(os.time())
    return percent >= math.random(1, 100)  
  end
