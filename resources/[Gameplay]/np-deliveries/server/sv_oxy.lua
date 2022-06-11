RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)

	if user:getCash() >= money then
        user:removeMoney(money)

		TriggerClientEvent("oxydelivery:startDealing", source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough for this', 2)
	end
end)

RegisterServerEvent('mission:finished')
AddEventHandler('mission:finished', function(type, money)    
    local pSrc = source
    local player = GetPlayerName(source)
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)
    if money ~= nil then
        user:addMoney(money)
        if money > 15000 then
            exports['np-fw']:ShitWebHookShit("https://discord.com/api/webhooks/888637108888166485/4b5I3v_OG4siuLbgwdq5j0NokITLyVsZmyRMBusRcpCy0C3ZgfHq8lRcXzvCbNzNnfA-", "Oxy Logs", "Player ID: ".. pSrc ..", Steam: ".. player ..",  Just Received $".. money .." From Selling Oxy.", true, pSrc)
    	end
	end
end)

RegisterServerEvent('drugdelivery:server')
AddEventHandler('drugdelivery:server', function(money)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)

	if user:getCash() >= money then
        user:removeMoney(money)
		
		TriggerClientEvent("drugdelivery:startDealing", source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough money.', 2)
	end
end)

local counter = 0
RegisterServerEvent('delivery:status')
AddEventHandler('delivery:status', function(status)
    if status == -1 then
        counter = 0
    elseif status == 1 then
        counter = 2
    end
    TriggerClientEvent('delivery:deliverables', -1, counter, math.random(1,14))
end)



local activechop = {}
local newList = {}

function makenewlist()
    for i = 1, 5 do
        table.insert(newList, {["id"] = math.random(1, 118), ["rarity"] = math.random(1, 15), ["resolved"] = false})
    end
end

local timer = 60

function updatetimer()
    if timer > 0 then
        timer = timer - 1
        TriggerClientEvent("chop:CurrentCarList", -1, newList, timer)
    else
        newList = {}
        makenewlist()
        timer = 60
        TriggerClientEvent("chop:CurrentCarList", -1, newList, timer)
    end
end

RegisterServerEvent('request:chopshop')
AddEventHandler('request:chopshop', function()
    TriggerClientEvent("chop:CurrentCarList", -1, newList, timer)
end)

RegisterServerEvent('chopshop:removevehicle')
AddEventHandler('chopshop:removevehicle', function(vehicleid, plate, value)
    newList[vehicleid]["resolved"] = true
    TriggerClientEvent("chop:CurrentCarListRemove", -1, vehicleid)
    TriggerClientEvent("keys:remove", source, plate)
    TriggerClientEvent("payment:chopshopscrap", source, newList[vehicleid]["rarity"])
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    makenewlist()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        updatetimer()
    end
end)