remoteCalls.register("np-winery:washmoney", function()
    local pSrc = source 
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    user:addMoney(300)
end)