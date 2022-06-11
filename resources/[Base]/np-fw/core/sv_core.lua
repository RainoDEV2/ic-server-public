function IRP.Core.ConsoleLog(self, msg, mod, ply)
	if not tostring(msg) then return end
	if not tostring(mod) then mod = "No Module" end

	local pMsg = string.format("^3[IRP LOG - %s]^7 %s", mod, msg)
	if not pMsg then return end

	if ply and tonumber(ply) then
		TriggerClientEvent("np-fw:consoleLog", ply, msg, mod)
	end
end

AddEventHandler("onResourceStart", function(resource)
	TriggerClientEvent("np-fw:waitForExports", -1)

	if not IRP.Core.ExportsReady then return end

	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(0)
			if IRP.Core.ExportsReady then
				TriggerEvent("np-fw:exportsReady")
				return
			else
			end
		end
	end)
end)

RegisterNetEvent("np-fw:playerSessionStarted")
AddEventHandler("np-fw:playerSessionStarted", function()

	local src = source
	local name = GetPlayerName(src)
	local user = IRP.Player:GetUser(src)
end)

AddEventHandler("np-fw:characterLoaded", function(user, char)
	local src = source
	local hexId = user:getVar("hexid")

	if char.phone_number == 0 then
		IRP.Core:CreatePhoneNumber(source, function(phonenumber, err)	
			local q = [[UPDATE characters SET phone_number = @phone WHERE owner = @owner and id = @cid]]
			local v = {
				["phone"] = phoneNumber,
				["owner"] = hexId,
				["cid"] = char.id
			}

			exports.ghmattimysql.execute(q, v, function()
				char.phone_number = char.phone_number
				user:setCharacter(char)
			end)
		end)
	end
end)



-- Paycheck shit
Citizen.CreateThread(function()
	while true do
		Citizen.Wait((60 * 1000) * 45) -- 45 mins
		TriggerClientEvent('paycheck:client:call', -1)
		print("^1[np-fw] Paychecks Sent^0")
	end
end)



RegisterServerEvent('paycheck:server:send')
AddEventHandler('paycheck:server:send', function(cid)
	local src = source
	local user = IRP.Player:GetUser(src)
	local job = GetCurrentJob(src)
	local wljob = user:getVar("job")
	if user ~= false then
		if job == "best_buds" or job == "burger_shot" or job == "bean_machine" or job == "vanilla_unicorn" or job == "bahamas_bar" or job == "weed_store" or job == "casino_dealer" or job == "news" or job == "winery" then -- Civ Jobs
			TriggerEvent("paycheck:server:add", src, cid, 300)
		elseif job == "tuner_shop" or job == "auto_exotics" or job == "harmony_autos" or job == "hayes_autos" then -- Mechanic Shops
			TriggerEvent("paycheck:server:add", src, cid, 300)
		elseif job == "car_shop" then -- Car Dealer Shops
			TriggerEvent("paycheck:server:add", src, cid, 300)
		elseif wljob == "police" or wljob == "ems" or wljob == "DOJ" then -- All Emergency Jobs
			TriggerEvent("paycheck:server:add", src, cid, 800)
		elseif job == "judge" then 
			TriggerEvent("paycheck:server:add", src, cid, 950)
		elseif job == "unemployed" or job == "drift_school" then -- Bum Jobs 
			TriggerEvent("paycheck:server:add", src, cid, 50)
		end
	end
end)

RegisterServerEvent('paycheck:server:add')
AddEventHandler('paycheck:server:add', function(srcID, cid, amount)
	exports.ghmattimysql:execute('SELECT `paycheck` FROM characters WHERE `id`= ?', {cid}, function(data)
		if data[1] ~= nil then
			local newAmount = data[1].paycheck + tonumber(amount)
			exports.ghmattimysql:execute("UPDATE characters SET `paycheck` = ? WHERE `id` = ?", {newAmount, cid})
			Citizen.Wait(500)
			TriggerClientEvent('DoLongHudText', srcID, 'A payslip of $'.. tonumber(amount) ..' making a total of $' ..newAmount ..' with $0 tax withheld on your last payment.', 1)
		end
	end)
end)

RegisterServerEvent("paycheck:collect")
AddEventHandler("paycheck:collect", function(cid)
	local src = source
	local user = IRP.Player:GetUser(src)
	exports.ghmattimysql:execute('SELECT `paycheck` FROM characters WHERE `id`= ?', {cid}, function(data)
		local amount = tonumber(data[1].paycheck)
		if amount >= 1 then
			exports.ghmattimysql:execute("UPDATE characters SET `paycheck` = ? WHERE `id` = ?", {"0", cid})
			user:addBank(amount)
		else
			TriggerClientEvent("DoLongHudText", src, "Your broke, go work!")
		end
	end)
end)

function GetCurrentJob(pSrc)
	local user = IRP.Player:GetUser(pSrc)
	local characterId = user:getVar("character").id
	local pFoundJob = "unemployed"
	exports.ghmattimysql:execute('SELECT `pass_type` FROM character_passes WHERE `cid`= ?', {characterId}, function(data)
		if data[1] ~= nil then
			pFoundJob = tostring(data[1].pass_type)
		end
	end)
	Citizen.Wait(100)
	return pFoundJob
end