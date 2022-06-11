local PaycheckSpot, called = false, false

Citizen.CreateThread(function()
	exports["np-polyzone"]:AddBoxZone("paycheck_collect", vector3(-1082.48, -248.09, 37.76), 1.15, 2, {
    name="paycheck_collect",
    heading=30,
    --debugPoly=true,
    minZ=36.76,
    maxZ=38.76
  }) 
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
  if name == "paycheck_collect" then
    PaycheckSpot = true
    TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Collect Paycheck"))
    PaycheckFunction()
  end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
  if name == "paycheck_collect" then
    PaycheckSpot = false
  end
  TriggerEvent('np-textui:HideUI')
end)

function PaycheckFunction()
  Citizen.CreateThread(function()
    while PaycheckSpot do
      Citizen.Wait(5)
      if IsControlJustReleased(0, 38) then
        local finished = exports["np-taskbar"]:taskBar(2000,"Collecting Your Paycheck")
        if finished == 100 then
          if called == false then
            called = true
            TriggerServerEvent("paycheck:collect", exports["np_handler"]:isPed("cid"))
            Citizen.Wait(500)
            called = false
          end
        end
      end
    end
  end)
end