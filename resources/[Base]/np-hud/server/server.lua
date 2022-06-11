
RegisterServerEvent('GPSTrack:Accepted')
AddEventHandler('GPSTrack:Accepted', function(x,y,z,stage)
	local srcid = source
	TriggerClientEvent("GPSTrack:Accepted",-1,x,y,z,srcid,stage)
end)

RegisterServerEvent('car:spotlight')
AddEventHandler('car:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('car:spotlight', -1, serverID, state)
end)

RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust", function(pTargetId, pType, pShouldRemove)
	TriggerClientEvent("facewear:adjust", pTargetId, pType, pShouldRemove)
end)

RegisterCommand("anchor", function(source, args, rawCommand)
    TriggerClientEvent('client:anchor', source)
end)

RegisterServerEvent("actionclose")
AddEventHandler("actionclose", function(string, Coords)
	TriggerClientEvent("Do3DText", -1, string, source, Coords)
end)

RegisterServerEvent('carfill:checkmoney')
AddEventHandler('carfill:checkmoney', function(costs)
	local src = source
	local player = exports["np-fw"]:getModule("Player"):GetUser(src)

	if player:getCash() >= costs then
		TriggerClientEvent("RefuelCarServerReturn", src)
		player:removeMoney(costs)
	else
		moneyleft = costs - player:getCash()
		TriggerClientEvent('DoLongHudText', src, "Requires $" .. costs)
	end
end)

RegisterServerEvent('server:alterStress')
AddEventHandler('server:alterStress',function(positive, alteredValue)
	local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	exports.ghmattimysql:execute("SELECT * FROM characters WHERE id = ?", {characterId}, function(result)
		local myStress = result[1].stress_level
		Citizen.Wait(500)
		if positive then
			if myStress < tonumber(10000) then
				newStress = myStress + alteredValue
				exports.ghmattimysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{newStress, characterId})
				TriggerClientEvent('client:updateStress', src, newStress)
			end
		else
			if myStress > tonumber(1000) then
				Stress = myStress - alteredValue
				exports.ghmattimysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{Stress, characterId})
				TriggerClientEvent('client:updateStress', src, Stress)
			end
		end
	end)
end)

RegisterServerEvent("police:update:hud")
AddEventHandler("police:update:hud", function(health, armour, thirst, hunger)
    local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	if user ~= false then
		meta = { 
			["health"] = health,
			["armour"] = armour,
			["thirst"] = thirst,
			["hunger"] = hunger
		}

		local encode = json.encode(meta)
		exports.ghmattimysql:execute('UPDATE characters SET metaData = ? WHERE id = ?', {encode, characterId})
	end
end)

RegisterServerEvent('police:SetMeta')
AddEventHandler('police:SetMeta', function()
    local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(result)
        TriggerClientEvent("police:setClientMeta", src, json.decode(result[1].metaData))
		TriggerClientEvent('client:updateStress', src, result[1].stress_level)
		TriggerClientEvent("np-hud:EnableHud", src)
	end)
end)

RegisterServerEvent('police:setEmoteData')
AddEventHandler('police:setEmoteData', function(emoteTable)
	local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	local emote = json.encode(emoteTable)
	exports.ghmattimysql:execute("UPDATE characters SET `emotes` = @emotes WHERE id = @cid", {['emotes'] = emote, ['cid'] = char.id})
end)

RegisterServerEvent('police:setAnimData')
AddEventHandler('police:setAnimData', function(AnimSet)
	local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	local metaData = json.encode(AnimSet)
	exports.ghmattimysql:execute("UPDATE characters SET `meta` = @metaData WHERE id = @cid", {['metaData'] = metaData, ['cid'] = char.id})
end)

RegisterServerEvent('police:getAnimData')
AddEventHandler('police:getAnimData', function()
	local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

	exports.ghmattimysql:execute("SELECT meta FROM characters WHERE id = @cid", {['cid'] = char.id}, function(result)
		if (result[1]) then
			if not result[1].meta then
				TriggerClientEvent('checkDNA', src)
			else
				local sex = json.decode(result[1].meta)
			if sex == nil then
				TriggerClientEvent('CheckDNA',src)
				return
			end
			TriggerClientEvent('emote:setAnimsFromDB', src, result[1].meta)
			end
		end
	end)
end)

RegisterServerEvent('police:getEmoteData')
AddEventHandler('police:getEmoteData', function()
	local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

	exports.ghmattimysql:execute("SELECT emotes FROM characters WHERE id = @cid", {['cid'] = char.id}, function(result)
		if(result[1]) then
			local emotes = json.decode(result[1].emotes)
			if result[1] ~= nil then
				TriggerClientEvent('emote:setEmotesFromDB', src,emotes)
			else
				local emoteTable = {
					{['key'] = {289},["anim"] = "Handsup"},
					{['key'] = {170},["anim"] = "HandsHead"},
					{['key'] = {166},["anim"] = "Drink"},
					{['key'] = {167},["anim"] = "Lean"},
					{['key'] = {168},["anim"] = "Smoke"},
					{['key'] = {56},["anim"] = "FacePalm"},
					{['key'] = {57},["anim"] = "Wave"},

					{['key'] = {289,21},["anim"] = "gangsign1"},
					{['key'] = {170,21},["anim"] = "gangsign3"},
					{['key'] = {166,21},["anim"] = "gangsign2"},
					{['key'] = {167,21},["anim"] = "hug"},
					{['key'] = {168,21},["anim"] = "Cop"},
					{['key'] = {56,21},["anim"] = "Medic"},
					{['key'] = {57,21},["anim"] = "Notepad"},
				}

				local emote = json.encode(emoteTable)
				exports.ghmattimysql:execute("UPDATE characters SET `emotes` = @emotes WHERE id = @cid", {['emotes'] = emote, ['identifier'] = char.id})
				TriggerClientEvent("emote:setEmotesFromDB", src, emoteTable)
			end
		end
	end)
end)