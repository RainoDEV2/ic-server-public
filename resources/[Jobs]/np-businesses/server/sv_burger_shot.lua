Registers = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {}
}

RegisterServerEvent('burger_shot:OrderComplete')
AddEventHandler("burger_shot:OrderComplete", function(regID, price, comment)
    local insert = {
        owner = source, 
        price = price, 
        comment = comment,
        regID = regID
    }
    Registers[regID] = {}
    table.insert(Registers[regID], insert)
end)

RegisterServerEvent("burgershot:retreive:receipt")
AddEventHandler("burgershot:retreive:receipt", function(regID)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if Registers[regID] then
        for i = 1, #Registers[regID] do
            if Registers[regID][i].regID == regID then
                local amount = Registers[regID][i].price
                if (tonumber(user:getCash()) >= tonumber(amount)) then
                    user:removeMoney(tonumber(amount))
                    local owner = exports["np-fw"]:getModule("Player"):GetUser(Registers[regID][i].owner)
                    local char = owner:getCurrentCharacter()
                    information = {
                        ["Price"] = tonumber(amount),
                        ["Creator"] = char.first_name .. " " ..char.last_name,
                        ["Comment"] = Registers[regID][i].comment
                    }

                    TriggerClientEvent("player:receiveItem", Registers[regID][i].owner, "ownerreceipt", 1, true, information)
                    TriggerClientEvent("player:receiveItem", src, "receipt", 1, true, {["Comment"] = "Thanks for your order at Burger Shot"})
                    TriggerEvent("burger_shot:update:registers", regID)
                else
                    TriggerClientEvent("DoLongHudText", src, "You cant afford this purchase")
                end
            end
        end
    else
        TriggerClientEvent("DoLongHudText", src, "Payment not ready..", 2)
    end
end) 

RegisterServerEvent("burger_shot:update:registers")
AddEventHandler("burger_shot:update:registers", function(regID)
    for k, v in pairs(Registers[regID]) do
        table.remove(Registers[regID], k)
    end
end)

remoteCalls.register("burger_shot:pick:meal", function()
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    TriggerClientEvent('np-context:sendMenu', pSrc, {
        {
            id = 1,
            header = "Knockout Meal",
            txt = "1x King Creed Knockout | 1x Fries | 1x Kel Soda",
            params = {
                event = "knockoutmeal:meal",
                args = {
                    pMealName = "knockoutmeal",
                }
            }
        },

        {
            id = 2,
            header = "Bleeding Tasty Meal",
            txt = "1x Money Shot | 1x Fries | 1x Kel Soda",
            params = {
                event = "bleedingmeal:meal",
                args = {
                    pMealName = "bleedingmeal",
                }
            }
        },


        {
            id = 3,
            header = "One Shot Meal",
            txt = "1x The Bleeder | 1x Fries | 1x Kel Soda",
            params = {
                event = "oneshotmeal:meal",
                args = {
                    pMealName = "oneshotmeal",
                }
            }
        },
    })
end)

RegisterServerEvent("knockoutmeal:give:items")
AddEventHandler("knockoutmeal:give:items", function()
    local src = source
    TriggerClientEvent("player:receiveItem", src, "heartstopper", 1)
    TriggerClientEvent("player:receiveItem", src, "fries", 1)
    TriggerClientEvent("player:receiveItem", src, "softdrink", 1)
    TriggerClientEvent("player:receiveItem", src, "donut", 1)
end)

RegisterServerEvent("bleedingmeal:give:items1")
AddEventHandler("bleedingmeal:give:items1", function()
    local src = source
    TriggerClientEvent("player:receiveItem", src, "bleederburger", 1)
    TriggerClientEvent("player:receiveItem", src, "fries", 1)
    TriggerClientEvent("player:receiveItem", src, "softdrink", 1)
    TriggerClientEvent("player:receiveItem", src, "donut", 1)
end)

RegisterServerEvent("oneshotmeal:give:items")
AddEventHandler("oneshotmeal:give:items", function()
    local src = source
    TriggerClientEvent("player:receiveItem", src, "moneyshot", 1)
    TriggerClientEvent("player:receiveItem", src, "fries", 1)
    TriggerClientEvent("player:receiveItem", src, "softdrink", 1)
    TriggerClientEvent("player:receiveItem", src, "donut", 1)
end)

remoteCalls.register("np-businesses:addcash", function(pAmount)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    if not pAmount then
        return
    end
    user:addMoney(pAmount)
end)