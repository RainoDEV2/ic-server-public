RegisterServerEvent('np-login:disconnectPlayer')
AddEventHandler('np-login:disconnectPlayer', function()
    local src = source
    DropPlayer(src, "You have been disconnected from the server")
end)

RegisterServerEvent("np-login:licenses")
AddEventHandler("np-login:licenses", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    exports.ghmattimysql:execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {['@type'] = "Firearm",['@owner'] = char.id})
    exports.ghmattimysql:execute("INSERT INTO user_licenses (type, owner, status) VALUES (@type, @owner, @status)", {['@type'] = "Driver", ['@owner'] = char.id, ['@status'] = "1"})
    exports.ghmattimysql:execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {['@type'] = "Hunting",['@owner'] = char.id})
    TriggerClientEvent("player:receiveItem", src, "backpack", 1)
end)
