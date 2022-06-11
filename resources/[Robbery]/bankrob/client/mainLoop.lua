ped = nil
local objects = {}
robbing = false
lockpicking = false
safeboxing = false
currentStore = 0
copsCalled = false
serverKeyGen = 0
inPoly = false
first = true
canRob = true
allowedToOpen = false
globalClosestDoor = nil
bomb = nil
vault = nil
hacking = nil
iscop = nil
camerasHacked = false
damagedPed = false
cash = {}

ReceptionPed = nil
SecurityPed = nil
SecondSecurityPed = nil
RandomPeds = {
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil,
}

local Pacific = PolyZone:Create({
    vector2(232.71, 211.31),
    vector2(229.84, 218.54),
    vector2(250.70, 274.82),
    vector2(298.05, 258.32),
    vector2(275.69, 196.06)
}, {
    name = "Pacific",
    debugGrid = false,
    maxZ = 115.61,
    gridDivisions = 45
})
RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify)
    if iscop and job ~= "police" then iscop = false end
    if job == "police" then iscop = true end
end)

Citizen.CreateThread(function()
    while Config.UseLasers do
        Citizen.Wait(1000)
        if(inPoly)then
            if(Config.PacificBank.vaultDoor.bombed)then
                if not lasersInitiated then
                    lasersInitiated = true
                    lasersToggler(true)
                end
                Citizen.Wait(2000)
            else
                if lasersInitiated then
                    lasersInitiated = false
                    lasersToggler(false)
                end
            end
        else
            if lasersInitiated then
                lasersInitiated = false
                lasersToggler(false)
            end
            Citizen.Wait(2000)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)

    while true do
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        inPoly = Pacific:isPointInside(coord)
        if inPoly and not insidePacific then
            insidePacific = true

            TriggerEvent("pacificBankRobbery:client:locker_markers")
            TriggerEvent("pacificBankRobbery:client:vault")

            if first then
                first = false
                TriggerEvent("pacificBankRobbery:client:pedHandler")
                CreateSafe()
                CreateCash()

                if(Config.UseLasers)then
                    initialiseLasers()
                end
            end

            for i = 1, #Config.PacificBank.doors do
                    local closestDoor = GetClosestObjectOfType(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, 1.0, Config.PacificBank.doors[i].objName, false, false, false)
                    
                    if(Config.PacificBank.doors[i].destroyed)then
                        FreezeEntityPosition(closestDoor, false)
                    else
                        if(Config.PacificBank.doors[i].locked)then
                            FreezeEntityPosition(closestDoor, true)
                        else
                            FreezeEntityPosition(closestDoor, false)
                        end
                    end
            end

            TriggerEvent("pacificBankRobbery:client:damagedPeds")

            if(Config.UseCopJob)then

                allowedToOpen = false
                    if iscop then
                        allowedToOpen = true
                    end

            end
            
            Citizen.CreateThread(function()
            
                while inPoly do

                    local inRange = false

                        if(not inRange)then
                            if((#(globalPlayerCoords - Config.PacificBank.vaultDoor.vaultCoords) < 1.5) and not (Config.PacificBank.vaultDoor.hacked or Config.PacificBank.vaultDoor.bombed))then

                                inRange = true

                                DrawText3D(Config.PacificBank.vaultDoor.bombLocation.x, Config.PacificBank.vaultDoor.bombLocation.y, Config.PacificBank.vaultDoor.bombLocation.z, Languages[Config.Language]['plant']) --The draw 3d text for the alarm.
                            
                                if IsControlJustPressed(1, Config.PlantBombButton) then --If the control is pressed do the below code.

                                    if(Config.UseItems)then
                                        --uses item end executes plantBomb() event
                                        if exports["np-inventory"]:hasEnoughOfItem("c4bomb",1,false) then
                                            TriggerEvent("inventory:removeItem", "c4bomb", 1)
                                            plantBomb()
                                        end
                                    else
                                
                                        Citizen.Wait(math.random(1,100))

                                        plantBomb()

                                    end
                                end
                            
                            end
                        end

                        if(not inRange)then
                            if((#(globalPlayerCoords - Config.PacificBank.vaultDoor.hackCoords) < 1.5) and not (Config.PacificBank.vaultDoor.hacked or Config.PacificBank.vaultDoor.bombed))then

                                inRange = true

                                DrawText3D(Config.PacificBank.vaultDoor.hackCoords.x, Config.PacificBank.vaultDoor.hackCoords.y, Config.PacificBank.vaultDoor.hackCoords.z, Languages[Config.Language]['hack']) --The draw 3d text for the alarm.
                            
                                if IsControlJustPressed(1, Config.HackPanelButton) then --If the control is pressed do the below code.

                                    if(Config.UseItems)then
                                        if exports["np-inventory"]:hasEnoughOfItem("heistlaptop4",1,false) then
                                            TriggerEvent("inventory:removeItem", "heistlaptop4", 1)
                                            hackPanel()
                                        end
                                    else
                                
                                        Citizen.Wait(math.random(1,100))

                                        hackPanel()

                                    end
                                end
                            
                            end
                        end

                        if(not inRange)then
                            if(#(globalPlayerCoords - Config.PacificBank.AlarmCoords) < 1 and Config.PacificBank.AlarmState)then

                                inRange = true
                                
                                DrawText3D(Config.PacificBank.AlarmCoords.x, Config.PacificBank.AlarmCoords.y, Config.PacificBank.AlarmCoords.z, Languages[Config.Language]['alarm']) --The draw 3d text for the alarm.

                                if IsControlJustPressed(1, Config.AlarmButton) then --If the control is pressed do the below code.
                                    Citizen.Wait(math.random(1,1000))

                                    dict = "anim@mp_radio@garage@high"
                                    loadDict(dict)
                                                                    
                                    while(not HasAnimDictLoaded(dict) and globalPlayerPed == nil)do
                                        Citizen.Wait(100)
                                    end
                                
                                    TaskPlayAnim(globalPlayerPed, dict, "button_press", 3.0, -1, -1, 49, 0, false, false, false)
                                    Citizen.Wait(850)
                                    ClearPedTasks(globalPlayerPed)

                                    TriggerServerEvent("pacificBankRobbery:server:globalAlarmState") --Starts the padlock minigame.
                                end

                            end
                        end

                        if(not inRange)then

                            if(Config.UseCopJob)then
                                    if(iscop)then
                                        if(#(globalPlayerCoords - Config.PacificBank.ResetBank) < 1.5 and Config.PacificBank.robbed)then

                                            inRange = true
                                            
                                            DrawText3D(Config.PacificBank.ResetBank.x, Config.PacificBank.ResetBank.y, Config.PacificBank.ResetBank.z, Languages[Config.Language]['reset']) --The draw 3d text for the alarm.
            
                                            if IsControlJustPressed(1, Config.ResetButton) then --If the control is pressed do the below code.
                                                Citizen.Wait(math.random(1,1000))
            
                                                dict = "anim@mp_radio@garage@high"
                                                loadDict(dict)
                                                                                
                                                while(not HasAnimDictLoaded(dict) and globalPlayerPed == nil)do
                                                    Citizen.Wait(100)
                                                end
                                            
                                                TaskPlayAnim(globalPlayerPed, dict, "button_press", 3.0, -1, -1, 49, 0, false, false, false)
                                                Citizen.Wait(850)
                                                ClearPedTasks(globalPlayerPed)
            
                                                TriggerServerEvent("pacificBankRobbery:server:ResetBank") --Starts the padlock minigame.
                                            end
            
                                        end
                                end
                            end
                        end

                        if(not inRange)then
                            for i = 1, #Config.PacificBank.safes do
                                if(#(globalPlayerCoords - Config.PacificBank.safes[i].safeCoords) < 1.5)then

                                    inRange = true

                                    if exports['np_handler']:isPed("countpolice") >= 5 then
                                        if(not safeboxing)then

                                            if(not Config.PacificBank.safes[i].opened and not Config.PacificBank.safes[i].busy)then
                                                DrawText3D(Config.PacificBank.safes[i].safeCoords.x, Config.PacificBank.safes[i].safeCoords.y, Config.PacificBank.safes[i].safeCoords.z, Languages[Config.Language]['crackSafe']) --The draw 3d text for the safe.
                                                
                                                if IsControlJustPressed(1, Config.CrackSafeButton) then --If the control is pressed do the below code.
                                                    Citizen.Wait(math.random(1,1000))
                                                    Citizen.Wait(math.random(1,200))
                                                    if(not Config.PacificBank.safes[i].busy)then
                                                        safeboxing = true
                                                        TriggerServerEvent("pacificBankRobbery:server:busyState", "safe", i, true)
                                                        TriggerEvent("pacific_safecracking:loop", i) --Starts the padlock minigame.
                                                    end
                                                end
                                            else
                                                DrawText3D(Config.PacificBank.safes[i].safeCoords.x, Config.PacificBank.safes[i].safeCoords.y, Config.PacificBank.safes[i].safeCoords.z, Languages[Config.Language]['safeOpened']) --The draw 3d text for the safe.
                                            end
                                        end
                                    else
                                        DrawText3D(Config.PacificBank.safes[i].safeCoords.x, Config.PacificBank.safes[i].safeCoords.y, Config.PacificBank.safes[i].safeCoords.z, Languages[Config.Language]['no_cops']) --The draw 3d text for the safe.
                                    end
                                end
                            end
                        end

                        if(not inRange)then
                            for i = 1, #Config.PacificBank.lockers do
                                if(#(globalPlayerCoords - Config.PacificBank.lockers[i].lockerCoords) < 0.5)then

                                    inRange = true

                                    local lockering = false

                                    if exports['np_handler']:isPed("countpolice") >= 5 then
                                        if(not lockering)then
                                            if(not Config.PacificBank.lockers[i].opened and not Config.PacificBank.lockers[i].busy)then
                                                DrawText3D(Config.PacificBank.lockers[i].lockerCoords.x, Config.PacificBank.lockers[i].lockerCoords.y, Config.PacificBank.lockers[i].lockerCoords.z, Languages[Config.Language]['breakLocker']) --The draw 3d text for the safe.
                                                
                                                if IsControlJustPressed(1, Config.BreakLockerButton) then --If the control is pressed do the below code.

                                                    if(Config.UseItems) then
                                                        if exports["np-inventory"]:hasEnoughOfItem("lockpick", 1) then
                                                            TriggerEvent("inventory:removeItem", "lockpick", 1)
                                                            lockering = true
                                                            TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", i, true)
                                                            TriggerEvent("pacific_locker:loop", i) --Starts the padlock minigame.
                                                        else
                                                            TriggerEvent('DoLongHudText', 'You dont have enough items', 2)
                                                        end
                                                    else
                                                        lockering = true
                                                        TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", i, true)
                                                        TriggerEvent("pacific_locker:loop", i) --Starts the padlock minigame.
                                                    end
                                                    else
                                                
                                                        Citizen.Wait(math.random(1,1000))
                                                        Citizen.Wait(math.random(1,200))
                                                        if(not Config.PacificBank.lockers[i].busy)then
                                                            safeboxing = true
                                                            TriggerServerEvent("pacificBankRobbery:server:busyState", "locker", i, true)
                                                            breakLocker(i)
                                                        end
                
                                                    end
                                                end
                                            else
                                                DrawText3D(Config.PacificBank.lockers[i].lockerCoords.x, Config.PacificBank.lockers[i].lockerCoords.y, Config.PacificBank.lockers[i].lockerCoords.z, Languages[Config.Language]['lockerOpened']) --The draw 3d text for the safe.
                                            end
                                        end
                                    else
                                        DrawText3D(Config.PacificBank.lockers[i].lockerCoords.x, Config.PacificBank.lockers[i].lockerCoords.y, Config.PacificBank.lockers[i].lockerCoords.z, Languages[Config.Language]['no_cops']) --The draw 3d text for the safe.
                                    end     
                                end
                            end
                        end

                        if(not inRange)then
                            for i = 1, #Config.PacificBank.cash do
                                if(((#(globalPlayerCoords.xy - Config.PacificBank.cash[i].cashCoords.xy) < 0.70) and (globalPlayerCoords.z - Config.PacificBank.cash[i].cashCoords.z) < 2.00) and (not Config.PacificBank.cash[i].stolen))then
                                    inRange = true

                                    DrawText3D(Config.PacificBank.cash[i].cashCoords.x, Config.PacificBank.cash[i].cashCoords.y, Config.PacificBank.cash[i].cashCoords.z, Languages[Config.Language]['steal']) --The draw 3d text for the alarm.
                                
                                    if IsControlJustPressed(1, Config.StealCashButton) then --If the control is pressed do the below code.
                                        stealCash(i)
                                    end
                                
                                end
                            end
                        end

                    if not inRange then
                        Citizen.Wait(500)
                    end

                    Citizen.Wait(4)
                end
            end)
        elseif not inPoly and insidePacific then
            insidePacific = false
            lasersToggler(false)
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()

    while(globalPlayerId == nil)do
        Wait(100)
    end

    while(Config.PacificBank.robbed == nil)do --Makes sure we get all the data from the server.

        TriggerServerEvent("pacificBankRobbery:server:randomKeyGen", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:PedsUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:stealableUpdate", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:doorsUpdate", GetPlayerServerId(globalPlayerId))
         
        TriggerServerEvent("pacificBankRobbery:server:AlarmState", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:robbed", GetPlayerServerId(globalPlayerId))

        TriggerServerEvent("pacificBankRobbery:server:policeCheck", GetPlayerServerId(globalPlayerId))

        Citizen.Wait(1000)
    end

    Citizen.CreateThread(function() --Checks whether the peds are dead or not. Also sends a robbery alert
        while true do
            Wait(3000)
                    local callCops = false
                    
                    if(DoesEntityExist(ReceptionPed))then
                        if(Config.PacificBank.mainReceptionEmployeeState)then
                            Wait(500)
                            if (IsPedDeadOrDying(ReceptionPed) and DoesEntityExist(ReceptionPed)) then
                                Wait(500)
                                if (IsPedDeadOrDying(ReceptionPed) and DoesEntityExist(ReceptionPed)) then
                                    local deathSource, wep = NetworkGetEntityKillerOfPlayer(ReceptionPed)

                                    if deathSource == -1 or deathSource == playerPed then
                                        killer = PlayerId()
                                    end

                                    if deathSource == -1 or deathSource == globalPlayerPedId then
                                        TriggerServerEvent('pacificBankRobbery:server:pedDead', "reception")
                                        callCops = true
                                    end
                                end
                            end
                        end
                    end

                    if(DoesEntityExist(SecurityPed))then
                        Wait(500)
                        if(Config.PacificBank.mainSecurityGuardState)then
                            Wait(500)
                            if (IsPedDeadOrDying(SecurityPed) and DoesEntityExist(SecurityPed)) then
                                Wait(500)
                                if (IsPedDeadOrDying(SecurityPed) and DoesEntityExist(SecurityPed)) then
                                    local deathSource, wep = NetworkGetEntityKillerOfPlayer(SecurityPed)

                                    if deathSource == -1 or deathSource == playerPed then
                                        killer = PlayerId()
                                    end

                                    if deathSource == -1 or deathSource == globalPlayerPedId then
                                        TriggerServerEvent('pacificBankRobbery:server:pedDead', "guard")
                                        callCops = true
                                    end
                                end
                            end 
                        end
                    end

                    if(DoesEntityExist(SecondSecurityPed))then
                        Wait(500)
                        if(Config.PacificBank.secondSecurityGuardState)then
                            Wait(500)
                            if (IsPedDeadOrDying(SecondSecurityPed) and DoesEntityExist(SecondSecurityPed)) then
                                Wait(500)
                                    if (IsPedDeadOrDying(SecondSecurityPed) and DoesEntityExist(SecondSecurityPed)) then
                                        local deathSource, wep = NetworkGetEntityKillerOfPlayer(SecondSecurityPed)

                                        if deathSource == -1 or deathSource == playerPed then
                                            killer = PlayerId()
                                        end

                                        if deathSource == -1 or deathSource == globalPlayerPedId then
                                            TriggerServerEvent('pacificBankRobbery:server:pedDead', "guard2")
                                            callCops = true
                                        end
                                    end
                            end 
                        end
                    end

                    for i = 1, #Config.PacificBank.randomPeds do
                        if(DoesEntityExist(RandomPeds[i]))then
                            if(Config.PacificBank.randomPeds[i].state)then
                                Wait(500)
                                if (IsPedDeadOrDying(RandomPeds[i]) and DoesEntityExist(RandomPeds[i])) then
                                    Wait(500)
                                    if (IsPedDeadOrDying(RandomPeds[i]) and DoesEntityExist(RandomPeds[i])) then
                                        local deathSource, wep = NetworkGetEntityKillerOfPlayer(RandomPeds[i])

                                        if deathSource == -1 or deathSource == playerPed then
                                            killer = PlayerId()
                                        end
        
                                        if deathSource == -1 or deathSource == globalPlayerPedId then
                                            TriggerServerEvent('pacificBankRobbery:server:pedDead', "randomPeds", i)
                                            callCops = true
                                        end
                                    end
                                end
                            end
                        end
                    end
        end
    end)

    Citizen.CreateThread(function() -- Used for drawing 3d text while the doors are locked/unlocked. Feel free to delete this code if you have it done by your doorlock script.
        while true do
            if(inPoly)then
                    for i = 1, #Config.PacificBank.doors do
                        if(#(globalPlayerCoords - Config.PacificBank.doors[i].objCoords) <= 1.0)then
                            globalClosestDoor = i

                            local closestDoor = GetClosestObjectOfType(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, 1.0, Config.PacificBank.doors[i].objName, false, false, false)

                            if(Config.PacificBank.doors[i].destroyed)then
                                FreezeEntityPosition(closestDoor, false)
                            else
                                if(Config.PacificBank.doors[i].locked)then
                                    FreezeEntityPosition(closestDoor, true)
                                else
                                    FreezeEntityPosition(closestDoor, false)
                                end
                            end

                            if(not Config.PacificBank.doors[i].destroyed)then
                                while(#(globalPlayerCoords - Config.PacificBank.doors[i].objCoords) <= 1.0 and not Config.PacificBank.doors[i].destroyed)do
                                    if(allowedToOpen)then

                                        if(Config.PacificBank.doors[i].locked)then
                                            DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['doorLocked'])
                                        else
                                            DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['doorUnlocked'])
                                        end

                                        if IsControlJustPressed(1, Config.DoorButton) then --If the control is pressed do the below code.
                                            Citizen.Wait(math.random(1,100))
                                            TaskPlayAnim(globalPlayerPed, "anim@heists@keycard@", "exit", 3.0, -1, -1, 50, 0, false, false, false)
                                            TriggerServerEvent("pacificBankRobbery:server:toggleDoorLock", i)
                                            Citizen.Wait(1000)
                                            ClearPedTasks(globalPlayerPed)
                                        else
                                            FreezeEntityPosition(closestDoor, Config.PacificBank.doors[i]["locked"])
                                        end 

                                    else
                                        if(Config.PacificBank.doors[i].locked)then
                                            if exports['np_handler']:isPed("countpolice") >= 5 then
                                                if(Config.PacificBank.doors[i].type == "lockpick")then
                                                    DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['lockpickDoor'])
                                                
                                                    if IsControlJustPressed(1, Config.DoorButton) then --If the control is pressed do the below code.

                                                        if(Config.UseItems)then
                                                            if exports["np-inventory"]:hasEnoughOfItem('lockpick', 1) then
                                                                TriggerEvent("inventory:removeItem", "lockpick", 1)
                                                                TriggerServerEvent("pacificBankRobbery:server:toggleDoorLock", i)
                                                                Citizen.Wait(1000)
                                                                ClearPedTasks(globalPlayerPed)
                                                            else
                                                                exports['mythic_notify']:DoHudText('error', Languages[Config.Language]['notEnoughItems'])
                                                            end
                                                        else
                                                            TriggerServerEvent("pacificBankRobbery:server:toggleDoorLock", i)
                                                            Citizen.Wait(1000)
                                                            ClearPedTasks(globalPlayerPed)
                                                        end
                                                            end
                                                        else
                                                    
                                                            if not robbing and not Config.PacificBank.robbed then
                                                                TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                            end

                                                            Citizen.Wait(math.random(1,100))
                                                            LockpickAnim()
                                                            lockpick(true)

                                                        end
                                                        
                                                    end

                                                elseif(Config.PacificBank.doors[i].type == "thermite")then

                                                    DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['meltDoor'])
                                                
                                                    if IsControlJustPressed(1, Config.DoorButton) then --If the control is pressed do the below code.

                                                        if(Config.UseItems)then
                                                            if exports["np-inventory"]:hasEnoughOfItem('thermite', 1) then
                                                                TriggerEvent("inventory:removeItem", "thermite", 1)
                                                                TriggerServerEvent("pacificBankRobbery:server:toggleDoorLock", i)
                                                                Citizen.Wait(1000)
                                                                ClearPedTasks(globalPlayerPed)
                                                            else

                                                                TriggerEvent('DoLongHudText', Languages[Config.Language]['notEnoughItems'], 2 )
                                                            end
                                                        else
                                                    
                                                            Citizen.Wait(math.random(1,100))

                                                            if not robbing and not Config.PacificBank.robbed then
                                                                TriggerEvent("pacificBankRobbery:client:startRobbery")
                                                            end

                                                            meltDoor(i)

                                                        end
                                                    end
                                                end
                                            else
                                                DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['no_cops'])
                                            end
                                        else
                                            DrawText3D(Config.PacificBank.doors[i].objCoords.x, Config.PacificBank.doors[i].objCoords.y, Config.PacificBank.doors[i].objCoords.z, Languages[Config.Language]['doorUnlockedCriminal'])
                                        end
                                    end

                                    Citizen.Wait(5)
                                end
                            else
                                FreezeEntityPosition(closestDoor, false)
                            end
                        else
                            Citizen.Wait(100)
                        end
                    end
                Citizen.Wait(5)
            else
                Citizen.Wait(500)
            end
        end
    end)

    while true do
            Wait(5)
            local me = globalPlayerPedId
            if inPoly then
                if(not Config.PacificBank.robbed)then
                    
                    if globalIsPedArmed or damagedPed  then --Checks if ped is armed. The check is actually done from garbageCollector.lua for optimization.
                        
                        if globalIsPlayerFreeAiming or globalIsPedShooting == 1 or damagedPed then

                            if(DoesEntityExist(ReceptionPed))then

                                distance = #(globalPlayerCoords - Config.PacificBank.mainReceptionEmployeeCoords)

                                if(distance <= 25)then

                                    if (HasEntityClearLosToEntityInFront(me, ReceptionPed, 19) or HasEntityClearLosToEntityInFront(me, SecurityPed, 19) or HasEntityClearLosToEntityInFront(me, SecondSecurityPed, 19)) and not IsPedDeadOrDying(ReceptionPed) then

                                        if exports['np_handler']:isPed("countpolice") >= 5 then

                                            if not robbing then
                                                TriggerEvent("pacificBankRobbery:client:startRobbery")
                                            end
                                        
                                        else
                                            DrawText3D(Config.PacificBank.mainReceptionEmployeeCoords.x, Config.PacificBank.mainReceptionEmployeeCoords.y, Config.PacificBank.mainReceptionEmployeeCoords.z, Languages[Config.Language]['no_cops'])
                                        end

                                    else
                                        Citizen.Wait(100)
                                    end
                                else
                                    Citizen.Wait(100)
                                end
                            else
                                Citizen.Wait(100)
                            end
                        else
                            Citizen.Wait(100)
                        end
                    else
                        Citizen.Wait(500)
                    end
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(1000)
            end
    end
end)

Citizen.CreateThread(function()
    if(Config.UseBlips)then

        PacificBlip = AddBlipForCoord(Config.PacificBank.blip)

        SetBlipSprite(PacificBlip, 278)
        SetBlipScale(PacificBlip, 1.2)
        SetBlipColour(PacificBlip, 43)  

        SetBlipDisplay(PacificBlip, 4)
        SetBlipAsShortRange(PacificBlip, true)
        

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Central Pacific Bank")
        EndTextCommandSetBlipName(PacificBlip)
    end
end)