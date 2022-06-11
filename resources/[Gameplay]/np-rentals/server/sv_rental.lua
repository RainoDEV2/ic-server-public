RegisterServerEvent("rental:open:sv", function()
    local pSrc = source
    TriggerClientEvent('np-context:sendMenu', pSrc, {
        {
            id = 1,
            header = "Rental Menu",
            txt = "See whats available to rent!",
            params = {
                event = "open:rental:cl"
            }
        },

        {
            id = 2,
            header = "Return Rental Vehicle",
            txt = "Return the vehicle you rented!",
            params = {
                event = "rental:attempt:return"
            }
        }
    })
end)

remoteCalls.register("rental:attempt", function(price)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    if (user:getCash() >= price) then
        user:removeMoney(price)
        TriggerClientEvent("DoLongHudText", pSrc, "Vehicle rented, look for it in the parking lot!", 1)
        pPassed = true
    else
        TriggerClientEvent("DoLongHudText", pSrc, "You cant afford the rental price of $"..price, 2)
        pPassed = false
    end
    
    Citizen.Wait(100)
    return pPassed
end)


RegisterServerEvent("rental:return", function(pRentalCarPrice)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    user:addMoney(pRentalCarPrice/2)
    TriggerClientEvent("DoLongHudText", pSrc, "Thanks for returning the rental vehicle!", 1)
end)

remoteCalls.register("rental:give:papers", function(price, plate)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()


    information = {
        ["Price"] = tonumber(price),
        ["Creator"] = char.first_name .. " " ..char.last_name,
        ["Comment"] = "Rented Vehicle Plate: " ..plate
    } 
    
    TriggerClientEvent("player:receiveItem", pSrc, "rentalpaper", 1, true, information)
end)