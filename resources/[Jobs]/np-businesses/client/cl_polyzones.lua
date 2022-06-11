--[[

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("receipt_sell", vector3(-1192.57, -901.65, 14.0), 2.6, 1, {
        name="receipt_sell",
        heading=215,
        --debugPoly=true,
        minZ=11.4,
        maxZ=15.4
      })      
    exports["np-polyzone"]:AddBoxZone("receipt_sell", vector3(376.84, -823.94, 29.3), 1, 1, {
        name="receipt_sell",
        heading=0,
        --debugPoly=true,
        minZ=28.3,
        maxZ=32.3
      })
    exports["np-polyzone"]:AddBoxZone("receipt_sell", vector3(132.66, -1286.64, 29.27), 1.4, 1, {
        name="receipt_sell",
        heading=30,
        --debugPoly=true,
        minZ=27.47,
        maxZ=31.47
      })
    exports["np-polyzone"]:AddBoxZone("receipt_sell", vector3(-628.02, 223.66, 81.88), 1.8, 1, {
        name="receipt_sell",
        heading=90,
        --debugPoly=true,
        minZ=80.28,
        maxZ=84.28
      })
    exports["np-polyzone"]:AddBoxZone("receipt_sell", vector3(-1365.79, -616.52, 30.32), 2.0, 1, {
        name="receipt_sell",
        heading=30,
        --debugPoly=true,
        minZ=28.72,
        maxZ=32.72
      })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "receipt_sell" then
        NearReceipt = true
        TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("Use receipt here"))
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "receipt_sell" then
        NearReceipt = false
    end
    TriggerEvent('np-textui:HideUI')
end)

exports("NearReceiptShit", function()
    return NearReceipt
end)]]
