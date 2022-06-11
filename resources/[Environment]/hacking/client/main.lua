AddEventHandler('open:minigame', function(time, slots, callback)
    Callbackk = callback
--    print('this is time and slots ' .. time .. ' ' .. slots)
    openHack(time, slots)
end)

RegisterNUICallback('callback', function(data, cb)
    closeHack()
    Callbackk(data.success)
    cb('ok')
end)

function openHack(timew, slots)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        time = timew,
        slot = slots,
    })
end

function closeHack()
    SetNuiFocus(false, false)
end