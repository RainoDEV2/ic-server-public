fakeplates = {}

remoteCalls.register("np-garages:select", function(pGarage)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND current_garage = @garage', { ['@cid'] = char.id, ['@garage'] = pGarage}, function(vehicles)
        if vehicles[1] ~= nil then
            for i = 1, #vehicles do
				if vehicles[i].vehicle_state ~= "Out" then
					TriggerClientEvent('np-context:sendMenu', pSrc, {
						{
							id = vehicles[i].id,
							header = vehicles[i].model,
							txt = "Plate: "..vehicles[i].license_plate,
							params = {
								event = "np-garages:attempt:spawn",
								args = {
									id = vehicles[i].id,
									engine = vehicles[i].engine_damage,
									current_garage = vehicles[i].current_garage,
									body = vehicles[i].body_damage,
									model = vehicles[i].model,
									fuel = vehicles[i].fuel, 
									customized = vehicles[i].data,
									plate = vehicles[i].license_plate
								}
							}
						},
					})
				end
            end
        else
            TriggerClientEvent("DoLongHudText", pSrc, "You have no vehicles here!", 2)
            return
        end
	end)
end)


remoteCalls.register("np-garages:selectShared", function(pGarage)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE current_garage = @garage', { ['@garage'] = pGarage}, function(vehicles)
        if vehicles[1] ~= nil then
            for i = 1, #vehicles do
				if vehicles[i].vehicle_state ~= "Out" then
					TriggerClientEvent('np-context:sendMenu', pSrc, {
						{
							id = vehicles[i].id,
							header = vehicles[i].model,
							txt = "Plate: "..vehicles[i].license_plate,
							params = {
								event = "np-garages:attempt:spawn",
								args = {
									id = vehicles[i].id,
									engine = vehicles[i].engine_damage,
									current_garage = vehicles[i].current_garage,
									body = vehicles[i].body_damage,
									model = vehicles[i].model,
									fuel = vehicles[i].fuel, 
									customized = vehicles[i].data,
									plate = vehicles[i].license_plate
								}
							}
						},
					})
				end
            end
        else
            TriggerClientEvent("DoLongHudText", pSrc, "You have no vehicles here!", 2)
            return
        end
	end)
end)



remoteCalls.register("np-garages:attempt:sv", function(data)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()


    local enginePercent = data.engine / 10
	local bodyPercent = data.body / 10
	TriggerClientEvent('np-context:sendMenu', pSrc, {
		{
			id = 1,
			header = "< Go Back",
			txt = "Return to your list of all your vehicles.",
			params = {
				event = "np-garages:open"
			}
		},
		{
			id = 2,
			header = "Take Out Vehicle",
			txt = "Spawn the vehicle!",
			params = {
				event = "np-garages:takeout",
				args = {
					pVeh = data.id
				}
			}
			
		},
		{
			id = 3,
			header = "Vehicle Status",
			txt = "Garage: "..data.current_garage.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
		},
	})
end)


remoteCalls.register("np-garages:managePlates", function(newPlate, oldPlate, param)
	if param == "add" then
		if fakeplates[newPlate] == nil then
			fakeplates[newPlate] = {
				isOn = true,
				oldPlate = oldPlate,
				plate = newPlate

			}
		end
	elseif param == "remove" then
		fakeplates[newPlate] = nil
		json.encode(fakeplates)
	elseif param == "get" then
		return fakeplates
	end
	print(json.encode(fakeplates))
	return fakeplates
end)

remoteCalls.register("np-garages:spawned:get", function(pID)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND id = @id', { ['@cid'] = char.id, ['@id'] = pID}, function(vehicles)
		args = {
			model = vehicles[1].model,
			fuel = vehicles[1].fuel, 
			customized = vehicles[1].data,
			plate = vehicles[1].license_plate,
			engine = vehicles[1].engine_damage,
			body = vehicles[1].body_damage,
		}

		if vehicles[1].current_garage == "Impound Lot" then
			if vehicles[1].vehicle_state == 'Normal Impound' then
				if user:getCash() >= 500 then
					user:removeMoney(500)
					TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
				else
					TriggerClientEvent("DoLongHudText", pSrc, "You need $500", 2)
					TriggerClientEvent("impound:return", pSrc)
					return
				end
			elseif vehicles[1].vehicle_state == 'Police Impound' then
				if user:getCash() >= 1500 then
					user:removeMoney(1500)
					TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
				else
					TriggerClientEvent("DoLongHudText", pSrc, "You need $1500", 2)
					TriggerClientEvent("impound:return", pSrc)
					return
				end
			end
		else
			TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
		end

	end)
end)

remoteCalls.register("np-garages:spawned:getShared", function(pID)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE id = @id', { ['@cid'] = char.id, ['@id'] = pID}, function(vehicles)
		args = {
			model = vehicles[1].model,
			fuel = vehicles[1].fuel, 
			customized = vehicles[1].data,
			plate = vehicles[1].license_plate,
			engine = vehicles[1].engine_damage,
			body = vehicles[1].body_damage,
		}

		if vehicles[1].current_garage == "Impound Lot" then
			if vehicles[1].vehicle_state == 'Normal Impound' then
				if user:getCash() >= 500 then
					user:removeMoney(500)
					TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
				else
					TriggerClientEvent("DoLongHudText", pSrc, "You need $500", 2)
					return
				end
			elseif vehicles[1].vehicle_state == 'Police Impound' then
				if user:getCash() >= 1500 then
					user:removeMoney(1500)
					TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
				else
					TriggerClientEvent("DoLongHudText", pSrc, "You need $1500", 2)
					return
				end
			end
		else
			TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
		end

	end)
end)

remoteCalls.register("np-garages:spawnvehicle", function(coords, heading, stuff)
		local src = source
		local vehicleName = stuff
		if type(coords) ~= 'vector4' then coords = vec4(coords, 90.0) end
		local vehicle = CreateVehicle(vehicleName, coords.x, coords.y, coords.z, heading or 90.0, true, false)
		local timeout = 1000
		while not DoesEntityExist(vehicle) do
			Wait(100)
			timeout = timeout - 1
			if timeout <= 0 then
				return
			end
		end
		return NetworkGetNetworkIdFromEntity(vehicle)
end)


RegisterServerEvent('np-garages:deleteVeh')
AddEventHandler('np-garages:deleteVeh', function(veh)
	DeleteEntity(NetworkGetEntityFromNetworkId(veh))
end)

remoteCalls.register("np-garages:states", function(pState, plate, garage, fuel, bodydamage, enginedamage)
    local pSrc = source
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = ?', {plate}, function(pIsValid)
		if pIsValid[1] then
			pExist = true
			exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, fuel = @fuel, coords = @coords, engine_damage = @engine_damage, body_damage = @body_damage WHERE license_plate = @plate", {
				['garage'] = garage, 
				['state'] = pState, 
				['plate'] = plate,  
				['fuel'] = fuel, 
				['body_damage'] = bodydamage,
				['engine_damage'] = enginedamage,
				['coords'] = nil
			})
		else
			pExist = false
		end
	end)

	Citizen.Wait(100)
	return pExist
end)


RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(vehicleMods,plate)
	vehicleMods = json.encode(vehicleMods)
	exports.ghmattimysql:execute("UPDATE characters_cars SET data=@mods WHERE license_plate = @plate",{['mods'] = vehicleMods, ['plate'] = plate})
end)



RegisterServerEvent('np-imp:ImpoundCar')
AddEventHandler('np-imp:ImpoundCar', function(plate)
	exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, coords = @coords WHERE license_plate = @plate", {['garage'] = 'Impound Lot', ['state'] = 'Normal Impound', ['coords'] = nil, ['plate'] = plate})
end)


RegisterNetEvent("garages:loaded:in", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local owner = char.id

    exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid', { ['@cid'] = owner}, function(vehicles)
		TriggerClientEvent('phone:Garage', src, vehicles)
    end)
end)



function ResetGaragesServer()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE repoed = ?', {"0"}, function(vehicles)
		for k, v in ipairs(vehicles) do
			if v.vehicle_state == "Out" then
				exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state,coords = @coords WHERE license_plate = @plate", {['state'] = 'In', ['coords'] = nil, ['plate'] = v.license_plate})
			end
		end
	end)
end

Citizen.CreateThread(function()
    ResetGaragesServer();
end)

remoteCalls.register("np-garages:impound:request", function(pImpoundReqType, pPlate)
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = ?', {pPlate}, function(pData)
		if pData[1] then
			if pImpoundReqType ~= "scuff" then
				exports.ghmattimysql:execute("UPDATE characters_cars SET current_garage = @current_garage, vehicle_state = @vehicle_state WHERE license_plate = @plate", {
					['current_garage'] = 'Impound Lot', 
					['vehicle_state'] = pImpoundReqType,
					['plate'] = pPlate
				})
			else
				exports.ghmattimysql:execute("UPDATE characters_cars SET current_garage = @current_garage, vehicle_state = @vehicle_state WHERE license_plate = @plate", {
					['current_garage'] = 'T', 
					['vehicle_state'] = "In",
					['plate'] = pPlate
				})
			end
		end
	end)
end)
