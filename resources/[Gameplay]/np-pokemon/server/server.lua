remoteCalls.register("yourdadisafatneek", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    if (tonumber(user:getCash()) >= 1000) then
        user:removeMoney(1000)
        TriggerClientEvent("player:receiveItem", src, "shiningpack",1)
    else
        TriggerClientEvent("DoLongHudText", src, "You too broke for this", 2)
    end
end)

remoteCalls.register("yourmumisfatneek", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    if (tonumber(user:getCash()) >= 2000) then
        user:removeMoney(2000)
        TriggerClientEvent("player:receiveItem", src, "shiningpack",2)
    else
        TriggerClientEvent("DoLongHudText", src, "You too broke for this", 2)
    end
end)

remoteCalls.register("yoursisterisfatneek", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    if (tonumber(user:getCash()) >= 3000) then
        user:removeMoney(3000)
        TriggerClientEvent("player:receiveItem", src, "shiningpack",3)
    else
        TriggerClientEvent("DoLongHudText", src, "You too broke for this", 2)
    end
end)

remoteCalls.register("stepsisisbangingyournan", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    if (tonumber(user:getCash()) >= 500) then
        user:removeMoney(500)
        TriggerClientEvent("player:receiveItem", src, "cardbinder",1)
    else
        TriggerClientEvent("DoLongHudText", src, "You too broke for this", 2)
    end
end)