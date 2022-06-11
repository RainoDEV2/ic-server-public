NearScubaBoatRental, NearReturnBoat, IronSellSpot, SellUnknown, ProcessFish, NearWeazelNews = false, false, false, false, false, false
CutFish, SellSpotF, ChickenStart, ChickenSpot, MeltingSpot, WashingSpot, NearChopShop, AtChopSell = false, false, false, false, false, false, false, false
Citizen.CreateThread(function()
    -- Mining
    exports["np-polyzone"]:AddBoxZone("melting_spot", vector3(1084.69, -2001.75, 30.88), 3, 3, {
        name="melting_spot",
        heading=325,
        minZ=28.08,
        maxZ=32.08
    })  
    exports["np-polyzone"]:AddBoxZone("washing_spot", vector3(1987.53, 551.72, 161.79), 9.4, 4, {
        name="washing_spot",
        heading=325,
        minZ=159.59,
        maxZ=162.79
    })  
    -- Scuba
    exports["np-polyzone"]:AddBoxZone("scuba_get_boat", vector3(-1612.81, 5261.71, 3.97), 2.3, 1.5, {
        name="scuba_get_boat",
        heading=115,
        --debugPoly=true,
        minZ=2.97,
        maxZ=4.97
    })  
    exports["np-polyzone"]:AddBoxZone("scuba_return_boat", vector3(-1602.02, 5260.31, 2.09), 7.4, 5, {
        name="scuba_return_boat",
        heading=25,
        --debugPoly=true,
        minZ=-1.11,
        maxZ=3.89
    })  
    exports["np-polyzone"]:AddBoxZone("sell_iron_bars", vector3(2341.04, 3128.18, 48.21), 1.8, 1, {
        name="sell_iron_bars",
        heading=260,
        --debugPoly=true,
        minZ=47.21,
        maxZ=49.21
    }) 
    exports["np-polyzone"]:AddBoxZone("sell_unknown_material", vector3(-1459.32, -413.59, 35.75), 1.8, 1, {
        name="sell_unknown_material",
        heading=75,
        --debugPoly=true,
        minZ=34.55,
        maxZ=36.95
    }) 
    -- Fishing 
    exports["np-polyzone"]:AddBoxZone("fishing_sushi", vector3(-3248.21, 992.68, 12.49), 8.4, 5, {
        name="fishing_sushi",
        heading=85,
        --debugPoly=true,
        minZ=11.49,
        maxZ=13.44
    }) 
    exports["np-polyzone"]:AddBoxZone("fishing_cut", vector3(-3426.17, 974.33, 8.35), 9.4, 4, {
        name="fishing_cut",
        heading=0,
        --debugPoly=true,
        minZ=7.35,
        maxZ=9.2
    }) 
    exports["np-polyzone"]:AddBoxZone("fishing_sell", vector3(-1841.98, -1199.48, 14.3), 1.4, 1.2, {
        name="fishing_sell",
        heading=60,
        --debugPoly=true,
        minZ=11.3,
        maxZ=15.3
      })
    -- Chicken
    exports["np-polyzone"]:AddBoxZone("chicken_sell", vector3(169.4, -1633.86, 29.29), 2.2, 1, {
        name="chicken_sell",
        heading=125,
        --debugPoly=true,
        minZ=28.29,
        maxZ=32.29
    })
    exports["np-polyzone"]:AddBoxZone("chicken_start", vector3(2388.54, 5044.33, 45.99), 4.8, 2, {
        name="chicken_start",
        heading=315,
        minZ=43.39,
        maxZ=47.79
    })
    -- Weazel News Job
    exports["np-polyzone"]:AddBoxZone("Weazel", vector3(-598.17, -929.75, 25.34), 2.9, 5, {
        name="Weazel",
        heading=91,
        --debugPoly=true,
        minZ=22.14,
        maxZ=24.74
      })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "scuba_get_boat" then
        NearScubaBoatRental = true
        NearScubaBoat()
        if not canSpawn then
            TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("Boat rented already"))
        else
            TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Rent Boat ($400)"))
        end
    elseif name == 'scuba_return_boat' then
        if veh ~= 0 then
            TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Return Boat"))
            NearReturnBoat = true
            AtReturnSpot()
        end
    elseif name == "sell_iron_bars" then
        IronSellSpot = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Items"))
        IronSell()
    elseif name == "sell_unknown_material" then
        SellUnknown = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Items"))
        SellUnknownSpot()
    elseif name == "fishing_sushi" then
        ProcessFish = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Process Cut Fish"))
        ProcessFishSpot()
    elseif name == "fishing_cut" then
        CutFish = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Cut Fish"))
        CutFishSpot()
    elseif name == "fishing_sell" then
        SellSpotF = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Sushi"))
        SellSpotFish()
    elseif name == "chicken_sell" then
        ChickenSpot = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Chicken"))
        SellSpotChicken()
    elseif name == "chicken_start" then
        ChickenStart = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Start Catching Chicken"))
        StartSpotChicken()
    elseif name == "Weazel" then
        NearWeazelNews = true
        NearWeazelNews2()
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Record The News!"))
    elseif name == "melting_spot" then
        MeltingSpot = true
        Meltmaterials()
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Melt!"))
    elseif name == "washing_spot" then
        WashingSpot = true
        WashStones()
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Wash Stones!"))
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "scuba_get_boat" then
        NearScubaBoatRental = false
    elseif name == "melting_spot" then
        MeltingSpot = false
    elseif name == "washing_spot" then
        WashingSpot = false
    elseif name == 'scuba_return_boat' then
        NearReturnBoat = false
    elseif name == "sell_iron_bars" then
        IronSellSpot = false
    elseif name == "sell_unknown_material" then
        SellUnknown = false
    elseif name == "fishing_sushi" then
        ProcessFish = false
    elseif name == "fishing_cut" then
        CutFish = false
    elseif name == "fishing_sell" then
        SellSpotF = false
    elseif name == "chicken_sell" then
        ChickenSpot = false
    elseif name == "chicken_start" then
        ChickenStart = false
    elseif name == "Weazel" then
        NearWeazelNews = false
    end 
    TriggerEvent('np-textui:HideUI')
end)

function NearScubaBoat()
    Citizen.CreateThread(function()
        while NearScubaBoatRental do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if exports["np-inventory"]:hasEnoughOfItem('oxygentank',1,false) or oxyOn then
                    if canSpawn then
                        TriggerEvent("fuckoffdinghyomfgwhyisntitspawning")
                        TriggerServerEvent('np-scuba:checkAndTakeDepo')
                        Citizen.Wait(500)
                        canSpawn = false
                        SetEntityAsMissionEntity(vehicle, true, true)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        local plate = GetVehicleNumberPlateText(vehicle)
                        TriggerEvent("keys:addNew",vehicle,plate)
                        StartDive()
                    end
                else
                    TriggerEvent('DoLongHudText', 'Sorry Man, You Wont Be Able To Breath Down There, Come Back With A Scuba Tank!.', 1)
                end
            end
        end
    end)
end

function AtReturnSpot()
    Citizen.CreateThread(function()
        while NearReturnBoat do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                DeleteVehicle(veh)
                veh = 0
                TriggerEvent('DoLongHudText', 'Thanks For Returning The Vehicles, Heres some of the Money Back!.', 1)
                RemoveBlip(allBlips)
                RemoveBlip(allBlipsSprite)
                TriggerServerEvent('np-scuba:returnDepo')
                SetEntityCoords(PlayerPedId(), -1605.7166748047, 5259.1162109375, 2.0883903503418)
                SetEntityHeading(PlayerPedId(), 23.752769470215)
                Citizen.Wait(2000)
                canSpawn = true
            end
        end
    end)
end


function IronSell()
    Citizen.CreateThread(function()
        while IronSellSpot do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if exports["np-inventory"]:hasEnoughOfItem('ironbar',10,false) then
                    local finished = exports["np-taskbar"]:taskBar(2000,"Selling Iron")
                    if (finished == 100) then
                        SellItems()
                    end
                else
                    TriggerEvent('DoLongHudText', 'Your missing something.', 2)
                end
            end
        end
    end)
end

function SellUnknownSpot()
    Citizen.CreateThread(function()
        while SellUnknown do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if exports["np-inventory"]:hasEnoughOfItem('umetal',10,false) then
                    local finished = exports["np-taskbar"]:taskBar(5000,"Trading")
                    if (finished == 100 and payed == false) then
                        payed = true
                        TriggerServerEvent('np-scuba:makeGold')
                        Citizen.Wait(500)
                        payed = false
                    end
                else
                    TriggerEvent('DoLongHudText', 'Your missing something.', 2)
                end
            end 
        end
    end)
end

local DoingTask = false
function ProcessFishSpot()
    Citizen.CreateThread(function()
        while ProcessFish do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if not DoingTask then
                    if exports["np-inventory"]:getQuantity("cutfish") >= 1 then
                        playerAnim()
                        DoingTask = true
                        TriggerEvent('inventory:removeItem', 'cutfish', 1)
                        local finished = exports["np-taskbar"]:taskBar(4000,"Processing")
                        if finished == 100 then
                            ClearPedTasksImmediately(PlayerPedId())
                            Citizen.Wait(1000)
                            TriggerServerEvent('np-fish:process')
                            DoingTask = false
                        else
                            DoingTask = false
                            TriggerEvent('player:receiveItem', 'cutfish', 1)
                        end
                    end
                end
            end
        end
    end)
end

local DoingTask2 = false
function CutFishSpot()
    Citizen.CreateThread(function()
        while CutFish do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if exports["np-inventory"]:getQuantity("fish") >= 1 then
                    playerAnim()
                    TriggerEvent('inventory:removeItem', 'fish', 1)
                    DoingTask2 = true 
                    local finished = exports["np-taskbar"]:taskBar(4000,"Cutting")
                    if finished == 100 then
                        DoingTask2 = false
                        ClearPedTasksImmediately(PlayerPedId())
                        Citizen.Wait(1000)
                        TriggerServerEvent('np-fish:cut')
                    else
                        DoingTask2 = false
                    end
                end
            end
        end
    end)
end


function NearWeazelNews2()
    Citizen.CreateThread(function()
        local myJob = exports["np_handler"]:isPed("myJob")
        while NearWeazelNews do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if canSpawn then
                    TriggerEvent("spawnvan")
                    Citizen.Wait(500)
                    canSpawn = false
                    SetEntityAsMissionEntity(vehicle, true, true)
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    TriggerEvent("keys:addNew",vehicle,plate)
                    TriggerEvent("makenews")
                end
            else
                TriggerEvent('DoLongHudText', "You Are Not Qualified For This Job", 1)
            end
        end
    end)
end

function Meltmaterials()
    Citizen.CreateThread(function()
        while MeltingSpot do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                TriggerEvent("SmeltingEvent")
            end
        end
    end)
end

function WashStones()
    Citizen.CreateThread(function()
        while WashingSpot do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                TriggerEvent("washerevent")
            end
        end
    end)
end

function StartSpotChicken()
    Citizen.CreateThread(function()
        while ChickenStart do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                TriggerEvent("Lapchickena")
            end
        end
    end)
end

function SellSpotChicken()
    Citizen.CreateThread(function()
        while ChickenSpot do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                TriggerEvent("Sellchicken")
            end
        end
    end)
end


function SellSpotFish()
    Citizen.CreateThread(function()
        while SellSpotF do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                TriggerEvent("sellfish")
            end
        end
    end)
end