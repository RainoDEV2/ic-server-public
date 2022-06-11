RegisterServerEvent('iciest :Bank:Withdraw')
AddEventHandler('iciest :Bank:Withdraw', function(account, amount, note, fSteamID)
    local source = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)
    local char = user:getCurrentCharacter()
    local pName = char.first_name .. " " .. char.last_name
    local pSteam = GetPlayerName(source)
    if(not amount or tonumber(amount) <= 0) then
        TriggerClientEvent("iciest :Bank:Notify", source, "error", "Invalid amount!")
        return
    end

    amount = tonumber(amount)

    if(account == "personal") then
        if(amount > user:getBalance()) then
            TriggerClientEvent("iciest :Bank:Notify", source, "error", "Your bank doesn't have this much money!")
            return
        end

        user:addMoney(math.floor(amount))
        user:removeBank(math.floor(amount))
        RefreshTransactions(source)
        TriggerClientEvent("iciest :Bank:Notify", source, "info", "You have withdrew $"..format_int(amount))
        TriggerEvent("iciest :AddToMoneyLog", source, "personal", -amount, "withdraw", "N/A", (note ~= "" and note or "Withdrew $"..format_int(amount).." cash."))
        TriggerClientEvent("iciest :Bank:RefreshAccounts", source)
        Citizen.Wait(500)
        TriggerClientEvent('isPed:UpdateCash', source, user:getCash())

        pLogData = pSteam .. " Withdrew $"..amount .. " [Personal Account]"
        exports['np-fw']:k_log(source, "withdraw", pLogData)
    end

    if(account == "business") then     
        exports.ghmattimysql:execute("SELECT `pass_type` FROM character_passes WHERE cid= ? AND rank >= 4", {char.id}, function(data)
            if data[1] then
                pbussinessName = data[1].pass_type
                exports['np-banking']:UpdateSociety(amount, pbussinessName, "remove")
                user:addMoney(amount)

                TriggerClientEvent("iciest :Bank:Notify", source, "info", "You have withdrew $"..format_int(amount).." from ".. pbussinessName.."'s business account.")
                TriggerEvent("iciest :AddToMoneyLog", source, "business", -amount, "deposit", pbussinessName, (note ~= "" and note or "Withdrew $"..format_int(amount).." from ".. pbussinessName .."'s business account."))
                TriggerClientEvent("iciest :Bank:RefreshAccounts", source)
            end
        end)
        pLogData = pSteam .. " Withdrew $"..amount .. " [Business Account: " .. pbussinessName .. "]"
        exports['np-fw']:k_log(source, "withdraw", pLogData)

    end
end)