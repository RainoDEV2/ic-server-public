RegisterNetEvent("np-garages:open")
AddEventHandler("np-garages:open", function()
    local house = exports["np-menu"]:NearHouseGarage()
    exports['np-garages']:DeleteViewedCar()
    if house then
        print("house")
        remoteCalls.execute("np-garages:selectShared", exports['np-menu']:currentGarage())
    else
        print('select')
        remoteCalls.execute("np-garages:select", exports['np-menu']:currentGarage())
    end
end)

RegisterNetEvent("np-garages:attempt:spawn", function(data, pRealSpawn)
    if not pRealSpawn then
        remoteCalls.execute("np-garages:attempt:sv", data)
        SpawnVehicle(data.model, exports['np-menu']:currentGarage(), data.fuel, data.body, data.engine, data.customized, data.plate, true)
    else
        SpawnVehicle(data.model, exports['np-menu']:currentGarage(), data.fuel, data.body, data.engine, data.customized, data.plate, false)
    end
end)

RegisterNetEvent("np-garages:takeout", function(pData)
    local house = exports["np-menu"]:NearHouseGarage()
    if house then
        remoteCalls.execute("np-garages:spawned:getShared", pData.pVeh)
    else
        remoteCalls.execute("np-garages:spawned:get", pData.pVeh)
    end
end)

RegisterNetEvent("np-garages:store", function()
    local pos = GetEntityCoords(PlayerPedId())
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local curVeh = exports['mechanic']:getVehicleInDirection(coordA, coordB)
    if (curVeh ~= 0) then
        local fakePlates = remoteCalls.execute('np-garages:managePlates', '', '', 'get')
        local plate = exports["mechanic"]:NearVehicle("plate")
        print('fake plates ', json.encode(fakePlates[tostring(plate)]))
        if fakePlates[tostring(plate)] ~= nil then
            print('not nil')
            if fakePlates[tostring(plate)].isOn then
                remoteCalls.execute('np-garages:managePlates', plate, fakePlates[tostring(plate)].oldPlate, "remove")
                print('fake plate')
                plate = fakePlates[tostring(plate)].oldPlate
                print(plate)
            end
        end
        local Stored = remoteCalls.execute("np-garages:states", "In", plate, exports['np-menu']:currentGarage(), exports["mechanic"]:NearVehicle("Fuel"), exports["mechanic"]:NearVehicle("body"), exports["mechanic"]:NearVehicle("engine"))
        if Stored then
            DeleteVehicle(curVeh)
            DeleteEntity(curVeh)
            TriggerEvent('keys:remove', exports["mechanic"]:NearVehicle("plate"))
            TriggerEvent("DoLongHudText", "Vehicle stored in garage: " ..exports['np-menu']:currentGarage())
        else
            TriggerEvent("DoLongHudText", "You cant store local cars!", 2)
        end
    else
        TriggerEvent("DoLongHudText", "You need to look at the vehicle in order to store it!", 2)
    end
end)

Citizen.CreateThread(function()
    for _, item in pairs(Garages) do
        if item.blip ~= nil then
            Garage = AddBlipForCoord(item.blip.x, item.blip.y, item.blip.z)

            SetBlipSprite (Garage, 357)
            SetBlipDisplay(Garage, 4)
            SetBlipScale  (Garage, 0.65)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, 3)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.name)
            EndTextCommandSetBlipName(Garage)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, item in pairs(Garages) do
            if item.spawn ~= nil then
                local plyCoords = GetEntityCoords(PlayerPedId(), 0)
                local dist = #(vector3(item.spawn.x, item.spawn.y, item.spawn.z) - plyCoords)
                print(dist)
                if dist < 3 then
                    exports['np-interaction']:showInteraction("Open Garage")
                    TriggerEvent('np-garages:isNearGarage', item.name)
                else
                    exports['np-interaction']:hideInteraction()
                    TriggerEvent('np-garages:exitedgarage', item.name)
                end
                Citizen.Wait(2000)
            end
        end
        Citizen.Wait(2000)
    end
end)

