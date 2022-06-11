Bahamas = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {}
}

RegisterServerEvent('bahamas_bar:OrderComplete')
AddEventHandler("bahamas_bar:OrderComplete", function(regID, price, comment)
    local insert = {
        owner = source, 
        price = price, 
        comment = comment,
        regID = regID
    }
    Bahamas[regID] = {}
    table.insert(Bahamas[regID], insert)
end)

RegisterServerEvent("bahamas:retreive:receipt")
AddEventHandler("bahamas:retreive:receipt", function(regID)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if Bahamas[regID] then
        for i = 1, #Bahamas[regID] do
            if Bahamas[regID][i].regID == regID then
                local amount = Bahamas[regID][i].price
                if (tonumber(user:getCash()) >= tonumber(amount)) then
                    user:removeMoney(tonumber(amount))
                    local owner = exports["np-fw"]:getModule("Player"):GetUser(Bahamas[regID][i].owner)
                    local char = owner:getCurrentCharacter()
                    information = {
                        ["Price"] = tonumber(amount),
                        ["Creator"] = char.first_name .. " " ..char.last_name,
                        ["Comment"] = Bahamas[regID][i].comment
                    }

                    TriggerClientEvent("player:receiveItem", Bahamas[regID][i].owner, "ownerreceipt", 1, true, information)
                    TriggerClientEvent("player:receiveItem", src, "receipt", 1, true, {["Comment"] = "Thanks for your order at BahamasMama"})
                    TriggerEvent("bahamas_bar:update:registers", regID)
                else
                    TriggerClientEvent("DoLongHudText", src, "You cant afford this purchase")
                end
            end
        end
    else
        TriggerClientEvent("DoLongHudText", src, "Payment not ready..", 2)
    end
end) 

RegisterServerEvent("bahamas_bar:update:registers")
AddEventHandler("bahamas_bar:update:registers", function(regID)
    for k, v in pairs(Bahamas[regID]) do
        table.remove(Bahamas[regID], k)
    end
end)