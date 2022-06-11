remoteCalls.register("crack:givemoney", function()
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local player = GetPlayerName(pSrc)
    cash = math.random(195,265)
    user:addMoney(cash)
    if cash > 275 then
        exports['np-fw']:ShitWebHookShit("https://discord.com/api/webhooks/888637108888166485/4b5I3v_OG4siuLbgwdq5j0NokITLyVsZmyRMBusRcpCy0C3ZgfHq8lRcXzvCbNzNnfA-", "Crack Selling Logs", "Player ID: ".. pSrc ..", Steam: ".. player ..",  Just Received $".. cash .." From Selling Crack.", true, pSrc)
    end
end)