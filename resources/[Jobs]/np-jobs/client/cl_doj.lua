local attorney = false
local justice = false
local district = false
local elevator = false
local elevator2 = false
local locked = true

RegisterNetEvent('locked')
AddEventHandler('locked', function(lock)
    locked = lock
end)

RegisterCommand('forcelocks', function(source, args)
    if args[1] == "DOJ" or args[1] == "doj" or args[1] == "Doj" then
        if locked then
            TriggerServerEvent('lock:update', false)
            TriggerEvent('DoLongHudText', 'Unlocked!', 2)
        else
            TriggerServerEvent('lock:update', true)
            TriggerEvent('DoLongHudText', 'Locked!', 2)
        end
    end
end)

function firmElevator()
	while elevator do
		Citizen.Wait(5)
		if IsControlPressed(0, 38) then
            TriggerEvent('np-textui:HideUI')
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            SetEntityCoords(PlayerPedId(), -68.87, -801.81, 43.28)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
		end
        if IsControlPressed(0,47) then
            if locked then
                TriggerServerEvent('lock:update', false)
                TriggerEvent('DoLongHudText', 'Unlocked!', 2)
            else
                TriggerServerEvent('lock:update', true)
                TriggerEvent('DoLongHudText', 'Locked!', 2)
            end
        end
	end
end

function firmElevator2()
	while elevator2 do
		Citizen.Wait(5)
		if IsControlPressed(0, 38) then
            Citizen.Wait(300)
            if not locked then 
                TriggerEvent('np-textui:HideUI')
                DoScreenFadeOut(1000)
                Citizen.Wait(1000)
                SetEntityCoords(PlayerPedId(), -137.21, -624.15, 167.83)
                Citizen.Wait(1000)
                DoScreenFadeIn(1000)
            else
                TriggerEvent('DoLongHudText', 'Building is Locked! Contact DOJ', 2)
            end
		end
        if IsControlPressed(0,47) then
            Citizen.Wait(300)
            if locked then
                TriggerServerEvent('lock:update', false)
                TriggerEvent('DoLongHudText', 'Unlocked!', 2)
            else
                TriggerServerEvent('lock:update', true)
                TriggerEvent('DoLongHudText', 'Locked!', 2)
            end
        end
	end
end

RegisterNetEvent("doj:bill")
AddEventHandler("doj:bill", function()
    local bill = exports["np-keyboard"]:KeyboardInput({
        header = "Create Receipt",
        rows = {
            {
                id = 0,
                txt = "Server ID"
            },
            {
                id = 1,
                txt = "Amount"
            }
        }
    })
    if bill then
        TriggerServerEvent("doj:bill:player", bill[1].input, bill[2].input)
    end
end)

AddEventHandler('np-polyzone:enter', function(name)
	if name == "firm" then
        local myJob = exports["np_handler"]:isPed("myJob")
        if myJob == "judge" or myJob == "district attorney" or myJob == "defender" then
            TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("[E] Elevator | [G] Toggle Lock"))
        else
            TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("[E] Elevator"))
        end
		elevator = true
		firmElevator()
	elseif name == "elevator2" then
        local myJob = exports["np_handler"]:isPed("myJob")
        if myJob == "judge" or myJob == "district attorney" or myJob == "defender" then
            TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("[E] Elevator | [G] Toggle Lock"))
        else
            TriggerEvent('np-textui:ShowUI', 'show', ("%s"):format("[E] Elevator"))
        end
		elevator2 = true
		firmElevator2()
    end
end)


RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "defense" then
		attorney = false
    elseif name == "judge" then
		justice = false
    elseif name == "da" then
		district = false
	elseif name == "firm" then
		elevator = false
	elseif name == "elevator2" then
		elevator2 = false
    end
end)

Citizen.CreateThread(function()
	exports["np-polyzone"]:AddBoxZone("firm", vector3(-137.63, -624.2, 168.82), 2.2, 1.8, {
		name="firm",
		heading=5,
		--debugPoly=true,
		minZ=166.82,
		maxZ=170.82
    })
	exports["np-polyzone"]:AddBoxZone("elevator2", vector3(-68.98, -801.97, 44.23), 2.2, 6.0, {
		name="elevator2",
		heading=341,
		--debugPoly=true,
		minZ=42.03,
		maxZ=46.03
    })
end)