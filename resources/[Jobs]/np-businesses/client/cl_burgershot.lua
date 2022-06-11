RegisterNetEvent("np-burgershot:startprocess3")
AddEventHandler("np-burgershot:startprocess3", function()
    local rank = exports["np_handler"]:GroupRank("burger_shot")
    if rank > 0 then    
        if exports["np-inventory"]:hasEnoughOfItem("rawpatty", 1) then
            local dict = 'amb@prop_human_bbq@male@idle_a'
            LoadDict(dict)
            FreezeEntityPosition(PlayerPedId(),true)
            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, false)
            Citizen.Wait(2500)
            SetEntityHeading(PlayerPedId(), 124.72439575195)
            local finished = exports['np-taskbar']:taskBar(25000, 'Cooking the Patty')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "rawpatty", 1)
                TriggerEvent('player:receiveItem', 'patty', 2)
                FreezeEntityPosition(PlayerPedId(),false)
                ClearPedTasks(PlayerPedId())
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(PlayerPedId(),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You need some Raw Patty to Make some Cooked Pattys! (Required Amount: 2)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("np-burgershot:startfryer")
AddEventHandler("np-burgershot:startfryer", function()
    local rank = exports["np_handler"]:GroupRank("burger_shot")
    if rank > 0 then  
        if exports["np-inventory"]:hasEnoughOfItem("potato", 1) then
            local dict = 'missfinale_c2ig_11'
            LoadDict(dict)
            FreezeEntityPosition(PlayerPedId(),true)
            TaskPlayAnim(PlayerPedId(), dict, "pushcar_offcliff_f", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(PlayerPedId(), 124.72439575195)
            local finished = exports['np-taskbar']:taskBar(20000, 'Dropping Fries')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'fries', 2)
                TriggerEvent("inventory:removeItem", "potato", 1)
                FreezeEntityPosition(PlayerPedId(),false)
                ClearPedTasks(PlayerPedId())
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(PlayerPedId(),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You Havent Got Any Cut Potatoes! (Required Amount: 1)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("np-burgershot:makeshake")
AddEventHandler("np-burgershot:makeshake", function()
    local rank = exports["np_handler"]:GroupRank("burger_shot")
    if rank > 0 then
        if exports["np-inventory"]:hasEnoughOfItem("milkshakeformula", 1) then
            local dict = 'mp_ped_interaction'
            LoadDict(dict)
            FreezeEntityPosition(PlayerPedId(),true)
            TaskPlayAnim(PlayerPedId(), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(PlayerPedId(), 124.72439575195)
            local finished = exports['np-taskbar']:taskBar(10000, 'Making Milk Shake')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'mshake', 2)
                TriggerEvent("inventory:removeItem", "milkshakeformula", 1)
                FreezeEntityPosition(PlayerPedId(),false)
                ClearPedTasks(PlayerPedId())
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(PlayerPedId(),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You Havent got any Milk Shake Formula! (Required Amount: 1)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("np-burgershot:getcola")
AddEventHandler("np-burgershot:getcola", function()
    local rank = exports["np_handler"]:GroupRank("burger_shot")
    if rank > 0 then
        if exports["np-inventory"]:hasEnoughOfItem("hfcs", 1) then
            local dict = 'mp_ped_interaction'
            LoadDict(dict)
            FreezeEntityPosition(PlayerPedId(),true)
            TaskPlayAnim(PlayerPedId(), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(PlayerPedId(), 124.72439575195)
            local finished = exports['np-taskbar']:taskBar(5000, 'Getting Coke')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'softdrink', 2)
                TriggerEvent("inventory:removeItem", "hfcs", 1)
                FreezeEntityPosition(PlayerPedId(),false)
                ClearPedTasks(PlayerPedId())
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(PlayerPedId(),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You do not have enough Syrup! (Required Amount: 1)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("burgershot:register")
AddEventHandler("burgershot:register", function(registerID)
    local myJob = exports["np_handler"]:isPed("myJob")
    if myJob == "burger_shot" then
        local order = exports["np-keyboard"]:KeyboardInput({
            header = "Create Receipt",
            rows = {
                {
                    id = 0,
                    txt = "Amount"
                },
                {
                    id = 1,
                    txt = "Comment"
                }
            }
        })
        if order then
            TriggerServerEvent("burger_shot:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("burgershot:get:receipt")
AddEventHandler("burgershot:get:receipt", function(registerid)
    TriggerServerEvent('burgershot:retreive:receipt', registerid)
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

AddEventHandler("burger:shot:meals", function()
    local myJob = exports["np_handler"]:isPed("myJob")
    if myJob == "burger_shot" then
        remoteCalls.execute("burger_shot:pick:meal")
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("knockoutmeal:meal", function(data)
    local finished = exports["np-taskbar"]:taskBar(10000,"Grabbing Meal")
    if (finished == 100) then
        TriggerEvent("DoLongHudText", "Meal Grabbed!")
        TriggerEvent("player:receiveItem", "knockoutmeal", 1)   
    end
end)

RegisterNetEvent("oneshotmeal:meal", function(data)
    local finished = exports["np-taskbar"]:taskBar(10000,"Grabbing Meal")
    if (finished == 100) then
        TriggerEvent("DoLongHudText", "Meal Grabbed!")
        TriggerEvent("player:receiveItem", "oneshotmeal", 1)   
    end
end)

RegisterNetEvent("bleedingmeal:meal", function(data)
    local finished = exports["np-taskbar"]:taskBar(10000,"Grabbing Meal")
    if (finished == 100) then
        TriggerEvent("DoLongHudText", "Meal Grabbed!")
        TriggerEvent("player:receiveItem", "bleedingmeal", 1)   
    end
end)