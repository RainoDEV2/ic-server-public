RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args)
    cb('ok')
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)

    -- Events that are required to do smothing on menu close!
    TriggerEvent('garges:force:clear')
    exports['np-garages']:DeleteViewedCar()


    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
end)


RegisterNetEvent('np-context:sendMenu', function(data)
    if not data then return end
    print(json.encode(data))
    SetNuiFocus(true, true)
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)

RegisterNetEvent('np-context:closemenu', function()
    SetNuiFocus(false, false)
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SendNUIMessage({
        action = "CLOSE_MENU",
        data = data
    })
end)