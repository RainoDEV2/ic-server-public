Citizen.CreateThread(function()
	if GetConvarInt('logs_enabled', 0) == 1 then
		print("^5[anti-cheat]^0 | ^2Running and logging all components^0")		
	else
		print("^5[anti-cheat]^0 | ^8Disabled | Dev Server ^0")	
	end
end)

function k_log(pSrc, LogType, LogInfo)
    if LogType == "Spawned:items" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/888638532921458708/kPIBS3Xxat1teKWIGEEkzuNUGz_rDpPCXC-faHCWg21GflxVcSgMeslvV5WQose2XW0K", pSrc, "Spawned Item -> with admin menu", "", LogInfo)
    elseif LogType == "Spawned:car" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/888638683924791317/UmjXbPQPD_tjJQcQ_c3grTz72t4luHsLH_i-mfuAC1zM88i6SE2UTxpDpZ7wTA1CXn2L", pSrc, "Spawned Car -> with admin menu", "", LogInfo)
    elseif LogType == "Spectating" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/862515235004612609/_yFa3AYJATwc9d2NQKsTuAsDUuT80sdWYJxMDnA8as2FmiRkf-01Als4QUOUy0js_a7u", pSrc, "Spectating Toggled -> with admin menu", "", LogInfo)
    elseif LogType == "Searching" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/862515324691152946/5EhBJhrsIPpvXXDFh_-pp0ZmYfUhiSMEOCxICKjcKBAhYIPRJPUMypMjKWYp7SBWOlBf", pSrc, "Searching Toggled -> with admin menu", "", LogInfo)
    elseif LogType == "connection-accept" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/864997336064983101/IneHY5BJUGZwYaLYgnxtCJoP65ZYcRrxQpIunxvRmYEkMeJIlGQPPDAG8nI7G1glQ2nJ", pSrc, "Connection Accepted", "", LogInfo)
    elseif LogType == "connection-exit" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/864998508284739595/TNveSHjVMGr-NCUlDL6UvhohW6rXzpPoKMZLWO0ve-00HZI8sR4bp45PewRX6j4Mly-u", pSrc, "Server Exit", "", LogInfo)
    elseif LogType == "deposit" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/864999880152973334/OkXY-fiUAAJBbBoA6M5bVC2OeP314ay3QkKMadXzdZ6gfYoMRWs4D8SmSmx7hWs442G_", pSrc, "Banking Deposit", "", LogInfo)
    elseif LogType == "withdraw" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/864999782859014164/Uf1O9jkVtEOHLvhmssDrq1dg-vDYdvV0tGH7d72gTh8SK3-MCnI4ORY3PNcZIQDPJenO", pSrc, "Banking Withdraw", "", LogInfo)
    elseif LogType == "transfer" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/864999980301549618/Aa55u4HvacCGoesAyxhD0U9JQ3UeFQChvH-DIhyJzpEUgt9yaUFIxWs_xj8Sga9ImPVp", pSrc, "Bank Transfer", "", LogInfo)
    elseif LogType == "give_cash" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/865000073457172541/uX126nM_kgpMDv_WOrb_kt9loYL5_RxkLSakZFUmAjZl0ZyNpb8f_XXZy9bpLfU3Q7-8", pSrc, "Give Cash", "", LogInfo)
    elseif LogType == "damage_multi" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/865000165672353792/47EP-KSHucATrcPxMGH7fAUtoEb9np2dji2necnr642YMOu-_TP09fXyW5ZlEFQqOCSG", pSrc, "Damage Modifier", "Cheating | Damage Modifier | Perma Banned", LogInfo)
    elseif LogType == "external-pay" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/865000260827742249/xFLHMUi94_sPRqUYIwjxZVdv_kM5sdILaR19SXTP_pagA-dCMj8IMntQRcywKLzHhXBE", pSrc, "Payment sent from phone - External Pay", "", LogInfo)
    elseif LogType == "external-deposit" then
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/888642186067984394/XkfQixsJqzykkTJPY9ork_lyauL2u_Iy-62GwBoGDg6PmzxQUH2ahH2yI7Jne-aT2RdB", pSrc, "Payment deposit from phone - External Deposit", "", LogInfo)
    end
end


function DiscordLog(wh, pSrc, reason, pBanReason, pLogData)
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    if user ~= false then
        hexId = user:getVar("hexid")
    else
        hexId = GetPlayerIdentifiers(pSrc)[1]
    end


    local pName = GetPlayerName(pSrc)
    local pDiscord = GetPlayerIdentifiers(pSrc)[3]
    
    pLogData = pLogData and tostring(pLogData) or "None"

    
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", reason, pSrc, hexId, pDiscord),
            ['color'] = 2317994,
            ['fields'] = {
                {
                    ['name'] = '`Additional Information`',
                    ['value'] = pLogData,
                    ['inline'] = false
                },
            },
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(wh, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	


    --- Drop Player for valid reasons
    if reason == "Cheater: Spawned Blacklisted Prop" or reason == "Triggering Events" or reason == "Damage Modifier" or reason == "Trigger-Event-Admin" or reason == "mass-spawn" then
        exports.ghmattimysql:execute('INSERT INTO user_bans (steam_id, discord_id, steam_name, reason, details) VALUES (@steam_id, @discord_id, @steam_name, @reason, @details)', {
            ['@steam_id'] = hexId,
            ['@discord_id'] = pDiscord,
            ['@steam_name'] = pName,
            ['@reason'] = pBanReason,
            ['@details'] = pLogData
        }, function()
        end)
    end
end

-- ##### EVENTS #####

RegisterServerEvent('player:damage:multi')
AddEventHandler('player:damage:multi',function(attacker, weapon, dmg)
    local aName = GetPlayerName(attacker)
    local pName = GetPlayerName(source)
    local pLogData = "Attacker's Steam Name: " ..  aName .. " | ID: " .. attacker .. "\n Damage Modifier: " .. dmg .. "\n Victim's Name: " ..pName.. "\n Weapon: " .. weapon
    exports['np-fw']:k_log(attacker, "damage_multi", pLogData)
    DropPlayer(attacker, "[np-anticheat] | Ban Reason: Damage Modifier")
end)


AddEventHandler('entityCreating', function(entity)
    if GetConvarInt('logs_enabled', 0) == 1 then
        local model = GetEntityModel(entity)
        local pOwner = NetworkGetEntityOwner(entity)
        for i=1, #blockedItems do 
            if model == GetHashKey(blockedItems[i]) then
                CancelEvent()
                local LogInfo = "Prop Hash: " .. model
                exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/865011614531715102/Mk2UsHV_L1pOaeRwlfV3UDlwP4yWg73Y_DMrPYSKPwytcWDCNVkmUYKp0PCzKNYyT1PH", pOwner, "Cheater: Spawned Blacklisted Prop", "Spawning Props", LogInfo)
                Citizen.Wait(100)
                DropPlayer(pOwner, "[Anti-Cheat]: You have been permanently banned.")
                break
            end
        end
    end
end)

RegisterServerEvent('player:dead')
AddEventHandler('player:dead',function(killer, DeathReason)
    if GetConvarInt('logs_enabled', 0) == 1 then
        local pSrc = source
        local pName = GetPlayerName(pSrc)
        local tName = GetPlayerName(killer)

        local LogInfo = pName .. " was killed by " .. tName .. "  | Type: " ..DeathReason
        exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/865011714752118785/dXI4XlQGTo4o8UV_nOc8VZzZFyhmRnSsZIEJLCTmgGi70fn12Kh80aSPWK4S1uoZTVQr", killer, "Combat Encounter", "", LogInfo)
    end
end)

RegisterServerEvent("np-fw:receiveItam")
AddEventHandler("np-fw:receiveItam", function(pCid, item_id, pAmount)
    local pSrc = source
    LogInfo = "Spawned Info |  Item: " ..item_id.. " / Amount: " .. pAmount
    exports['np-fw']:DiscordLog("https://discord.com/api/webhooks/865066774789750814/2Sv_7JBqXwKMLJU9FreOMrpIZUA6hotAPM0I5bz7LkJcXhQ2oKChMVCMl4FiqnSRTxNT", pSrc, "mass-spawn", "Mass Spawning Items", LogInfo)
    DropPlayer(pSrc, "[np-anticheat] | Banned | Reason: Better luck next time!")
    return
end)

-- Vehicle Blacklist
AddEventHandler('entityCreating', function(entity)
    local model = GetEntityModel(entity)
    local pOwner = NetworkGetEntityOwner(entity)
    for i=1, #BlacklistedModels do 
        if model == GetHashKey(BlacklistedModels[i]) then
            CancelEvent()
            break
        end
    end
end)

exports("ShitWebHookShit", function(pHook, pReasonForHook, pMessage, pBanPlayer, pSrc)
    local connect = {
        {
          ["color"] = 1,
          ["title"] = "**".. pReasonForHook .."**",
          ["description"] = pMessage,
        }
      }
    PerformHttpRequest(pHook, function(err, text, headers) end, 'POST', json.encode({username = "LOGS", embeds = connect, avatar_url = ""}), { ['Content-Type'] = 'application/json' })

    if pBanPlayer then
        local hexId = GetPlayerIdentifiers(pSrc)[1]
        local pName = GetPlayerName(pSrc)
        local pDiscord = GetPlayerIdentifiers(pSrc)[3]

        exports.ghmattimysql:execute('INSERT INTO user_bans (steam_id, discord_id, steam_name, reason, details) VALUES (@steam_id, @discord_id, @steam_name, @reason, @details)', {
            ['@steam_id'] = hexId,
            ['@discord_id'] = pDiscord,
            ['@steam_name'] = pName,
            ['@reason'] = "Spawning Money",
            ['@details'] = "Over exceeding triggers for receivnig money."
        }, function()
        end)


        DropPlayer(pSrc, "[np-anticheat] | Perma Banned | Reason: Spawning Money")
    end
end)

RegisterServerEvent('np-fw:charactercreate')
AddEventHandler('np-fw:charactercreate',function(firstname, lastname, dob, gender)
    local pSteam = 'None'
    local pDiscord = 'None'
    local pName = GetPlayerName(source)
    local pIdentifiers = GetPlayerIdentifiers(source)
    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end
    IRP.Logs:UserCreate(source, pName, pSteam, pDiscord, firstname, lastname, dob, gender)
end)

IRP.Logs = IRP.Logs or {}

IRP.Logs.WebHooksCreation = {
    ['Character'] = 'https://discord.com/api/webhooks/864996387771121738/aR1cghkj1q-JTXmupU9f08IZqBxPk7QFAxWyaXpW_tSt3TY63yrJ9nzyudH-lhVB-YwW'
}

IRP.Logs.UserCreate = function(self, uId, pName, pSteam, pDiscord, firstname, lastname, dob, gender)
    local embed = {
        {
            ['description'] = string.format("`User Profile Created.`\n\n`• User Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam: %s`\n\n`• Discord: %s`\n\n━━━━━━━━━━━━━━━━━━\n\n`• First Name: %s`\n\n`• Last Name: %s`\n\n`• Date of Birth: %s`\n\n`• Gender: %s`\n━━━━━━━━━━━━━━━━━━", uId, pSteam, pDiscord, firstname, lastname, dob, gender),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = pName
            }
        }
    }
    PerformHttpRequest(IRP.Logs.WebHooksCreation['Character'], function(err, text, headers) end, 'POST', json.encode({username = 'User Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end