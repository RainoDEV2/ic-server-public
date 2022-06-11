RegisterServerEvent('np-fish:process')
AddEventHandler('np-fish:process', function()
 local source = tonumber(source)
 TriggerClientEvent("player:receiveItem", source, "sushiroll", 2)
end)

RegisterServerEvent('np-fish:processcod')
AddEventHandler('np-fish:processcod', function()
 local source = tonumber(source)
 TriggerClientEvent("player:receiveItem", source, "sushicod", 2)
end)

RegisterServerEvent('np-fish:processperch')
AddEventHandler('np-fish:processperch', function()
 local source = tonumber(source)
 TriggerClientEvent("player:receiveItem", source, "perchsushi", 2)
end)

RegisterServerEvent('np-fish:cut')
AddEventHandler('np-fish:cut', function()
 local source = tonumber(source)
 TriggerClientEvent("player:receiveItem", source, "cutfish", 2)
end)

RegisterServerEvent('np-fish:cutcod')
AddEventHandler('np-fish:cutcod', function()
 local source = tonumber(source)
 TriggerClientEvent("player:receiveItem", source, "cutcod", 2)
end)

RegisterServerEvent('np-fish:cutperch')
AddEventHandler('np-fish:cutperch', function()
 local source = tonumber(source)
 TriggerClientEvent("player:receiveItem", source, "cutperch", 2)
end)

RegisterServerEvent('np-fish:sellSushi')
AddEventHandler('np-fish:sellSushi', function(money)
    local pSrc = source
    local player = GetPlayerName(pSrc)
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    if money ~= nil then
        user:addMoney(money)
        if money > 60 then
          exports['np-fw']:ShitWebHookShit("https://discord.com/api/webhooks/888637108888166485/4b5I3v_OG4siuLbgwdq5j0NokITLyVsZmyRMBusRcpCy0C3ZgfHq8lRcXzvCbNzNnfA-", "Fish Selling Logs", "Player ID: ".. pSrc ..", Steam: ".. player ..",  Just Received $".. money .." From Selling Fish..", true, pSrc)
    	end
	 end
end)