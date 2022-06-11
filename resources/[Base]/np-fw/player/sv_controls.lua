RegisterServerEvent("np-fw:sv:player_control_set")
AddEventHandler("np-fw:sv:player_control_set", function(controlsTable)
    local src = source
    IRP.DB:UpdateControls(src, controlsTable, function(UpdateControls, err)
            if UpdateControls then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("np-fw:sv:player_controls")
AddEventHandler("np-fw:sv:player_controls", function()
    local src = source
    IRP.DB:GetControls(src, function(loadedControls, err)
        if loadedControls ~= nil then 
            TriggerClientEvent("np-fw:cl:player_control", src, loadedControls)
        else 
            TriggerClientEvent("np-fw:cl:player_control",src, nil)
        end
    end)
end)
