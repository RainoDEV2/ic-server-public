Citizen.CreateThread(function()
    TriggerEvent("inv:playerSpawned");
end)

RegisterServerEvent("inventory:check:items")
AddEventHandler("inventory:check:items", function(item_id, creationDate)
    local pData = {
        ["itemid"] = item_id,
        ["creation"] = creationDate
    }

    TriggerEvent("inventory:scan", pData.itemid, pData.creation)
end)

RegisterServerEvent('np-inventory:logItem')
AddEventHandler('np-inventory:logItem', function(itemdata, amount)
    sendToDiscord123("Item Received", "**" .. GetPlayerName(source) .. "** has received an item. \n\n**Item ID : **" .. itemdata .. " \n\n**Amount : **" .. amount, 65280)
end)

function sendToDiscord123(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
              ["text"] = "",
              },
          }
      }
    PerformHttpRequest('https://discord.com/api/webhooks/888636540564156456/g2KNl5s33Xs6c3T_Vht4NvKDzW49FA6lTlAAzW3KK1bh3WT2CW33gn-vd-e_oLzaXGy3', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("inventory:del:shit")
AddEventHandler("inventory:del:shit", function(item_id, creationDate)
    exports.ghmattimysql:execute("DELETE FROM user_inventory2 WHERE item_id = @item_id AND creationDate = @creationDate", {['item_id'] = item_id, ['creationDate'] = creationDate})
end)


RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(target)
    local characterId = user:getVar("character").id
	TriggerClientEvent("server-inventory-open", source, "1", 'ply-'.. characterId)
end)

RegisterServerEvent('Stealtheybread')
AddEventHandler('Stealtheybread', function(target)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local targetply = exports["np-fw"]:getModule("Player"):GetUser(target)
    if (targetply:getCash() >= 1) then
        user:addMoney(targetply:getCash())
        targetply:removeMoney(targetply:getCash())
    end
end)

RegisterServerEvent('iciest :idcard')
AddEventHandler('iciest :idcard', function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    if (tonumber(user:getCash()) >= 50) then
        user:removeMoney(50)
        TriggerClientEvent('courthouse:idbuy', src)
    else
        TriggerClientEvent("DoLongHudText", src, "You need $50", 2)
    end
end)

RegisterServerEvent('cash:remove')
AddEventHandler('cash:remove', function(pSrc, amount)
    local user = exports["np-fw"]:getModule("Player"):GetUser(tonumber(pSrc))
	if (tonumber(user:getCash()) >= amount) then
		user:removeMoney(amount)
	end
end)

RegisterNetEvent('np-weapons:getAmmo')
AddEventHandler('np-weapons:getAmmo', function()
    local ammoTable = {}
    local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute("SELECT type, ammo FROM characters_weapons WHERE id = @id", {['id'] = char.id}, function(result)
        for i = 1, #result do
            if ammoTable["" .. result[i].type .. ""] == nil then
                ammoTable["" .. result[i].type .. ""] = {}
                ammoTable["" .. result[i].type .. ""]["ammo"] = result[i].ammo
                ammoTable["" .. result[i].type .. ""]["type"] = ""..result[i].type..""
            end
        end
        TriggerClientEvent('np-items:SetAmmo', src, ammoTable)
    end)
end)

RegisterNetEvent('np-weapons:updateAmmo')
AddEventHandler('np-weapons:updateAmmo', function(newammo,ammoType,ammoTable)
    local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT ammo FROM characters_weapons WHERE type = @type AND id = @identifier',{['@type'] = ammoType, ['@identifier'] = char.id}, function(result)
        if result[1] == nil then
            exports.ghmattimysql:execute('INSERT INTO characters_weapons (id, type, ammo) VALUES (@identifier, @type, @ammo)', {
                ['@identifier'] = char.id,
                ['@type'] = ammoType,
                ['@ammo'] = newammo
            }, function()
            end)
        else
            exports.ghmattimysql:execute('UPDATE characters_weapons SET ammo = @newammo WHERE type = @type AND ammo = @ammo AND id = @identifier', {
                ['@identifier'] = char.id,
                ['@type'] = ammoType,
                ['@ammo'] = result[1].ammo,
                ['@newammo'] = newammo
            }, function()
            end)
        end
    end)
end)

RegisterServerEvent("inventory:deg:item", function(pItem)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    local pInventoryName = "ply-"..char.id

    if not pItem then
        return
    end

    exports.ghmattimysql:execute('SELECT creationDate FROM user_inventory2 WHERE item_id = ? AND name = ?',{pItem, pInventoryName}, function(data)
        if data[1] ~= nil then
            local pOldCreation = data[1].creationDate
            exports.ghmattimysql:execute('UPDATE user_inventory2 SET creationDate = @cd WHERE name = @name', {
                ['@name'] = pInventoryName,
                ['@cd'] = pOldCreation - 5000000
            }, function()
            end)
        else
            return                          
        end
    end)
end)