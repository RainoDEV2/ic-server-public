bean = {
    [1] = {}
}

RegisterServerEvent('bean:OrderComplete')
AddEventHandler("bean:OrderComplete", function(regID, price, comment)
    local insert = {
        owner = source, 
        price = price, 
        comment = comment,
        regID = regID
    }
    bean[regID] = {}
    table.insert(bean[regID], insert)
end)

RegisterServerEvent("bean:retreive:receipt")
AddEventHandler("bean:retreive:receipt", function(regID)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if bean[regID] then
        for i = 1, #bean[regID] do
            if bean[regID][i].regID == regID then
                local amount = bean[regID][i].price
                if (tonumber(user:getCash()) >= tonumber(amount)) then
                    user:removeMoney(tonumber(amount))
                    local owner = exports["np-fw"]:getModule("Player"):GetUser(bean[regID][i].owner)
                    local char = owner:getCurrentCharacter()
                    information = {
                        ["Price"] = tonumber(amount),
                        ["Creator"] = char.first_name .. " " ..char.last_name,
                        ["Comment"] = bean[regID][i].comment
                    }

                    TriggerClientEvent("player:receiveItem", bean[regID][i].owner, "ownerreceipt", 1, true, information)
                    TriggerClientEvent("player:receiveItem", src, "receipt", 1, true, {["Comment"] = "Thanks for your order at Bean Machine"})
                    TriggerEvent("bean:update:registers", regID)
                else
                    TriggerClientEvent("DoLongHudText", src, "You cant afford this purchase")
                end
            end
        end
    else
        TriggerClientEvent("DoLongHudText", src, "Payment not ready..", 2)
    end
end) 

RegisterServerEvent("bean:update:registers")
AddEventHandler("bean:update:registers", function(regID)
    for k, v in pairs(bean[regID]) do
        table.remove(bean[regID], k)
    end
end)