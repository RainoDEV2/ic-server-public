

Citizen.CreateThread(function()
    local table = remoteCalls.execute("np-digital:recieveCoords")
    for i = 1, #table do
        exports["np-target"]:AddBoxZone(tostring(i)..'-digital', vector3(table[i]["coords"].x, table[i]["coords"].y, table[i]["coords"].z), table[i]["coords"].width, table[i]["coords"].height, {
            name= tostring(i)..'-digital',
            debugPoly=false,
            heading= table[i]["coords"].h,
            minZ= table[i]["coords"].minZ,
            maxZ= table[i]["coords"].maxZ
        }, {
            options = {
                {
                    event = table[i].event,
                    icon = table[i].icon,
                    label = table[i].label,
                    parms = table[i].parms,
                },
            },
            job = {"all"},
            distance = 1.5
        })
    end
end)

RegisterNetEvent('np-digital:client:attemptHack')
AddEventHandler('np-digital:client:attemptHack', function()
    local table = remoteCalls.execute("np-digital:recieveCoords")
    local cooldown = remoteCalls.execute("np-digital:getCooldown")
    local item = exports["np-inventory"]:hasEnoughOfItem(table[1].item, 1)
    if item then
        if not table[1].state then 
            if not cooldown then
                print('hi')
                TriggerEvent('inventory:removeItem', table[1].item, 1)
                exports['np-dispatch']:SendAlert("AlertDigitalRobbery")
                StartPanel()
                startHack()
            else
                TriggerEvent('DoLongHudText', 'Electrical is on security lock out!', 2)
            end
        else
            TriggerEvent('DoLongHudText', 'Electrical Box has been hit!', 2)
        end
    else
        TriggerEvent('DoShortHudText', 'Nothing to hit the electrical box.')
    end
end)



RegisterNetEvent('np-digital:client:safe')
AddEventHandler('np-digital:client:safe', function()
    print('test')
    local table = remoteCalls.execute("np-digital:recieveCoords")
    TriggerEvent('trap:attempt', table[3].code)
end)

RegisterNetEvent('np-digital:keypad')
AddEventHandler('np-digital:keypad', function(code)
    local table = remoteCalls.execute("np-digital:recieveCoords")
    print('hi')
    if table[3].code == code then 
        local chance = math.random(1, 100)
        if chance <= 10 then
            TriggerEvent('player:receiveItem', 'vpnxj', 1)
        end
        TriggerEvent('player:receiveItem', 'rollcash', math.random(50, 100))
        TriggerEvent('DoLongHudText', 'You have entered the safe!', 2)
    else
        TriggerEvent('DoLongHudText', 'Invalid Code!', 2)
    end
end)

RegisterCommand('looting', function()
    remoteCalls.execute('np-digitalden:enableLooting')
end)

RegisterNetEvent('np-laptop:usb')
AddEventHandler('np-laptop:usb', function()
    local table = remoteCalls.execute("np-digital:recieveCoords")
    local item = exports["np-inventory"]:hasEnoughOfItem('mk2usbdevice', 1)
    if table[2].state then
        if item then
            local finished = exports['np-taskbar']:taskBar(5000, 'Inserting USB')
            if finished == 100 then
                TriggerEvent('open:minigame', 20, 4, function(Success)
                    if Success then
                        remoteCalls.execute("np-digital:hackDigital", 4, true)
                        remoteCalls.execute('np-digitalden:enableLooting')
                        TriggerEvent('inventory:removeItem', 'mk2usbdevice', 1)
                        RPC.execute("np-digital:hackDigital", 4, true)
                        RPC.execute('np-digitalden:enableLooting')
                    else
                        TriggerEvent('inventory:removeItem', 'mk2usbdevice', 1)
                        TriggerEvent('DoShortHudText', 'You failed!', 1)
                    end
                end)
            end
        else
            TriggerEvent('DoShortHudText', 'No USB', 2)
        end
    else
        TriggerEvent('DoShortHudText', 'Error Code: 102', 2)
    end
end)

RegisterCommand('closedigital', function()
    print('test')
    remoteCalls.execute('np-digital:startCooldown')
end)

RegisterNetEvent('np-digital:loot')
AddEventHandler('np-digital:loot', function(params)
    local table = remoteCalls.execute("np-digital:recieveCoords")
    if not table[params].state then
        if table[4].state then
            loadAnimation()
            local finished = exports["np-taskbar"]:taskBar(15000, 'Looting!')
            if finished == 100 then
                local loot = remoteCalls.execute('np-digital:loot', tonumber(params))
                for k,v in ipairs(loot) do
                    print(v)
                end
            end
        else
            TriggerEvent('DoShortHudText', 'Locked!', 2)
        end
    else
        TriggerEvent('DoShortHudText', 'Locked!', 2)
    end
end)

RegisterNetEvent('np-digital:client:hackLaptop')
AddEventHandler('np-digital:client:hackLaptop', function()
    local table = remoteCalls.execute("np-digital:recieveCoords")
    local cooldown = remoteCalls.execute("np-digital:getCooldown")
    local item = exports["np-inventory"]:hasEnoughOfItem(table[2].item, 1)
    if item then
        if table[1].state then
            if not cooldown then
                TriggerEvent("utk_fingerprint:Start", 1, 2, 2, function(outcome, reason)
                    if outcome == true then -- reason will be nil if outcome is true
                        -- print("Succeed")
                        remoteCalls.execute("np-digital:hackDigital", 2, true)
                        local code = remoteCalls.execute("np-digital:changeCode")
                        local chance = math.random(1,100)
                        if chance <= 60 then
                            TriggerEvent("DoLongHudText", "Code: " .. code, 1)
                        else
                            TriggerEvent('DoLongHudText', 'No Code Found!', 2)
                        end
                        TriggerEvent('inventory:removeItem', table[2].item, 1)
                        TriggerEvent('player:receiveItem', 'mk2usbdevice', 1)
                    elseif outcome == false then
                        TriggerEvent("DoLongHudText", "Failed. Reason: "..reason, 2)
                    end
                end)
            else
                TriggerEvent('DoLongHudText', 'Laptop has been locked out!', 2)
            end
        else
            TriggerEvent('DoLongHudText', 'Error Code 102!', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'Error Code 101!', 2)
    end
end)

function loadAnimation()
    local plyPed = PlayerPedId()
	loadAnimDict( "mini@repair" ) 
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'robberyglassbreak', 0.5)
    if not IsEntityPlayingAnim(plyPed, "mini@repair", "fixing_a_player", 3) then
        ClearPedSecondaryTask(plyPed)
        TaskPlayAnim(plyPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
    end
end

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function startHack()
    local ply = PlayerPedId()
    TriggerEvent('open:minigame', 20, 4, function(Success)
        if Success then
            ClearPedTasksImmediately(ply)
            TriggerEvent('DoShortHudText', 'Door Security system has been fried. The door should unlock in a few seconds.')
            remoteCalls.execute("np-digital:hackDigital", 1, true)
            Citizen.Wait(10000)
            TriggerEvent('DoShortHudText', 'Door has been unlocked!', 1)
            TriggerServerEvent('np-doors:changeLock-status', 208, false)
        else
            ClearPedTasksImmediately(ply)
            TriggerEvent('DoShortHudText', 'You failed!', 1)
        end
        DeleteEntity(laptop)
    end)
end

function StartPanel()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, 1151.6691894531, -432.94937133789, 67.00798034668-0.9, 2.0, -1, 0.0)
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, 256.80889892578)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", 1151.6691894531, -432.94937133789, 67.00798034668 -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, 256.80889892578)
    while IsEntityPlayingAnim(ply, "anim@heists@ornate_bank@hack", "hack_enter", 3) do
        Wait(0)
    end
    laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
    Wait(0)
    SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
    PlaceObjectOnGroundProperly(laptop)
    Wait(0)
    TaskPlayAnim(ply, "anim@heists@ornate_bank@hack", "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)

end

-- remoteCalls.execute("np-digital:hackDigital")