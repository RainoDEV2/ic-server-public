local NearJewel = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("jewel_store_spot", vector3(-602.73, -264.05, 52.31), 0.6, 2, {
        name="jewel_store_spot",
        heading=25,
        --debugPoly=true,
        minZ=51.31,
        maxZ=53.71
    })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "jewel_store_spot" then
        NearJewel = true
        JewelStoreShit()
        TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("[E] Swipe Card"))
    end
    CurrentRentalSpot = name
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "jewel_store_spot" then
        NearJewel = false
    end
    TriggerEvent('np-textui:HideUI')
    CurrentRentalSpot = nil
end)

function JewelStoreShit()
    Citizen.CreateThread(function()
        while NearJewel do
            Citizen.Wait(1)
            if IsControlJustPressed(0, 38) then
                if exports['np_handler']:isPed("countpolice") >= 5 then
                    if exports['np-inventory']:hasEnoughOfItem("Gruppe6Card3", 1, false) then
                        TriggerEvent("np-dispatch:jewelrobbery")
                        TriggerEvent("np-jewelrob:hack")
                    else
                        TriggerEvent("DoLongHudText", "Your missing something!", 2) 
                    end
                else
                    TriggerEvent("DoLongHudText", "Not enough officers to do this!", 2)
                end
            end
        end
    end)
end

RegisterNetEvent('np-jewelrob:hack')
AddEventHandler('np-jewelrob:hack', function()
    TriggerEvent('open:minigame', 20, 4, function(Success)
        minigameResult = Success
        if minigameResult then
            TriggerServerEvent("jewel:request")
        else
            TriggerEvent("DoLongHudText", "You Failed the Hack!", 2)  
            TriggerEvent("inventory:removeItem", "Gruppe6Card3", 1)  
            TriggerEvent("np-dispatch:jewelrobbery")
        end
    end)
end)