RegisterServerEvent('iciest :Bank:Deposit')
AddEventHandler('iciest :Bank:Deposit', function(account, amount, note, fSteamID)
    local source = source
    -- local xPlayer = ESX.GetPlayerFromId(source)
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)
    local char = user:getCurrentCharacter()
    local pSteam = GetPlayerName(source)
    if(not source or source == -1) then
        return
    end

    if(not amount or tonumber(amount) <= 0) then
        TriggerClientEvent("iciest :Bank:Notify", source, "error", "Invalid Amount!")
        return
    end

    amount = tonumber(amount)
    if(math.floor(amount) > user:getCash()) then
        TriggerClientEvent("iciest :Bank:Notify", source, "error", "You can't afford this!")
        return
    end

    if(account == "personal") then
        local amt = math.floor(amount)

        user:removeMoney(amt)
        Wait(500)
        user:addBank(amt)
        RefreshTransactions(source)
        TriggerClientEvent("iciest :Bank:Notify", source, "info", "You have deposited $"..format_int(amount))
        TriggerEvent("iciest :AddToMoneyLog", source, "personal", amount, "deposit", "N/A", (note ~= "" and note or "Deposited $"..format_int(amount).." cash."))
        TriggerClientEvent("iciest :Bank:RefreshAccounts", source)
        Citizen.Wait(500)
        TriggerClientEvent('isPed:UpdateCash', source, user:getCash())


        pLogData = pSteam .. " Deposited $"..amount .. " [Personal Account]"
        exports['np-fw']:k_log(source, "deposit", pLogData)
        return
    end

    if(account == "business") then     
        exports.ghmattimysql:execute("SELECT `pass_type` FROM character_passes WHERE cid= ? AND rank >= 4", {char.id}, function(data)
            if data[1] then
                pbussinessName = data[1].pass_type
                user:removeMoney(amount)
                Wait(500)   
                exports['np-banking']:UpdateSociety(amount, pbussinessName, "add")
                TriggerClientEvent("iciest :Bank:Notify", source, "info", "You have deposited $"..format_int(amount).." into ".. pbussinessName.."'s business account.")
                TriggerEvent("iciest :AddToMoneyLog", source, "business", amount, "deposit", pbussinessName, (note ~= "" and note or "Deposited $"..format_int(amount).." cash into ".. pbussinessName .."'s business account."))
                TriggerClientEvent("iciest :Bank:RefreshAccounts", source)

                pLogData = pSteam .. " Deposited $"..amount .. " [Business Account: " .. pbussinessName .. "]"
                exports['np-fw']:k_log(source, "deposit", pLogData)

                
            end
        end)
    end
end)