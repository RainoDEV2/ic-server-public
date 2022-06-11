local NearRentalSpot, pRentalCar, pRentalCarPrice, CurrentRentalSpot = false, 0, 0, nil

local pSpots = {
    ["rental_behind_pillbox"] = { 
        spawn = {
            [1] = {111.38833618164, -1081.0446777344, 28.518127441406, 340.35293579102},
            [2] = {107.9913482666, -1079.7103271484, 28.518180847168, 340.60977172852},
            [3] = {104.58460998535, -1078.0941162109, 28.517950057983, 341.43957519531}
        }
    },

    ["rental_prison"] = { 
        spawn = {
            [1] = {1854.7000732422, 2578.7756347656, 44.950592041016, 268.59},
            [2] = {1854.7712402344, 2575.1508789062, 44.95096206665, 269.62},
            [3] = {1854.65625, 2571.5129394531, 44.950302124023, 269.26}
        }
    },
}

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("rental_behind_pillbox", vector3(109.57, -1089.98, 29.3), 1.2, 1, {
        name="rental_behind_pillbox",
        heading=75,
        --debugPoly=true,
        minZ=26.3,
        maxZ=30.3
    })

    exports["np-polyzone"]:AddBoxZone("rental_prison", vector3(1853.1, 2582.16, 45.67), 2.8, 2.6, {
        name="rental_prison",
        heading=0,
        --debugPoly=true,
        minZ=42.67,
        maxZ=46.67
    })    
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "rental_behind_pillbox" then
        NearRentalSpot = true
        exports['np-interaction']:showInteraction('[E] Open Rental Menu')
        OpenRental()
    elseif name == "rental_prison" then
        NearRentalSpot = true
        exports['np-interaction']:showInteraction('[E] Open Rental Menu')
        OpenRental()
    end
    CurrentRentalSpot = name
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "rental_behind_pillbox" then
        NearRentalSpot = false
    elseif name == "rental_prison" then
        NearRentalSpot = false
    end
    exports['np-interaction']:hideInteraction()
    CurrentRentalSpot = nil
end)

function OpenRental()
    Citizen.CreateThread(function()
        while NearRentalSpot do
            Citizen.Wait(1)
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent("rental:open:sv")
            end
        end
    end)
end

RegisterNetEvent("rental:attempt:return", function()
    if pRentalCar ~= 0 then
        if DoesEntityExist(pRentalCar) then
            if GetVehicleBodyHealth(pRentalCar) >= 300.0 then
                TriggerServerEvent("rental:return", pRentalCarPrice, pBodyHealth)
                SetEntityAsMissionEntity(pRentalCar, true, true)
                DeleteVehicle(pRentalCar)
                DeleteEntity(pRentalCar)
                pRentalCar = 0
                pRentalCarPrice = 0
                if exports["np-inventory"]:hasEnoughOfItem("rentalpaper",1,false) then
                    TriggerEvent("inventory:removeItem", "rentalpaper", 1)
                end
            else
                TriggerEvent("DoLongHudText", "The vehicle is damage, get it fixed or we wont take it back!", 2)
            end
        end
    else
        TriggerEvent("DoLongHudText", "You dont have a rented vehicle out!", 2)
    end
end)

RegisterNetEvent("open:rental:cl", function()
    if pRentalCar == 0 then
        TriggerEvent('np-context:sendMenu', {
            {
                id = 1,
                header = "Faggio",
                txt = "Cost to rent $100",
                params = {
                    event = "rental:allowed:spawn",
                    args = {
                        model = "faggio",
                        price = 100
                    }
                }
            },

            {
                id = 2,
                header = "Huntley",
                txt = "Cost to rent $600!",
                params = {
                    event = "rental:allowed:spawn",
                    args = {
                        model = "huntley",
                        price = 600
                    }
                }
            },


            {
                id = 3,
                header = "Dirt Bike",
                txt = "Cost to rent $500!",
                params = {
                    event = "rental:allowed:spawn",
                    args = {
                        model = "bf400",
                        price = 500
                    }
                }
            },


            {
                id = 4,
                header = "Sultan",
                txt = "Cost to rent $750!",
                params = {
                    event = "rental:allowed:spawn",
                    args = {
                        model = "sultan",
                        price = 750
                    }
                }
            },

            {
                id = 5,
                header = "Sand King",
                txt = "Cost to rent $1000!",
                params = {
                    event = "rental:allowed:spawn",
                    args = {
                        model = "sandking",
                        price = 1000
                    }
                }
            }
        })
    else
        TriggerEvent("DoLongHudText", "Return your recent rented vehicle first!", 2)
    end
end)


RegisterNetEvent("rental:allowed:spawn")
AddEventHandler("rental:allowed:spawn", function(pCarData)
    local PurchaseSuccess = remoteCalls.execute("rental:attempt", pCarData.price)
    if (PurchaseSuccess) then
        Citizen.CreateThread(function()			
            Citizen.Wait(100)
            local car = pCarData.model
            RequestModel(car)
            while not HasModelLoaded(car) do
                Citizen.Wait(0)
            end
    
            local pSpot = math.random(1, 3)
            local spawnPos = pSpots[CurrentRentalSpot].spawn[pSpot]
            veh = CreateVehicle(car, spawnPos[1], spawnPos[2], spawnPos[3], spawnPos[4], true, false)
            SetVehicleNumberPlateText(veh, "RENTAL"..math.random(111,999))
            local plate = GetVehicleNumberPlateText(veh)
            SetModelAsNoLongerNeeded(car)
            DecorSetBool(veh, "PlayerVehicle", true)
            SetVehicleOnGroundProperly(veh)
            SetEntityInvincible(veh, false) 
            SetVehicleNumberPlateText(veh, plate)
            TriggerEvent("keys:addNew",veh, plate)
            SetVehicleHasBeenOwnedByPlayer(veh,true)
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(veh), true)
            exports['np-hud']:setFuel(veh, 100)
            pRentalCar = veh
            pRentalCarPrice = pCarData.price
            remoteCalls.execute("rental:give:papers", pRentalCarPrice, plate)
        end)
    end
end)