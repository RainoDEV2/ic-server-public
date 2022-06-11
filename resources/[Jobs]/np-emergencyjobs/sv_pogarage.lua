local activepolice = 0
local activeEMS = 0

RegisterServerEvent('attemptduty')
AddEventHandler('attemptduty', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
	local jobs = exports["np-fw"]:getModule("JobManager")
	local character = user:getCurrentCharacter()
	local job = pJobType and pJobType or 'police'
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
	jobs:SetJob(user, job, false, function()
		TriggerClientEvent('nowCopGarage', src)
		TriggerClientEvent("DoLongHudText", src, "10-41 and Restocked.", 17)
		TriggerEvent('np-eblips:server:registerPlayerBlipGroup', src, 'police')
		TriggerEvent('np-eblips:server:registerSourceName', src, result[1].callsign .." | ".. character.first_name .." ".. character.last_name)
		TriggerClientEvent("startSpeedo",src)
		activepolice = activepolice + 1
		print(activepolice)
		    CountUpdater("add", "police")
	    end)
	end)
end)

RegisterServerEvent("police:officerOffDuty")
AddEventHandler("police:officerOffDuty", function()
	local src = source
	-- if activepolice > 1 then
	-- 	activepolice = activepolice - 1
	-- else
	-- 	activepolice = 0
	-- end
	TriggerEvent('np-eblips:server:removePlayerBlipGroup', src, 'police')
	TriggerClientEvent("np-jobmanager:playerBecameJob", src, "unemployed", "unemployed", true)
	--CountUpdater("remove", "police")
end)

RegisterServerEvent('attemptdutym')
AddEventHandler('attemptdutym', function(src)
	if src == nil or src == 0 then src = source end
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-fw"]:getModule("JobManager")
	local job = pJobType and pJobType or 'ems'
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
	jobs:SetJob(user, job, false, function()
		TriggerEvent('np-eblips:server:registerPlayerBlipGroup', src, 'ems')
		TriggerEvent('np-eblips:server:registerSourceName', src, result[1].callsign .." | ".. character.first_name .." ".. character.last_name)
		TriggerClientEvent("DoLongHudText", src, "You are 10-41!",1 )	
		activeEMS = activeEMS + 1
		TriggerClientEvent("hasSignedOnEms", src)
			CountUpdater("add", "ems")
		end) 
	end)
end)

RegisterServerEvent("police:EMSOffDuty")
AddEventHandler("police:EMSOffDuty", function()
	local src = source
	if activeEMS > 1 then
		activeEMS = activeEMS - 1
	else
		activeEMS = 0
	end
	
	TriggerEvent('np-eblips:server:removePlayerBlipGroup', src, 'ems')
 	TriggerClientEvent("np-jobmanager:playerBecameJob", src, "unemployed", "unemployed", true)
	CountUpdater("remove", "ems")
end)

RegisterCommand("Counts", function(src, args, raw)
	CountUpdater("all")
end)

function CountUpdater(pType, pJob)
	if pType == "remove" then
		if pJob == "police" then
			print("^1 [" .. pJob .. "] | Removing | ^4New Count: " ..activepolice.. " ^0")
		elseif pJob == "ems" then
			print("^1 [" .. pJob .. "] | Removing | ^4New Count: " ..activeEMS.. " ^0")
		end
	elseif pType == "add" then
		if pJob == "police" then
			print("^1 [" .. pJob .. "] | Adding | ^4New Count: " ..activepolice.. " ^0")
		elseif pJob == "ems" then
			print("^1 [" .. pJob .. "] | Adding | ^4New Count: " ..activeEMS.. " ^0")
		end
	elseif pType == "all" then
		print("^1 Current Cops: ^4" ..activepolice.. "^0 | ^1Current EMS: ^4" ..activeEMS.."^0")
	end
end

exports("DisconnectJobUpdater", function(pJob)
	if pJob == "ems" then
		if activeEMS > 1 then
			activeEMS = activeEMS - 1
		else
			activeEMS = 0
			--TriggerEvent("ems:toggle", true)
		end
	elseif pJob == "police" then
		print(pJob)
		if activepolice > 1 then
			activepolice = activepolice - 1
		else
			activepolice = 0
		end
	end
	
	CountUpdater("remove", pJob)
end)

remoteCalls.register("iciest :counts", function(pJobCalling)
	if pJobCalling == "police" then
		return activepolice
	elseif pJobCalling == "ems" then
		return activeEMS
	end
end)