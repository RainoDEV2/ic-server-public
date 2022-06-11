RegisterNUICallback('callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    cb('ok')
end)

function OpenVaultGame(lenght, time, callback)
  Callbackk = callback
	SetNuiFocus(true, true)
	SendNUIMessage({type = "open", lenght = lenght, time = time})
end

-- /vault [lenght] [full time]
RegisterCommand("vault",function(source, args, raw)
  exports['tc-vault']:OpenVaultGame(3, 5000, function(success)
    if success then
      print("basarili")
    else
      print("basarisiz")
    end
  end)
end)