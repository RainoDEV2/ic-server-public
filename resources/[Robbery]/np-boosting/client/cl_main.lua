local availableRuns = {}
local currentRun = {}
local currentRuns = {}
-- local inRun = false
local boostBlip = nil
local CurrentMarker = nil
local isCop = false
local blips = {}
local dropofflocations = {
    ["S"] = {
        vector3(-423.20794677734, -1683.4301757812, 19.029085159302),
        vector3(-891.93548583984, -339.39764404297, 34.534271240234)
    },
    ["A"] = {
        vector3(-733.90832519531, -282.13204956055, 36.948928833008),
        vector3(-1383.7869873047, -476.05444335938, 31.58863067627)
    },
    ["B"] = {
        vector3(-1305.8635253906, -198.2911529541, 42.444953918457),
        vector3(-830.24786376953, -393.41479492188, 31.325252532959)
    },
    ["C"] = {
        vector3(18.094898223877, -1063.3455810547, 38.15161895752)
    },
}

local near = false 
RegisterNetEvent('receiveCoords')
AddEventHandler('receiveCoords', function(runs)
    availableRuns = runs
end)

RegisterNetEvent('np-boosting:getNetworkEntity')
AddEventHandler('np-boosting:getNetworkEntity', function(veh)
    currentRun.entityId = veh
end)

RegisterNetEvent('np-boosting:currentRuns')
AddEventHandler('np-boosting:currentRuns', function(table)
    currentRuns = table
end)


RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ems" then isMedic = false isInService = false end
    if isCop and job ~= "police" then isCop = false isInService = false end
    if isNews and job ~= "news" then isNews = false end
    if job == "police" then isCop = true isInService = true end
    if job == "ems" then isMedic = true isInService = true end
    if job == "news" then isNews = true end
end)

RegisterCommand('cancelrun', function()
    if inRun then
        TriggerServerEvent('np-boosting:deleteVeh', currentRun.entityId)
        currentRun = nil
        here = false
        droppingoff = false
        inRun = false
        TriggerEvent('DoLongHudText', "You have cancelled your run, if this was due to scuff please do /bug with all the information you can.", 2)
    end
end)


RegisterNetEvent('np-boosting:addAccess')
AddEventHandler('np-boosting:addAccess', function(args)
    local keyboard = exports["np-keyboard"]:KeyboardInput({
        header = "Add User!",
        rows = {
            {
                id = 0,
                txt = "CID"
            },
        }
    })
    if keyboard[1].input == nil then return end
    remoteCalls.execute('np-boosting:addAccess', tonumber(keyboard[1].input), args.user, args.pass)
end)

RegisterNetEvent('np-boosting:contract')
AddEventHandler('np-boosting:contract', function(args)
    for i = 1, #currentRuns do
        if tonumber(args.id) == currentRuns[i] then
            TriggerEvent('DoLongHudText', 'Run is Taken! Close this menu to refresh the list!', 2)
            return
        end
    end
    local location = vector3(args.location.x,args.location.y,args.location.z)
    if inRun then
        TriggerEvent("DoLongHudText", "Currently in a run!", 2)
        return 
    end
    if args.tier <= 0 and args.class == "B" then
        TriggerEvent("DoLongHudText", "Not Enough Reputation", 2)
        return
    end
    if args.tier <= 1 and args.class == "A" then
        TriggerEvent("DoLongHudText", "Not Enough Reputation", 2)
        return
    end
    if args.tier <= 2 and args.class == "S" then
        TriggerEvent("DoLongHudText", "Not Enough Reputation", 2)
        return
    end
        currentRun = {
        car = args.car, 
        class = args.class, 
        coords = location, 
        plate = args.plate, 
        user = args.user, 
        pass = args.pass,
        entityId = 0,
        id = args.id,
        plate = 0
        }
        TriggerEvent("chatMessage", "EMAIL - Boosting", 8, "Hey Bro! The car is a  " .. args.class .. " class " .. args.car .. " I last saw it around " .. GetStreetNameFromHashKey(GetStreetNameAtCoord(location.x, location.y, location.z)))
        near = true
        isNearVehicle(location, args.car, args.class, args.id, args.head)
        handleBlip(location)
        TriggerServerEvent('np-boosting:currentRuns', "add", tonumber(args.id), args.class)

        table.remove(availableRuns, args.index)
        TriggerServerEvent('np-boosting:updateRuns', availableRuns)
        inRun = true
end)


RegisterNetEvent('np-boosting:contracts')
AddEventHandler('np-boosting:contracts', function(reputation, username, password)
    local cuck = {}
    local poop = 0
    -- availableRuns = remoteCalls.execute("np-boosting:availableruns")
    TriggerServerEvent('updateCoords')
    if availableRuns ~= nil then
        currentRuns = {}
        table.insert(cuck, {
            id = 1,
            header = "Welcome! " .. username .. " | Current Rep: " .. reputation,
            txt = "",
        })
        table.insert(cuck, {
            id = 2,
            header = "Manage Access!",
            txt = "",
            params = {
                event = "np-boosting:manage",
                args = {
                    user = username,
                    pass = password,
                }
            }
        })
        table.insert(cuck, {
            id = 3,
            header = "Add Access!",
            txt = "",
            params = {
                event = "np-boosting:addAccess",
                args = {
                    user = username,
                    pass = password,
                }
            }
        })
        table.insert(cuck, {
            id = 4,
            header = "Available Contracts",
            txt = "View Available Contracts Below",
        })

        if reputation >= 0 and reputation <= 25 then
            poop = 0
        elseif reputation >= 26 and reputation <= 35 then
           poop = 1
        elseif reputation >= 36 and reputation < 60 then
            poop = 2
        elseif reputation >= 60 then
            poop = 3
        end


        for i = 1, #availableRuns do 
            local display = tostring(GetDisplayNameFromVehicleModel(availableRuns[i].car))
            local tier = tostring(availableRuns[i].class)
            local display2 = display:lower()
            local display3 = display2:gsub("^%l", string.upper)
            local tempTable = {}
            table.insert(cuck, {
                id = #cuck+1,
                header = "Contract #" .. #cuck+1 .. " Class: " .. availableRuns[i].class,
                txt = availableRuns[i].descrip,
                params = {
                    event = "np-boosting:contract",
                    args = {
                        index = i,
                        id = availableRuns[i].id,
                        car = display3,
                        class = tier,
                        location = availableRuns[i].location,
                        plate = availableRuns[i].plate,
                        tier = poop,
                        user = username,
                        pass = password,
                        head = heading
                    }
                }
            })
        end
        TriggerEvent('np-context:sendMenu', cuck)
    else
        TriggerEvent('DoLongHudText', 'No contracts available', 2)
    end
end)


RegisterNetEvent('np-boosting:manage')
AddEventHandler('np-boosting:manage', function(args)
    local accounts = remoteCalls.execute('np-boosting:getAccounts', args.user, args.pass)
end)

RegisterNetEvent('np-boosting:usermanagement')
AddEventHandler('np-boosting:usermanagement', function(args)
    TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Remove Access",
            txt = "Remove Users Access",
            params = {
                event = "np-boosting:remove",
                args = {
                    id = args.id,
                    user = args.user,
                    pass = args.pass,
                    cid = args.cid
                },
            },
        },
    })
end)

RegisterNetEvent('np-boosting:remove')
AddEventHandler('np-boosting:remove', function(args)
    local result = remoteCalls.execute('np-boosting:removeAccess', args.id, args.user, args.pass, args.cid)
end)


RegisterNetEvent('np-boosting:menu')
AddEventHandler('np-boosting:menu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "New? Create an Account!",
            txt = "Use this to create an account!",
            params = {
                event = "np-boosting:login",
                args = {
                    status = "new"
                },
            },
        },
        {
            id = 2,
            header = "Sign in!",
			txt = "Use this to sign in",
			params = {
                event = "np-boosting:login",
                args = {
                    status = "sign"
                }
            }
        },
    })
end)

RegisterNetEvent('np-boosting:login')
AddEventHandler('np-boosting:login', function(args)
    local credentials = login(args.status)
    local login = remoteCalls.execute('np-boosting:getDB', credentials[1].input, credentials[2].input, args.status)
end)

RegisterNetEvent('np-boosting:addBlip')
AddEventHandler('np-boosting:addBlip', function(id, veh)
    local vehicle = NetworkGetEntityFromNetworkId(veh)
    if isCop then
        blips[id] = carBlip
        carBlip = AddBlipForEntity(vehicle)
        SetBlipSprite(carBlip,229)
    end
end)

RegisterNetEvent('np-boosting:removeBlip')
AddEventHandler('np-boosting:removeBlip', function(id, veh)
    local vehicle = NetworkGetEntityFromNetworkId(veh)
    if isCop then
        -- carBlip = AddBlipForEntity(vehicle)
        -- table.insert(blips, carBlip)
        -- SetBlipSprite(carBlip,229)
        RemoveBlip(blips[id])
        blips[id] = nil
    end
end)
function login(status)
    if status == "new" then
        local keyboard = exports["np-keyboard"]:KeyboardInput({
            header = "Boosting Create an Account!",
            rows = {
                {
                    id = 0,
                    txt = "Username"
                },
                {
                    id = 1,
                    txt = "Password"
                }
            }
        })
        if keyboard[1].input == nil then return end
        if keyboard[2].input == nil then return end
        return keyboard
    elseif status == "sign" then
        local keyboard = exports["np-keyboard"]:KeyboardInput({
            header = "Boosting Login",
            rows = {
                {
                    id = 0,
                    txt = "Username"
                },
                {
                    id = 1,
                    txt = "Password"
                }
            }
        })
        if keyboard[1].input == nil then return end
        if keyboard[2].input == nil then return end
        return keyboard
    end
end


local here = false


local droppingoff = false

function isNearVehicle(location, car, class, id, heading)
    local playerPed = PlayerPedId()
    local spawned = false
    local notify = false
    Citizen.CreateThread(function()
        while near do
            Citizen.Wait(1000)
            local dist = #(location - GetEntityCoords(playerPed))
            if dist <= 5 then
                if not notify then
                    TriggerEvent("chatMessage", "EMAIL - Boosting", 8, 'I see you around the area, make sure the plate for the car is ' .. currentRun.plate)
                    notify = true
                end
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    if GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)) == currentRun.plate then
                        TriggerEvent("chatMessage", "EMAIL - Boosting", 8, 'Congrats! You have found the vehicle now take it to the location.')
                        local chance = math.random(1, 10)
                        if chance >= 4 then 
                            TriggerEvent('DoLongHudText', 'OH SHIT! We just got a bait car disable the tracker quick!')
                            startSignal()
                            tracker = true
                        end
                            RemoveBlip(boostBlip)
                            droppingoff = true
                            dropOff(class)
                        break
                    end
                end
            elseif dist <= 100 then
                if not spawned then
                    local plate = remoteCalls.execute("np-boosting:spawnVehicle", location, car, class, id, heading)
                    -- local veh = NetworkGetEntityFromNetworkId(netID)
                    local chance = math.random(1,10)
                    -- TriggerServerEvent("np-boosting:addBlip", id, netID)
                    currentRun.plate = plate
                    spawned = true
                end
            end
        end
    end)
end


RegisterCommand('startSignal', function()
    tracker = true
    startSignal()
end)



RegisterNetEvent("hacking:boosting")
AddEventHandler('hacking:boosting', function()
    if inRun and tracker and GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)) == currentRun.plate then
		TriggerEvent("mhacking:show")
        TriggerEvent("mhacking:start",7,30, hacking)
    else
        TriggerEvent("DoLongHudText", 'Vehicle does not have a tracker.', 2)
    end
end)

function hacking(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        tracker = false
        TriggerEvent('DoLongHudText', 'You have disabled the tracker!', 2)
    end
  TriggerEvent('mhacking:hide')
end

function startSignal()
    Citizen.CreateThread(function()
        local alert = false
        while tracker do 
            Citizen.Wait(5000)
            local vehicle = NetworkGetEntityFromNetworkId(currentRun.entityId)
            if DoesEntityExist(vehicle) then
                local coords = GetEntityCoords(vehicle)
                if not alert then
                    TriggerEvent("boostingAlert", coords, currentRun.entityId, currentRun.plate)
                    alert = true
                else
                    TriggerEvent('np-alerts:boost', coords, currentRun.plate)
                end
            end
        end
    end)
    
end

function dropOff(class)
    local coords = dropofflocations[class][math.random(1,#dropofflocations[class])]
    BlipCreation(coords)
    Citizen.CreateThread(function()
        while droppingoff do
            Citizen.Wait(1000)
            local dist = #(coords - GetEntityCoords(PlayerPedId()))
            if dist <= 5 then
                if GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)) == currentRun.plate then
                    here = true
                    left(coords, NetworkGetNetworkIdFromEntity(GetVehiclePedIsIn(PlayerPedId(), false)))
                    TriggerEvent("chatMessage", "EMAIL - Boosting", 8, 'You have arrived. Park the car and get out!.')
                    droppingoff = false
                    break
                else
                    TriggerEvent("chatMessage", "EMAIL - Boosting", 8, 'You brought the wrong bloody car WTF? Get out of here and do not come back!.')
                        inRun = false
                        droppingoff = false
                    break
                end
            end
        end
    end)


end



function left(coord, entity)
    Citizen.CreateThread(function()
        while here do
            Citizen.Wait(15000)
            local dist = #(coord - GetEntityCoords(PlayerPedId()))
            local number = 23231423423423423423
            if dist >= 20 then
                TriggerServerEvent('deletecar', entity)
                TriggerEvent("chatMessage", "EMAIL - Boosting", 8, 'Vehicle has been disposed of, come back for more jobs anytime!.')
                TriggerServerEvent('np-boosting:yourmom', currentRun.class, number)
                TriggerServerEvent('np-boosting:addRep', currentRun.user, currentRun.pass, number)
                inRun = false
                currentRun = nil
                ClearBlips()
                break
            end
        end
    end)
end



function BlipCreation(location)
    ClearBlips()
        CurrentMarker = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(CurrentMarker, 524)
        SetBlipScale(CurrentMarker, 1.0)
        SetBlipColour(CurrentMarker, 84)
        SetBlipAsShortRange(CurrentMarker, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Drop off Vehicle")
        EndTextCommandSetBlipName(CurrentMarker)
end

function ClearBlips()
    RemoveBlip(CurrentMarker)
    CurrentMarker = 0
end


function handleBlip(location)
    local alpha = math.random(200, 250)
    boostBlip = AddBlipForRadius(location, 125.0)
    SetBlipHighDetail(boostBlip, true)
    SetBlipColour(boostBlip, 1)
    SetBlipAlpha(boostBlip, alpha)
    SetBlipAsShortRange(boostBlip, true)
end