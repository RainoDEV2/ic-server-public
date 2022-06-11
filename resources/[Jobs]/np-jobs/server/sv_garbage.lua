RegisterServerEvent('np-garbage:pay')
AddEventHandler('np-garbage:pay', function(money)
    local pSrc = source
    local player = GetPlayerName(pSrc)
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    if money ~= nil then
        user:addMoney(money)
        if money > 499 then
          exports['np-fw']:ShitWebHookShit("https://discord.com/api/webhooks/888637108888166485/4b5I3v_OG4siuLbgwdq5j0NokITLyVsZmyRMBusRcpCy0C3ZgfHq8lRcXzvCbNzNnfA-", "Garbage Run Log", "Player ID: ".. pSrc ..", Steam: ".. player ..",  Just Received $".. money .." From Garbage.", true, pSrc)
    	end
	 end
end)

RegisterNetEvent('np-garbage:reward')
AddEventHandler('np-garbage:reward', function(item,rewardStatus)
    local _source = source
    if rewardStatus then
        TriggerClientEvent('DoShortHudText', _source, 'You found ' ..item, 2)
        TriggerClientEvent('player:receiveItem', _source, item, 1)
    end
end)