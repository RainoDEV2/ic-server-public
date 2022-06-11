local robberyBusy = false
local timeOut = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60 * 30) -- 30 mins reset
        print("^1 Resetting all Banks Security's^0")
        TriggerClientEvent("np-robbery:client:enableAllBankSecurity", -1)
    end
end)

RegisterServerEvent('np-robbery:server:setBankState')
AddEventHandler('np-robbery:server:setBankState', function(bankId, state)
    if bankId == "pacific" then
        if not robberyBusy then
            Config.BigBanks["pacific"]["isOpened"] = state
            TriggerClientEvent('np-robbery:client:setBankState', -1, bankId, state)
            TriggerEvent('np-robbery:server:setTimeout')
        end
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('np-robbery:client:setBankState', -1, bankId, state)
            TriggerEvent('np-robbery:server:SetSmallbankTimeout', bankId)
        end
    end
    robberyBusy = true
end)


RegisterServerEvent('np-robbery:server:setBankStatelockers')
AddEventHandler('np-robbery:server:setBankStatelockers', function(index)
    for i = 1, #Config.SmallBanks[index]["lockers"] do
        Config.SmallBanks[index]["lockers"][i]["isOpened"] = false
        Config.SmallBanks[index]["lockers"][i]["isBusy"]=  false
        TriggerClientEvent("robbery:get:config", -1, Config)
        print("hello config false")
    end
end)

RegisterServerEvent('np-robbery:server:setLockerState')
AddEventHandler('np-robbery:server:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "pacific" then	
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end

    TriggerClientEvent('np-robbery:client:setLockerState', -1, bankId, lockerId, state, bool)
end)

RegisterServerEvent("isRobberyActive", function()
    local pSrc = source
    TriggerClientEvent("isRobberyActive:fleeca", -1, robberyBusy)
end)

RegisterServerEvent("robbery:get:config", function()
    TriggerClientEvent("robbery:get:config", source, Config)
end)


RegisterServerEvent('np-robbery:server:setTimeout')
AddEventHandler('np-robbery:server:setTimeout', function()
    if not robberyBusy then
        if not timeOut then
            timeOut = true
            Citizen.CreateThread(function()
                Citizen.Wait(30 * (60 * 1000))
                timeOut = false
                robberyBusy = false

                for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                    Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                    Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
                end
			
                TriggerClientEvent('np-robbery:client:ClearTimeoutDoors', -1)
                Config.BigBanks["pacific"]["isOpened"] = false
            end)
        end
    end
end)

RegisterServerEvent('np-robbery:server:SetSmallbankTimeout')
AddEventHandler('np-robbery:server:SetSmallbankTimeout', function(BankId)
    if not robberyBusy then
        SetTimeout(30 * (30 * 1000), function()
            Config.SmallBanks[BankId]["isOpened"] = false
			
            for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
            end
			
            timeOut = false
            robberyBusy = false
            TriggerClientEvent('np-robbery:client:ResetFleecaLockers', -1, BankId)
            TriggerEvent('lh-banking:server:SetBankClosed', BankId, false)
        end)
    end
end)

RegisterServerEvent('np-robbery:server:SetStationStatus')
AddEventHandler('np-robbery:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerClientEvent("np-robbery:client:SetStationStatus", -1, key, isHit)
    if AllStationsHit() then
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        TriggerClientEvent("np-robbery:client:disableAllBankSecurity", -1)
    else
        CheckStationHits()
    end
end)
