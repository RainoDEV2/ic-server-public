IRP.Core.hasLoaded = false


function IRP.Core.Initialize(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then
                TriggerEvent("np-fw:playerSessionStarted")
                TriggerServerEvent("np-fw:playerSessionStarted")
                break
            end
        end
    end)
end
IRP.Core:Initialize()

AddEventHandler("np-fw:playerSessionStarted", function()
    while not IRP.Core.hasLoaded do
        --print("waiting in loop")
        Wait(100)
    end
    ShutdownLoadingScreen()
    IRP.SpawnManager:Initialize()
end)

RegisterNetEvent("np-fw:waitForExports")
AddEventHandler("np-fw:waitForExports", function()
    if not IRP.Core.ExportsReady then return end

    while true do
        Citizen.Wait(0)
        if exports and exports["np-fw"] then
            TriggerEvent("np-fw:exportsReady")
            return
        end
    end
end)

RegisterNetEvent("customNotification")
AddEventHandler("customNotification", function(msg, length, type)
	TriggerEvent("chatMessage","SYSTEM", 4, msg)
end)

RegisterNetEvent("base:disableLoading")
AddEventHandler("base:disableLoading", function()
    if not IRP.Core.hasLoaded then
         IRP.Core.hasLoaded = true
    end
end)

Citizen.CreateThread( function()
    TriggerEvent("base:disableLoading")
end)

RegisterNetEvent('np-fw:characterLoaded')
AddEventHandler('np-fw:characterLoaded', function()
    Citizen.CreateThread(function()
        while true do
            Wait(15000)
            if IRP.Core.hasLoaded then
                local plyCoords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('np-fw:savecoords', json.encode(plyCoords))
            end
        end
    end)
end)

RegisterNetEvent("paycheck:client:call")
AddEventHandler("paycheck:client:call", function()
    local cid = exports["np_handler"]:isPed("cid")
    TriggerServerEvent("paycheck:server:send", cid)
end)
