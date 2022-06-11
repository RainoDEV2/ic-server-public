RegisterServerEvent("np-fw:sv:player_settings_set")
AddEventHandler("np-fw:sv:player_settings_set", function(settingsTable)
    local src = source
    IRP.DB:UpdateSettings(src, settingsTable, function(UpdateSettings, err)
            if UpdateSettings then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("np-fw:sv:player_settings")
AddEventHandler("np-fw:sv:player_settings", function()
    local src = source
    IRP.DB:GetSettings(src, function(loadedSettings, err)
        if loadedSettings ~= nil then 
            TriggerClientEvent("np-fw:cl:player_settings", src, loadedSettings)
        else 
            TriggerClientEvent("np-fw:cl:player_settings",src, nil)
        end
    end)
end)
