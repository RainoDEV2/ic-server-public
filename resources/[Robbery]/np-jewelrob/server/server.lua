local HasBeenHit = false
local hasUnlocked = false

jewelrob = {
  [1] = {
      state = true,
      event = "np-jewelrob:keypad",
      icon = "fas fa-keyboard",
      label = "Hack Keypad",
      distance = 1.5,
      coords = {x = -629.42, y = -230.49, z = 38.06, width = 0.6, height = 0.2, h = 35, minZ = 35.11, maxZ = 38.91}
  },
  [2] = {
    state = true,
    event = "np-request:depositbox",
    icon = "fas fa-box",
    label = "Crack Deposit box",
    distance = 1.5,
    coords = {x = -632.1, y = -229.16, z = 38.06, width = 0.6, height = 0.2, h = 305, minZ = 34.86, maxZ = 38.91}
  },
}

remoteCalls.register("np-jewelrob:recieveCoords", function()
  return jewelrob
end)

remoteCalls.register('np-jewlrob:unlockbox', function()
  local pSrc = source
		if hasUnlocked then 
			TriggerClientEvent('DoLongHudText', pSrc, 'This has already been hit recently', 2)
			return
		end
		hasUnlocked = true
    TriggerClientEvent("np-jewlrob:safecrack", pSrc)
end)

RegisterServerEvent("jewel:hasrobbed")
AddEventHandler("jewel:hasrobbed", function(num)
    hasrobbed[num] = true
    TriggerClientEvent("jewel:robbed",-1,hasrobbed)
end)

RegisterServerEvent("jewel:request")
AddEventHandler("jewel:request", function()
    local pSrc = source
    if not HasBeenHit then
        resetJewels()
        TriggerClientEvent("np-jewelrob:alert", pSrc)
        TriggerClientEvent("inventory:removeItem", pSrc, "Gruppe6Card3", 1)
        TriggerEvent("np-doors:changeLock-status", 122, false)
        TriggerEvent("np-doors:changeLock-status", 123, false)
        TriggerClientEvent("DoLongHudText", pSrc, "Doors Unlocked, good luck!", 15)
        HasBeenHit = true
    else
        TriggerClientEvent("DoLongHudText", pSrc, "There was just an incident here, they are still cleaning up!", 2)
    end
end)

RegisterServerEvent("jewel:request:relock")
AddEventHandler("jewel:request:relock", function()
    local pSrc = source
    TriggerClientEvent("player:receiveItem", pSrc, "rolexwatch",math.random(3,5))
    
	if math.random(7) == 1 then
		TriggerClientEvent("player:receiveItem", pSrc, "goldbar",math.random(3,5))
    end

    if math.random(2) == 1 then
		TriggerClientEvent("player:receiveItem", pSrc, "stolen8ctchain",math.random(1,5))
    end

    if math.random(3) == 1 then
		TriggerClientEvent("player:receiveItem", pSrc, "stolen10ctchain",math.random(1,5))
    end

    if math.random(2) == 1 then
		TriggerClientEvent("player:receiveItem", pSrc, "stolen2ctchain",math.random(1,5))
    end
end)

function resetJewels()
    hasrobbed = {}
    hasrobbed[1] = false
    hasrobbed[2] = false
    hasrobbed[3] = false
    hasrobbed[4] = false
    hasrobbed[5] = false
    hasrobbed[6] = false
    hasrobbed[7] = false
    hasrobbed[8] = false
    hasrobbed[9] = false
    hasrobbed[10] = false
    hasrobbed[11] = false
    hasrobbed[12] = false
    hasrobbed[13] = false
    hasrobbed[14] = false
    hasrobbed[15] = false
    hasrobbed[16] = false
    hasrobbed[17] = false
    hasrobbed[18] = false
    hasrobbed[19] = false
    hasrobbed[20] = false
    TriggerClientEvent("jewel:robbed", -1, hasrobbed)
end

-- RegisterCommand("cuck", function()
--   HasBeenHit = false
--   hasUnlocked = false
--   TriggerEvent("np-doors:changeLock-status", 122, true)
--   TriggerEvent("np-doors:changeLock-status", 123, true)
--   TriggerEvent("np-doors:changeLock-status", 124, true)
--   print("^1 " .. GetCurrentResourceName().. " Resetting Jewelry Store ^0")
-- end)

Citizen.CreateThread(function()
    while true do 
      Citizen.Wait(1800000) -- Clears every 30 mins
      HasBeenHit = false
      hasUnlocked = false
      TriggerEvent("np-doors:changeLock-status", 122, true)
      TriggerEvent("np-doors:changeLock-status", 123, true)
      TriggerEvent("np-doors:changeLock-status", 124, true)
		  print("^1 " .. GetCurrentResourceName().. " Resetting Jewelry Store ^0")
    end
end)