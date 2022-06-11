RegisterServerEvent("Fleeca:success:lockpick")
AddEventHandler("Fleeca:success:lockpick", function()
    local pSrc = source
    TriggerClientEvent('player:receiveItem', pSrc, 'cashstack', 2)
end)