RegisterNetEvent("paytheuglytowpeople")
AddEventHandler("paytheuglytowpeople",function ()
    local amount = math.random(85,150)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    user:addMoney(amount)
end)