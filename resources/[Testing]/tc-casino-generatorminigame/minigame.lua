RegisterNUICallback('callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    cb('ok')
end)

function OpenHackingGame(speed, callback)
    Callbackk = callback
	SetNuiFocus(true, true)
	SendNUIMessage({
        action = "openminigame",
        speed = speed
    })
end

-- example using

--[[exports['np-casino-generatorminigame']:OpenHackingGame(function(success)
     if success then
         print("basarili")
     else
     	print("basarisiz")
     end
end)]]

RegisterCommand('minigame2', function()
    OpenHackingGame(10000, function(success)
        if success then
            print("Success")
        else
            print("Failed")
        end
    end)
end)
