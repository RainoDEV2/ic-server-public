Best_buds = {
    [1] = {},
    [2] = {}
}

RegisterServerEvent('Best_buds:OrderComplete')
AddEventHandler("Best_buds:OrderComplete", function(regID, price, comment)
    local insert = {
        owner = source, 
        price = price, 
        comment = comment,
        regID = regID
    }
    Best_buds[regID] = {}
    table.insert(Best_buds[regID], insert)
end)

RegisterServerEvent("Best_buds:retreive:receipt")
AddEventHandler("Best_buds:retreive:receipt", function(regID)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if Best_buds[regID] then
        for i = 1, #Best_buds[regID] do
            if Best_buds[regID][i].regID == regID then
                local amount = Best_buds[regID][i].price
                if (tonumber(user:getCash()) >= tonumber(amount)) then
                    user:removeMoney(tonumber(amount))
                    local owner = exports["np-fw"]:getModule("Player"):GetUser(Best_buds[regID][i].owner)
                    local char = owner:getCurrentCharacter()
                    information = {
                        ["Price"] = tonumber(amount),
                        ["Creator"] = char.first_name .. " " ..char.last_name,
                        ["Comment"] = Best_buds[regID][i].comment
                    }

                    TriggerClientEvent("player:receiveItem", Best_buds[regID][i].owner, "ownerreceipt", 1, true, information)
                    TriggerClientEvent("player:receiveItem", src, "receipt", 1, true, {["Comment"] = "Thanks for your order at Best Buds"})
                    TriggerEvent("Best_buds:update:registers", regID)
                else
                    TriggerClientEvent("DoLongHudText", src, "You cant afford this purchase")
                end
            end
        end
    else
        TriggerClientEvent("DoLongHudText", src, "Payment not ready..", 2)
    end
end) 

RegisterServerEvent("Best_buds:update:registers")
AddEventHandler("Best_buds:update:registers", function(regID)
    for k, v in pairs(Best_buds[regID]) do
        table.remove(Best_buds[regID], k)
    end
end)