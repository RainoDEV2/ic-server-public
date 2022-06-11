RegisterNetEvent("np-weedstore:startpicking")
AddEventHandler("np-weedstore:startpicking", function()
    local myJob = exports["np_handler"]:isPed("myJob")
    if myJob == "best_buds" then
        if exports['np-inventory']:hasEnoughOfItem("purifiedwater", 1) and exports['np-inventory']:hasEnoughOfItem("plantpot", 1) and exports['np-inventory']:hasEnoughOfItem("fertilizer", 1) then
            local dict = 'missfinale_c2ig_11'
            LoadDict(dict)
            FreezeEntityPosition(PlayerPedId(),true)
            TaskPlayAnim(PlayerPedId(), dict, "pushcar_offcliff_f", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(PlayerPedId(), 355.69338989258)
            local finished = exports['np-taskbar']:taskBar(20000, 'Harvesting')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'smallbud', 6)
                TriggerEvent("inventory:removeItem", "purifiedwater", 1)
                TriggerEvent("inventory:removeItem", "plantpot", 1)
                TriggerEvent("inventory:removeItem", "fertilizer", 1)
                FreezeEntityPosition(PlayerPedId(),false)
                ClearPedTasks(PlayerPedId())
                Citizen.Wait(1000)
            end
            
        else
            TriggerEvent('DoLongHudText', 'You are missing an item', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You need a license', 2)
    end
end)

RegisterNetEvent("np-weedstore:startpacking")
AddEventHandler("np-weedstore:startpacking", function()
    local myJob = exports["np_handler"]:isPed("myJob")
    if myJob == "best_buds" then
        if exports['np-inventory']:hasEnoughOfItem("smallbud", 3) and exports['np-inventory']:hasEnoughOfItem("plastic", 1) then
            local dict = 'missfinale_c2ig_11'
            LoadDict(dict)
            FreezeEntityPosition(PlayerPedId(),true)
            TaskPlayAnim(PlayerPedId(), dict, "pushcar_offcliff_f", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(PlayerPedId(), 186.32456970215)
            local finished = exports['np-taskbar']:taskBar(20000, 'Packaging')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'weedq', 10)
                TriggerEvent("inventory:removeItem", "plastic", 1)
                TriggerEvent("inventory:removeItem", "smallbud", 3)
                FreezeEntityPosition(PlayerPedId(),false)
                ClearPedTasks(PlayerPedId())
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You are missing an item', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You need a license', 2)
    end
end)

RegisterNetEvent("Best_buds:register")
AddEventHandler("Best_buds:register", function(registerID)
    local myJob = exports["np_handler"]:isPed("myJob")
    if myJob == "best_buds" then
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
            TriggerServerEvent("Best_buds:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("Best_buds:get:receipt")
AddEventHandler("Best_buds:get:receipt", function(registerid)
    TriggerServerEvent('Best_buds:retreive:receipt', registerid)
end)