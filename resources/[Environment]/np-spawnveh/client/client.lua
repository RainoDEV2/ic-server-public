----------------------
------ COMMANDS ------
----------------------

RegisterCommand("extra", function(source, args, rawCommand)
	if exports["np_handler"]:isPed("myjob") == "police" then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		local extraID = tonumber(args[1])
		local extra = args[1]
		local toggle = tostring(args[2])
		for k,v in pairs(Config.PoliceGarage) do 
			if IsPedInAnyVehicle(ped, true) then
				local veh = GetVehiclePedIsIn(ped, false)
				if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
					if toggle == "true" then
						toggle = 0
					end
					if veh ~= nil and veh ~= 0 and veh ~= 1 then
						TriggerEvent('DoLongHudText', 'Extra Toggled', 1)
				
						if extra == "all" then
							SetVehicleExtra(veh, 1, toggle)
							SetVehicleExtra(veh, 2, toggle)
							SetVehicleExtra(veh, 3, toggle)
							SetVehicleExtra(veh, 4, toggle)
							SetVehicleExtra(veh, 5, toggle)       
							SetVehicleExtra(veh, 6, toggle)
							SetVehicleExtra(veh, 7, toggle)
							SetVehicleExtra(veh, 8, toggle)
							SetVehicleExtra(veh, 9, toggle)               
							SetVehicleExtra(veh, 10, toggle)
							SetVehicleExtra(veh, 11, toggle)
							SetVehicleExtra(veh, 12, toggle)
							SetVehicleExtra(veh, 13, toggle)
							SetVehicleExtra(veh, 14, toggle)
							SetVehicleExtra(veh, 15, toggle)
							SetVehicleExtra(veh, 16, toggle)
							SetVehicleExtra(veh, 17, toggle)
							SetVehicleExtra(veh, 18, toggle)
							SetVehicleExtra(veh, 19, toggle)
							SetVehicleExtra(veh, 20, toggle)
						TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
						elseif extraID == extraID then
							SetVehicleExtra(veh, extraID, toggle)
						end
					end
				end
			end
		end
	elseif exports["np_handler"]:isPed("myjob") == "ems" then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		local extraID = tonumber(args[1])
		local extra = args[1]
		local toggle = tostring(args[2])
		for k,v in pairs(Config.EMSGarage) do 
			if IsPedInAnyVehicle(ped, true) then
				local veh = GetVehiclePedIsIn(ped, false)
				if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
					if toggle == "true" then
						toggle = 0
					end
				end
				if veh ~= nil and veh ~= 0 and veh ~= 1 then
					TriggerEvent('DoLongHudText', 'Extra Toggled', 1)
					
					if extra == "all" then
						SetVehicleExtra(veh, 1, toggle)
						SetVehicleExtra(veh, 2, toggle)
						SetVehicleExtra(veh, 3, toggle)
						SetVehicleExtra(veh, 4, toggle)
						SetVehicleExtra(veh, 5, toggle)       
						SetVehicleExtra(veh, 6, toggle)
						SetVehicleExtra(veh, 7, toggle)
						SetVehicleExtra(veh, 8, toggle)
						SetVehicleExtra(veh, 9, toggle)               
						SetVehicleExtra(veh, 10, toggle)
						SetVehicleExtra(veh, 11, toggle)
						SetVehicleExtra(veh, 12, toggle)
						SetVehicleExtra(veh, 13, toggle)
						SetVehicleExtra(veh, 14, toggle)
						SetVehicleExtra(veh, 15, toggle)
						SetVehicleExtra(veh, 16, toggle)
						SetVehicleExtra(veh, 17, toggle)
						SetVehicleExtra(veh, 18, toggle)
						SetVehicleExtra(veh, 19, toggle)
						SetVehicleExtra(veh, 20, toggle)
						TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
					elseif extraID == extraID then
						SetVehicleExtra(veh, extraID, toggle)
					end
					
				end
			end
		end
	end
end, false)
  
RegisterCommand('fix', function(source)
	if exports["np_handler"]:isPed("myjob") == "police" then
		policeFix()
	elseif exports["np_handler"]:isPed("myjob") == "ems" then
		EMSFix()
	end
end,false)


RegisterCommand('boat', function(source, args)
	if exports["np_handler"]:isPed("myjob") == "police" then
      TriggerEvent('iciest :spawnVehicle', 'predator')
	else
		TriggerEvent('DoLongHudText', 'You are not Police!', 1)
  end
end)

RegisterCommand('livery', function(source, args, raw)
	local coords = GetEntityCoords(PlayerPedId())
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local job = exports["np_handler"]:isPed("myjob")
	if job == 'police' or job == 'ems' and GetVehicleLiveryCount(vehicle) - 1 >= tonumber(args[1]) then
		SetVehicleLivery(vehicle, tonumber(args[1]))
		TriggerEvent('DoLongHudText', 'Livery Set', 1)
	else
		TriggerEvent('DoLongHudText', 'You are not a police officer!', 2)
	end
end)

RegisterCommand('tint', function(source, args, raw)
	local job = exports["np_handler"]:isPed("myjob")
	if job == 'police' or job == 'ems' then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		TriggerEvent('DoLongHudText', 'Vehicle Has Been Tinted', 1)
		SetVehicleModKit(vehicle, 0)
		SetVehicleWindowTint(vehicle, tonumber(args[1]))
	end
end)

RegisterCommand("svlistuc", function(source, args, rawCommand)
	if exports["np_handler"]:isPed("myjob") == "police" then
		TriggerEvent('chatMessagess', 'Undercover Vehicles:', 2, " \n [14] Galivanter Baller (UC) \n [15] Bravado Banshee (UC) \n [16] Bravado Buffalo (UC) \n [17] Pfister Comet (UC) \n [18] Invetero Coquette (UC) \n [19] Albany Primo (UC) \n [20] Declasse Rancher (UC) \n [21] Albany Washington (UC) ")
	end
end)


RegisterCommand("door", function(source, args, raw)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	local Driver = GetPedInVehicleSeat(veh, -1)
	
	if args[1] ~= nil then
		door = tonumber(args[1]) - 1
	else
		door = nil
	end

	if door ~= nil then
		if DoesEntityExist(Driver) and IsPedInAnyVehicle(ped, false) then
			if GetVehicleDoorAngleRatio(veh, door) > 0 then
				SetVehicleDoorShut(veh, door, false)
			else	
				SetVehicleDoorOpen(veh, door, false, false)
			end
		end
	end
end)

RegisterCommand('seat', function(source, args)
	if args[1] ~= nil and tonumber(args[1]) >= 1 and tonumber(args[1]) <= 4 then
	  TriggerEvent('car:swapseat', tonumber(args[1]) - 2)
	end
end)


-----------------------
------ NETEVENTS ------
-----------------------

RegisterNetEvent('animation:impound')
AddEventHandler('animation:impound', function()
		inanimation = true
		local lPed = PlayerPedId()
		RequestAnimDict("amb@code_human_police_investigate@idle_a")
		while not HasAnimDictLoaded("amb@code_human_police_investigate@idle_a") do
			Citizen.Wait(0)
		end
		
		if IsEntityPlayingAnim(lPed, "amb@code_human_police_investigate@idle_a", "idle_b", 3) then
			ClearPedSecondaryTask(lPed)
		else
			TaskPlayAnim(lPed, "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, -8, -1, 49, 0, 0, 0, 0)
			seccount = 4
			while seccount > 0 do
				Citizen.Wait(1000)
				seccount = seccount - 1
			end
			ClearPedSecondaryTask(lPed)
		end		
		inanimation = false
end)

RegisterNetEvent('PDSpawnVeh')
AddEventHandler('PDSpawnVeh', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "2011 Crown Victoria",
			txt = "Old Rust Bucket!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polvic2"
				}
            }
        },
		{
            id = 3,
            header = "2014 Ford Taurus",
			txt = "Everyone's Favourite Car!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "poltaurus"
				}
            }
        },
		{
            id = 4,
            header = "2014 Ford Explorer",
			txt = "City boys car",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "explorer14"
				}
            }
        },
		{
            id = 5,
            header = "2014 Dodge Charger",
			txt = "Flex Your Rank Playa!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polchar"
				}
            }
        },
		{
            id = 6,
            header = "2015 Chevy Tahoe",
			txt = "Noone Drives This Shit!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "poltah"
				}
            }
        },
		{
            id = 7,
            header = "Mesa Mountain Patrol",
			txt = "Hunting Patrols only",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polmesa"
				}
            }
        },
		{
            id = 8,
            header = "Undercover Felon",
			txt = "Major Crime Only",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polfelon"
				}
            }
        },
		{
            id = 9,
            header = "Zr1 Interceptor",
			txt = "Catch me if you can!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "zr1rb"
				}
            }
        },
		{
            id = 10,
            header = "2015 Mustang Interceptor",
			txt = "The one and only",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "2015polstang"
				}
            }
        },
		{
            id = 11,
            header = "Raiden Interceptor",
			txt = "Protect the environment",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polraiden"
				}
            }
        },
		{
            id = 12,
            header = "Police Moto",
			txt = "Protect the environment",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polglide"
				}
            }
        },
		{
            id = 13,
            header = "S.W.A.T Bearcat",
			txt = "Not BP For Travis To Reverse!",
			params = {
                event = "spawn:large:riot:pd",
            }
        },
		{
            id = 14,
            header = "Prison Bus",
			txt = "The Driver Is Dying!",
			params = {
                event = "spawn:large:pbus:pd",
            }
        },
    })
end)

RegisterNetEvent('SandyPDSpawnVeh')
AddEventHandler('SandyPDSpawnVeh', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "2011 Crown Victoria",
			txt = "Old Rust Bucket!",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "polvic2"
				}
            }
        },
		{
            id = 3,
            header = "2014 Ford Taurus",
			txt = "Everyone's Favourite Car!",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "poltaurus"
				}
            }
        },
		{
            id = 4,
            header = "2014 Ford Explorer",
			txt = "City boys car",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "explorer14"
				}
            }
        },
		{
            id = 5,
            header = "2014 Dodge Charger",
			txt = "Flex Your Rank Playa!",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "polchar"
				}
            }
        },
		{
            id = 6,
            header = "2015 Chevy Tahoe",
			txt = "Noone Drives This Shit!",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "poltah"
				}
            }
        },
		{
            id = 7,
            header = "Mesa Mountain Patrol",
			txt = "Hunting Patrols only",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "polmesa"
				}
            }
        },
		{
            id = 8,
            header = "Undercover Felon",
			txt = "Major Crime Only",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "polfelon"
				}
            }
        },
		{
            id = 9,
            header = "Zr1 Interceptor",
			txt = "Catch me if you can!",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "zr1rb"
				}
            }
        },
		{
            id = 10,
            header = "2015 Mustang Interceptor",
			txt = "The one and only",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "2015polstang"
				}
            }
        },
		{
            id = 11,
            header = "Raiden Interceptor",
			txt = "Protect the environment",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "polraiden"
				}
            }
        },
		{
            id = 12,
            header = "Police Moto",
			txt = "Protect the environment",
			params = {
                event = "spawn:veh:sandypd",
				args = {
					vehicle = "polglide"
				}
            }
        },
		{
            id = 13,
            header = "S.W.A.T Bearcat",
			txt = "Not BP For Travis To Reverse!",
			params = {
                event = "spawn:large:riot:sandypd",
            }
        },
		{
            id = 14,
            header = "Prison Bus",
			txt = "The Driver Is Dying!",
			params = {
                event = "spawn:large:pbus:sandypd",
            }
        },
    })
end)

RegisterNetEvent('EMSSpawnVeh')
AddEventHandler('EMSSpawnVeh', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "EMS Garage",
            txt = ""
        },
        {
            id = 2,
            header = "2018 Vapid Speedo",
			txt = "Get In My Van!",
			params = {
                event = "spawn:veh:ems",
				args = {
					vehicle = "emsnspeedo"
				}
            }
        },
		{
            id = 3,
            header = "2014 Dodge Charger",
			txt = "Everyone's Favorite Car!",
			params = {
                event = "spawn:veh:ems",
				args = {
					vehicle = "emsc"
				}
            }
        },
		{
            id = 4,
            header = "2016 Ford F350",
			txt = "Big Boy/Girl Car!",
			params = {
                event = "spawn:veh:ems",
				args = {
					vehicle = "emsf"
				}
            }
        },
		{
            id = 5,
            header = "Wheelchair",
			txt = "What happen to my legs?",
			params = {
                event = "spawn:veh:ems",
				args = {
					vehicle = "npwheelchair"
				}
            }
        },
    })
end)

RegisterNetEvent('spawn:veh:pd')
AddEventHandler('spawn:veh:pd', function(type)
	SpawnVehPD(type.vehicle)	
end)

RegisterNetEvent('spawn:veh:sandypd')
AddEventHandler('spawn:veh:sandypd', function(type)
	SpawnVehSandyPD(type.vehicle)	
end)

RegisterNetEvent('spawn:veh:ems')
AddEventHandler('spawn:veh:ems', function(type)
	SpawnVehEMS(type.vehicle)	
end)

RegisterNetEvent('spawn:boat:pd')
AddEventHandler('spawn:boat:pd', function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("Predator")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, -803.27734375, -1490.6260986328, 0.12055593729019, 109.24285125732, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleLivery(vehicle, tonumber(3))
    end)
end)

RegisterNetEvent('spawn:large:riot:pd')
AddEventHandler('spawn:large:riot:pd', function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("riot")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 451.25408935547, -975.93743896484, 25.69979095459, 85.700180053711, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleLivery(vehicle, tonumber(3))
    end)
end)

RegisterNetEvent('spawn:large:pbus:pd')
AddEventHandler('spawn:large:pbus:pd', function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("pbus")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 478.42590332031, -1019.6999511719, 28.2419090271, 270.94979858398, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleLivery(vehicle, tonumber(3))
    end)
end)

RegisterNetEvent('spawn:large:riot:sandypd')
AddEventHandler('spawn:large:riot:sandypd', function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("riot")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 1868.9719238281, 3694.1452636719, 33.271518707275, 208.77436828613, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleLivery(vehicle, tonumber(3))
    end)
end)

RegisterNetEvent('spawn:large:pbus:sandypd')
AddEventHandler('spawn:large:pbus:sandypd', function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("pbus")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 1868.9719238281, 3694.1452636719, 33.271518707275, 208.77436828613, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleLivery(vehicle, tonumber(3))
    end)
end)

RegisterNetEvent("spawn:hei:pd")
AddEventHandler("spawn:hei:pd", function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("polas350")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 449.53030395508, -981.98162841797, 43.691337585449, 5.8439383506775, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleLivery(vehicle, tonumber(3))
    end)
end)


RegisterNetEvent("spawn:hei:ems")
AddEventHandler("spawn:hei:ems", function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("emsair")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 351.47665405273, -588.42498779297, 74.161720275879, 252.28114318848, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)    
    end)
end)

RegisterNetEvent("spawn:boat:pd")
AddEventHandler("spawn:boat:pd", function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("libertyboat")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, -786.59112548828, -1498.8815917969, -0.47412407398224, 105.11709594727, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)    
    end)
end)


-----------------------
------ FUNCTIONS ------
-----------------------


function SpawnVehPD(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 451.25408935547, -975.93743896484, 25.69979095459, 85.700180053711, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        applyMaxUpgrades(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
    
    end)
end

function SpawnVehSandyPD(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 1883.0260009766, 3698.3820800781, 32.832496643066, 31.329174041748, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        applyMaxUpgrades(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
    
    end)
end

function SpawnVehEMS(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointEMS(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 333.15982055664, -576.3837890625, 28.796867370605, 338.55960083008, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end

    end)
end

function SpawnVehBoat(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointEMS(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, -786.59112548828, -1498.8815917969, -0.47412407398224, 105.11709594727, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end

    end)
end

function applyMaxUpgrades(veh)
	SetVehicleModKit(veh, 0)
    SetVehicleMod(veh, 16, 4, false)
end

function findClosestSpawnPointPD(pCurrentPosition)
	local coords = vector3(451.25408935547, -975.93743896484, 25.69979095459)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

function findClosestSpawnPointEMS(pCurrentPosition)
	local coords = vector3(333.15982055664, -576.3837890625, 28.796867370605)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

function policeFix()
	local ped = PlayerPedId()
	for k,v in pairs(Config.PoliceGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				TriggerEvent('DoLongHudText', 'Your vehicle is being repaired please wait', 1)
				local finished = exports["np-taskbar"]:taskBar(5000, "Completing Task")
				if finished == 100 then
					TriggerEvent('DoLongHudText', 'Your vehicle has been repaired', 1)
					SetVehicleFixed(veh)
					SetVehicleDirtLevel(veh, 0.0)
					exports["np-carhud"]:SetFuel(veh, 100)
				end
			end
		end
	end
end

function EMSFix()
	local ped = PlayerPedId()
	for k,v in pairs(Config.EMSGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				TriggerEvent('DoLongHudText', 'Your vehicle is being repaired please wait', 1)
				local finished = exports["np-taskbar"]:taskBar(5000, "Completing Task")
				if finished == 100 then
					TriggerEvent('DoLongHudText', 'Your vehicle has been repaired', 1)
					SetVehicleFixed(veh)
					SetVehicleDirtLevel(veh, 0.0)
					exports["np-carhud"]:SetFuel(veh, 100)
				end
			end
		end
	end
end

