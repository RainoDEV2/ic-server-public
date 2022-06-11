RegisterServerEvent('np-badge:server:useitem')
AddEventHandler('np-badge:server:useitem', function(FUCKFEST)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	local pData = json.decode(FUCKFEST)
	if pData ~= nil then
		exports.ghmattimysql:execute("SELECT `first_name`, `last_name` FROM characters WHERE id = @id", {['id'] = pData.cid}, function(pName)
			local name = pName[1].first_name .. " " ..pName[1].last_name
			exports.ghmattimysql:execute("SELECT `mugshot_url` FROM user_mdt WHERE char_id = @char_id", {['char_id'] = pData.cid}, function(result)
				local img = '0'
				if result[1] ~= nil then
					img = result[1].mugshot_url
				end

				TriggerClientEvent('np-badge:client:showbadge', -1, pSrc, img, "", name)
			end)
		end)
	end
end)

RegisterServerEvent("np-pdbadge:buy")
AddEventHandler("np-pdbadge:buy", function()
	local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	information = {
		["cid"] = char.id,
	}

	TriggerClientEvent("player:receiveItem", src, "pd_badge", 1, true, information)
end)