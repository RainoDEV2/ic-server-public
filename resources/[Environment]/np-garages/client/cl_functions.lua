CurrentDisplayVehicle, ParkingSpot = nil, nil

function SpawnVehicle(vehicle, pGarage, Fuel, pBodyHealth, pEngineHealth, customized, plate, IsViewing)
    exports['np-garages']:DeleteViewedCar()

    Citizen.Wait(math.random(100, 200)) -- Time to delete car on client / Hopefully stops duping

	local car = GetHashKey(vehicle)
	local customized = json.decode(customized)
    local selectedGarage = Garages[pGarage]

    if pGarage == "Impound Lot" or pGarage == "Repo" then
        ParkingSpot = selectedGarage.spawns[1]
    elseif exports['np-menu']:houseGarageCoords() ~= nil and exports['np-menu']:NearHouseGarage() then
        HousingSpawn = exports['np-menu']:houseGarageCoords()
        ParkingSpot = HousingSpawn
    else
        for i=1, #selectedGarage.spawns do
            local RunSpawnCheck = false
            local distance = #(vector3(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z) - GetEntityCoords(PlayerPedId()))
            if distance < 1.6 then
                RunSpawnCheck = true
            elseif distance < 1.8 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 2.0 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 2.4 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 3.0 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 3.5 and not RunSpawnCheck then
            end

            if RunSpawnCheck then
                local vehicle = GetClosestVehicle(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z, 2.0, 0, 127)
                if not DoesEntityExist(vehicle) then
                    ParkingSpot = selectedGarage.spawns[i]
                    break
                end
            end
        end
    end
    

    if not ParkingSpot then
        TriggerEvent("DoLongHudText", "You need to be near a parking spot!", 2)
        return
    end

    if not IsModelInCdimage(vehicle) or not IsModelAVehicle(vehicle) then
        return 
    end

    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    tempVeh = remoteCalls.execute('np-garages:spawnvehicle', vector3(ParkingSpot.x, ParkingSpot.y, ParkingSpot.z), ParkingSpot.h, car)
    veh = NetworkGetEntityFromNetworkId(tempVeh)
    CurrentDisplayVehicle = NetworkGetEntityFromNetworkId(tempVeh)
    ApplyVehicleDamage(veh, pBodyHealth, pEngineHealth)
    SetModelAsNoLongerNeeded(car)

    if Fuel <= tonumber(5) then
        exports['np-hud']:setFuel(veh, 100)
    else
        DecorSetInt(veh, "CurrentFuel", Fuel)
    end
    
    SetVehicleOnGroundProperly(veh)
    SetVehRadioStation(veh, 'OFF')
    SetVehicleDirtLevel(veh, 0.0)
    SetVehicleNumberPlateText(veh, plate)
    SetVehicleProps(veh, customized)
    SetEntityAsMissionEntity(veh, true, true)
    TriggerEvent("keys:addNew", veh, plate)
    
    if not IsViewing then    
        CurrentDisplayVehicle = nil
        remoteCalls.execute("np-garages:states", "Out", plate, exports['np-menu']:currentGarage(), GetVehicleFuelLevel(veh), GetVehicleBodyHealth(veh), GetVehicleEngineHealth(veh))
    end
end


function SetVehicleProps(veh, customized)
    SetVehicleModKit(veh, 0)
    if customized ~= nil then

        SetVehicleWheelType(veh, customized.wheeltype)
        SetVehicleNumberPlateTextIndex(veh, 3)

        for i = 0, 16 do
            SetVehicleMod(veh, i, customized.mods[tostring(i)])
        end

        for i = 17, 22 do
            ToggleVehicleMod(veh, i, customized.mods[tostring(i)])
        end

        for i = 23, 24 do
            local isCustom = customized.mods[tostring(i)]
            if (isCustom == nil or isCustom == "-1" or isCustom == false or isCustom == 0) then
                isSet = false
            else
                isSet = true
            end
            SetVehicleMod(veh, i, customized.mods[tostring(i)], isCustom)
        end

        for i = 23, 48 do
            SetVehicleMod(veh, i, customized.mods[tostring(i)])
        end

        for i = 0, 3 do
            SetVehicleNeonLightEnabled(veh, i, customized.neon[tostring(i)])
        end

        if customized.extras ~= nil then
            for i = 1, 12 do
                local onoff = tonumber(customized.extras[i])
                if onoff == 1 then
                    SetVehicleExtra(veh, i, 0)
                else
                    SetVehicleExtra(veh, i, 1)
                end
            end
        end

        if customized.oldLiveries ~= nil and customized.oldLiveries ~= 24  then
            SetVehicleLivery(veh, customized.oldLiveries)
        end

        if customized.plateIndex ~= nil and customized.plateIndex ~= 4 then
            SetVehicleNumberPlateTextIndex(veh, customized.plateIndex)
        end

        -- Xenon Colors
        SetVehicleXenonLightsColour(veh, (customized.xenonColor or -1))
        SetVehicleColours(veh, customized.colors[1], customized.colors[2])
        SetVehicleExtraColours(veh, customized.extracolors[1], customized.extracolors[2])
        SetVehicleNeonLightsColour(veh, customized.lights[1], customized.lights[2], customized.lights[3])
        SetVehicleTyreSmokeColor(veh, customized.smokecolor[1], customized.smokecolor[2], customized.smokecolor[3])
        SetVehicleWindowTint(veh, customized.tint)
        SetVehicleInteriorColour(veh, customized.dashColour)
        SetVehicleDashboardColour(veh, customized.interColour)
    else
        SetVehicleColours(veh, 0, 0)
        SetVehicleExtraColours(veh, 0, 0)
    end
end

exports("DeleteViewedCar", function()
		-- SetEntityAsMissionEntity(CurrentDisplayVehicle, true, true)
		DeleteVehicle(CurrentDisplayVehicle)
		TriggerServerEvent("np-garages:deleteVeh", NetworkGetNetworkIdFromEntity(CurrentDisplayVehicle))
		CurrentDisplayVehicle = nil
end)

function ApplyVehicleDamage(pVeh, pBodyHealth, pEngineHealth)
    if (pVeh ~= 0) then
        smash = false
        damageOutside = false
        damageOutside2 = false 
        local engine = pEngineHealth + 0.0
        local body = pBodyHealth + 0.0
        if engine < 200.0 then
            engine = 200.0
        end
    
        if body < 150.0 then
            body = 150.0
        end
        if body < 550.0 then
            smash = true
        end
    
        if body < 520.0 then
            damageOutside = true
        end
    
        if body < 520.0 then
            damageOutside2 = true
        end
    
        Citizen.Wait(100)
        SetVehicleEngineHealth(pVeh, engine)
        if smash then
            SmashVehicleWindow(pVeh, 0)
            SmashVehicleWindow(pVeh, 1)
            SmashVehicleWindow(pVeh, 2)
            SmashVehicleWindow(pVeh, 3)
            SmashVehicleWindow(pVeh, 4)
        end
        if damageOutside then
            SetVehicleDoorBroken(pVeh, 1, true)
            SetVehicleDoorBroken(pVeh, 6, true)
            SetVehicleDoorBroken(pVeh, 4, true)
        end

        if damageOutside2 then
            SetVehicleTyreBurst(pVeh, 1, false, 990.0)
            SetVehicleTyreBurst(pVeh, 2, false, 990.0)
            SetVehicleTyreBurst(pVeh, 3, false, 990.0)
            SetVehicleTyreBurst(pVeh, 4, false, 990.0)
        end

        if pBodyHealth <= 100 then
            SetVehicleBodyHealth(pVeh, 250.0)
        else
            SetVehicleBodyHealth(pVeh, body)
        end        
    else
        print(string.gsub("Error Fetching Vehicle: %s", pVeh))
    end

end



RegisterNetEvent('fakeplate:change')
AddEventHandler('fakeplate:change', function()
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    local defaultPlate = GetVehicleNumberPlateText(targetVehicle)
    local hadKeys = exports["np-keys"]:hasKey(defaultPlate)
    local chars = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
    local plate = math.random(1,9) .. math.random(1, 9) .. chars[math.random(1,#chars)] .. chars[math.random(1,#chars)] .. chars[math.random(1,#chars)] .. chars[math.random(1,#chars)] .. math.random(1,9) .. math.random(1,9) .. math.random(1,9)
    if targetVehicle then
        RequestAnimDict("mini@repair")
        while not HasAnimDictLoaded("mini@repair") do
            Citizen.Wait(0)
        end
        TaskTurnPedToFaceEntity(PlayerPedId(), targetVehicle, 1.0)
        Citizen.Wait(1000)
        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, 15000, 16, 0, 0, 0, 0)
        local finished = exports["np-taskbar"]:taskBar(15000, 'Changing Plate')
        if finished == 100 then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerEvent('inventory:removeItem', 'fakeplate', 1)
            SetVehicleNumberPlateText(targetVehicle, tostring(plate))
            local newPlate = GetVehicleNumberPlateText(targetVehicle)
            remoteCalls.execute('np-garages:managePlates', newPlate, defaultPlate, "add")
            if hadKeys then
                print('had keys')
                print('test ', newPlate)
                TriggerEvent('keys:addNew', targetVehicle, newPlate)
            end
        end
        print(plate)
    end
end)


function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent("impound:return")
AddEventHandler("impound:return", function()
    exports['np-garages']:DeleteViewedCar()
end)