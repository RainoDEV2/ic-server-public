local NearLaptopSpot = false

Citizen.CreateThread(function()
  exports["np-polyzone"]:AddBoxZone("laptop_spot", vector3(1641.6, 4853.34, 42.02), 1.4, 1, {
    name="laptop_spot",
    --debugPoly=true,
    heading=0,
    minZ=40.22,
    maxZ=43.22
  })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
  if name == "laptop_spot" then
    NearLaptopSpot = true
      TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("[E] Use Note"))
      LaptopSpot()
  end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
  if name == "laptop_spot" then
    NearLaptopSpot = false
  end
end)

function LaptopSpot()
  Citizen.CreateThread(function()
      while NearLaptopSpot do
          Citizen.Wait(5)
          if IsControlJustReleased(0, 38) then
            if exports["np-inventory"]:hasEnoughOfItem('secretnote',1,false) then
              TriggerEvent("inventory:removeItem", "secretnote", 1)
              TriggerServerEvent("np-fleeca:item")
            end
          end
      end
  end)
end

RegisterNetEvent('np-secret:menu')
AddEventHandler('np-secret:menu', function()
  TriggerServerEvent("np-secret:menu")
end)

RegisterNetEvent('np-secret:craft')
AddEventHandler('np-secret:craft', function()
  if exports["np-inventory"]:hasEnoughOfItem("cpu",1) and exports["np-inventory"]:hasEnoughOfItem("powersupply",1) then
    local finished = exports["np-taskbar"]:taskBar(12000,"Gathering Information")
    if finished == 100 then	
    TriggerServerEvent("np-secret:craft")
  else
      TriggerEvent("DoLongHudText", "You Are Missing Items.", 2)
      end
    end
end)