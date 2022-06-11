

RegisterServerEvent('iciest :infinity:player:ready')
AddEventHandler('iciest :infinity:player:ready', function()
    local ting = GetEntityCoords(GetPlayerPed(source))
    
    TriggerClientEvent('iciest :infinity:player:coords', -1, ting)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        local ting = GetEntityCoords(source)

        TriggerClientEvent('iciest :infinity:player:coords', -1, ting)
        TriggerEvent("np-fw:updatecoords", ting.x, ting.y, ting.z)
       -- print("[^2np-infinity^0]^3 Sync Successful.^0")
    end
end)