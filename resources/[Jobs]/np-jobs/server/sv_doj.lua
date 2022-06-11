local locked = false

RegisterServerEvent('lock:update')
AddEventHandler('lock:update', function(lock)
    locked = lock
    TriggerClientEvent('locked', -1, locked)
end)

RegisterServerEvent('doj:bill:player')
AddEventHandler("doj:bill:player", function(TargetID, amount)
	local src = source
	local target = tonumber(TargetID)
	local fine = tonumber(amount)
	local user = exports["np-fw"]:getModule("Player"):GetUser(target)
	local characterId = user:getCurrentCharacter().id
	if user ~= false then
		if fine > 0 then
			user:removeBank(fine)
			TriggerClientEvent('DoLongHudText', target, "You have been billed for $"..fine, 1)
			TriggerClientEvent('DoLongHudText', src, "You have successfully wrote a bill for $"..fine, 1)
			exports["np-banking"]:UpdateSociety(fine, "judge", "add")
		end
	end
end)