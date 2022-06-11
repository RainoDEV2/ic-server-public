AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local connecting = true
    local source = source
    local pSteam = 'None'
    local pDiscord = 'None'
    local pLicense = 'None'
    local pIdentifiers = GetPlayerIdentifiers(source)

    deferrals.defer()

    Citizen.CreateThread(function()
        while connecting do
            Citizen.Wait(100)
            if not connecting then return end
            deferrals.update('Your information is currently being proccessed, stand by.')
        end
    end)

    Citizen.Wait(250)

    if (not string.find(pIdentifiers[1], 'steam')) then
        connecting = false
        deferrals.done('\n\nIt doesn\'t look like you have steam open.\nPlease restart your FiveM client with steam open.')
        CancelEvent()
        return
    end
    
    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
        if string.find(v, 'license') then pLicense = v end
    end

    Citizen.Wait(100)
    exports.ghmattimysql:execute("SELECT * FROM user_bans WHERE steam_id = ?", {pSteam}, function(data)
        if data[1] then
            local reason = data[1].reason
            if reason == "" then
                reason = "No Reason Specified"
            end

            deferrals.done("You have been permanently banned | Reason: " .. string.upper(reason));
            CancelEvent()
            return
        end
    end)

    if (pSteam == 'None' or pDiscord == 'None' or pLicense == 'None') then
        connecting = false
        deferrals.done('\n\nFailed to find valid user indentifiers.\nPlease make sure that you have both Steam & the Discord App open')
        CancelEvent()
        return
    end


    pLogData = name.." is loading into the server"
    exports['np-fw']:k_log(source, "connection-accept", pLogData)

    Citizen.Wait(250)
    connecting = false
    deferrals.done()
end)

AddEventHandler('playerDropped', function(reason)
    local pSteam = 'None'
    local pDiscord = 'None'
    local pName = GetPlayerName(source)
    local pIdentifiers = GetPlayerIdentifiers(source)

    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v break end
    end

    pLogData = pName .. " exited | reason: " .. reason
    exports['np-fw']:k_log(source, "connection-exit", pLogData)
end)
