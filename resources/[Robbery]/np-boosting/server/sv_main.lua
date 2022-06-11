
local descriptions = {'Hey, My name is Bob, I saw a nice car for my babe she is so rad and I want to get her the best present!', 'Looking for a car hmu ASAP.', 'I need a car really fucking quick', 'I will pay you what you want but I need to leave the city', 'looking for a high tier car but will take anything'}

local availableRuns = {}

local currentRuns = {}

local cars = 
{ 
    ["S"] = {
        [1] = 'cyclone',
        [2] = 'furia',
        [3] = 'italigtb2',
        [4] = 'sc1',
        [5] = 'taipan',
        [6] = 'voltic',
        
    },
   ["A"] = {
    [1] = 'banshee',
    [2] = 'coquette',
    [3] = 'hotring',
    [4] = 'massacro',
    [5] = 'revolter',
    [6] = 'jester',
    

   },
   ["B"] = {
    [1] = 'sultan',
    [2] = 'schafter3',
    [3] = 'fugitive',
    [4] = 'glendale2',
    [5] = 'premier',

   },
   ["C"] = {
    [1] = 'panto',
    [2] = 'tractor',
    [3] = 'prairie',
    [4] = 'minivan',
    [5] = 'surfer',
    [6] = 'dloader'
   }
}



local coords = {
    ["S"] = {
        [1] = { taken = false, coords = vector4(218.64408874512, 756.85815429688, 204.72100830078, 55.525238037109)},
        [2] = { taken = false, coords = vector4(-123.39788818359, 1005.1462402344, 235.73211669922, 202.98281860352)},
        [3] = { taken = false, coords = vector4(-163.26098632812, 933.49975585938, 235.65573120117, 223.4577331543)},
        [4] = { taken = false, coords = vector4(-170.73048400879, 969.11145019531, 237.11364746094, 315.82736206055)},
        [5] = { taken = false, coords = vector4(318.98724365234, 495.05194091797, 152.69566345215, 293.03701782227)},
        [6] = { taken = false, coords = vector4(16.143028259277, 375.56207275391, 112.27304077148, 57.276458740234)},
        [7] = { taken = false, coords = vector4(-385.9944152832, 1206.6556396484, 325.09631347656, 99.264488220215)}, -- Gallileo Observatory
        [8] = { taken = false, coords = vector4(-2336.9560546875, 287.70770263672, 168.92292785645, 292.82397460938)}, -- Kortz Center
        [9] = { taken = false, coords = vector4(-2013.9849853516, -354.01565551758, 47.561294555664, 53.414806365967)}, -- The Jetty
        [10] = { taken = false, coords = vector4(-1896.6431884766, -317.87908935547, 48.6943359375, 232.68510437012)}, --The Crastenburg
        [11] = { taken = false, coords = vector4(-1993.3406982422, 294.41763305664, 91.219627380371, 16.759004592896)}, -- North Rockford Drive
        [12] = { taken = false, coords = vector4(-1359.4666748047, 553.53503417969, 129.21417236328, 54.670425415039)}, -- Hangman Ave
        [13] = { taken = false, coords = vector4(-935.87365722656, 202.02969360352, 66.858497619629, 165.75053405762)}, -- Castle
    },
   ["A"] = {
        [1] = { taken = false, coords = vector4(-491.58337402344, 196.95297241211, 70.326622009277, 355.96478271484)},
        [2] = { taken = false, coords = vector4(-488.01190185547, 164.21450805664, 70.326972961426, 87.283737182617)},
        [3] = { taken = false, coords = vector4(-622.86358642578, 201.0764465332, 70.462585449219, 359.73480224609)},
        [4] = { taken = false, coords = vector4(-1094.6870117188, 439.64031982422, 74.680931091309, 87.509468078613)},
        [5] = { taken = false, coords = vector4(460.29949951172, -1095.1063232422, 28.596607208252, 269.03427124023)},
        [6] = { taken = false, coords = vector4(617.78619384766, 621.07611083984, 128.36602783203, 251.64009094238)}, -- Vinewood Bowl
        [7] = { taken = false, coords = vector4(198.14521789551, 1231.7957763672, 224.91484069824, 283.52740478516)}, -- Sisyphus Theatre
        [8] = { taken = false, coords = vector4(-1782.7012939453, -508.01248168945, 38.232116699219, 302.8532409668)}, -- Bay City Ave Parking
        [9] = { taken = false, coords = vector4(-1680.0435791016, -297.27551269531, 51.268375396729, 144.45204162598)}, -- The Church
        [10] = { taken = false, coords = vector4(-1697.0184326172, 59.661598205566, 64.348457336426, 162.07025146484)}, -- Americano/School Car park
        [11] = { taken = false, coords = vector4(-1941.3756103516, 582.48114013672, 118.41500854492, 71.47664642334)}, -- North Rockford Drive
        [12] = { taken = false, coords = vector4(-1471.4389648438, 513.32684326172, 117.26462554932, 12.743616104126)}, -- Ace Jones Rd
        [13] = { taken = false, coords = vector4(-46.182907104492, 214.09324645996, 105.95656585693, 342.44036865234)}, -- Eclipse Blvd
   },
   ["B"] = {
    [1] = { taken = false, coords = vector4(-728.6434, -1048.14,11.86372, 118.2603)}, -- Parking garage south of Little Seoul Gas 
    [2] = { taken = false, coords = vector4(-1238.182, -1418.998, 3.7262, 303.04998)}, -- Parking lot in South Vespucci
    [3] = { taken = false, coords = vector4(-903.9962, -1536.893, 4.4246, 19.9429)}, -- Apartments right at the south tip of Vespucci
    [4] = { taken = false, coords = vector4(-1073.786, -1245.115, 4.8282, 120.6767)}, -- Parking garage off Palomino Avenue
    [5] = { taken = false, coords = vector4(-1044.651, -1007.917, 1.553029, 209.5635)}, -- Canals
    [6] = { taken = false, coords = vector4(-1624.653, -944.5192, 7.7759, 318.79614)}, -- Car park north of Vespucci Pier
    [7] = { taken = false, coords = vector4(-1392.959, -652.3425, 28.0762, 37.7812)}, -- Car park south of Bahama Mamas
    [8] = { taken = false, coords = vector4(-810.11285400391, -764.42010498047, 21.047887802124, 89.444267272949)}, -- Decker Street Little Seoul
    [9] = { taken = false, coords = vector4(-703.26519775391, -1138.2211914062, 10.015933990479, 38.855537414551)}, -- Hidden Garage near Little Seoul Gas
    [10] = { taken = false, coords = vector4(-477.37387084961, -757.49523925781, 29.965042114258, 269.59606933594)}, -- Vespucci Blvd Garage

    },
    ["C"] = {
        [1] = { taken = false, coords = vector4(-330.2138671875, -1494.5183105469, 30.071865081787, 0.014344398863614)}, --Innocence Blvd Gas
        [2] = { taken = false, coords = vector4(-51.497787475586, -1848.6805419922, 25.67264175415, 317.93606567383)}, -- Grove St Gas
        [3] = { taken = false, coords = vector4(165.93141174316, -1859.2150878906, 23.576751708984, 155.7455291748)}, -- Covenant
        [4] = { taken = false, coords = vector4(197.41539001465, -2027.5721435547, 17.682010650635, 162.8977355957)}, -- Dutch Ldn St
        [5] = { taken = false, coords = vector4(382.28173828125, -1650.8400878906, 47.705589294434, 141.63404846191)}, -- Top of Mcdonald grg
        [6] = { taken = false, coords = vector4(439.5309753418, -1517.6004638672, 28.682933807373, 139.53359985352)}, -- Church carpark Davis
        [7] = { taken = false, coords = vector4(154.462890625, -1307.7525634766, 28.60552406311, 62.823421478271)}, --VU
        [8] = { taken = false, coords = vector4(494.79467773438, -1967.7357177734, 24.311435699463, 123.19261932373)}, -- Little Bighorn
        [9] = { taken = false, coords = vector4(-104.09593963623, -1462.0905761719, 32.768543243408, 229.84019470215)}, -- Forum
        [10] = { taken = false, coords = vector4(-325.70413208008, -1335.0131835938, 30.688236236572, 181.10578918457)}, -- Next to Bennys
        [11] = { taken = false, coords = vector4(1110.6657714844, -1490.1047363281, 34.097026824951, 90.350845336914)}, -- Elysian Fire Depot
        [12] = { taken = false, coords = vector4(976.87878417969, -2547.9697265625, 27.704608917236, 359.52697753906)}, -- Hangar Way
        [13] = { taken = false, coords = vector4(425.06170654297, 248.52592468262, 102.60436248779, 250.36489868164)},
        [14] = { taken = false, coords = vector4(189.79652404785, 304.12680053711, 104.82190704346, 3.9644758701324)},
        [15] = { taken = false, coords = vector4(-267.50473022461, 195.78790283203, 84.879249572754, 88.675506591797)},
        [16] = { taken = false, coords = vector4(-453.22772216797, 99.494094848633, 62.551624298096, 173.20072937012)},
        [17] = { taken = false, coords = vector4(-1259.6136474609, -118.24502563477, 42.861591339111, 141.47727966309)},
        [18] = { taken = false, coords = vector4(-1574.0369873047, -285.74047851562, 47.670104980469, 133.84483337402)},
        [19] = { taken = false, coords = vector4(-1282.3796386719, -804.42657470703, 16.933452606201, 303.30206298828)},
        [20] = { taken = false, coords = vector4(-934.39508056641, -1303.1525878906, 4.4131073951721, 199.90617370605)},
        [21] = { taken = false, coords = vector4(780.08221435547, -1114.6342773438, 22.089267730713, 268.61367797852)}
    }
}




local loottable = {
    ["S"] = {
        [1] = { item = 'usbdevice', chance = 15},
        -- [2] = { item = 'racingusb1', chance = 50},
        [3] = { item = 'radio', chance = 80},
        [4] = { item = 'iciest coin', chance = 40},
        [5] = { item = 'scrapmetal', chance = 80, amount = math.random(5, 10)},
        [6] = { item = 'rubber', chance = 80, amount = math.random(15, 30)},
        [7] = { item = 'goldbar', chance = 40, amount = math.random(10, 15)},
    },
    -- 'vpnxj',
    -- 'racingusb1',
    -- 'radio',
    -- 'pix2'
    ["A"] = {
        -- [1] = { item = 'racingusb1', chance = 50},
        -- [1] = { item = 'racingusb1', chance = 80},
        [1] = { item = 'cuffs', chance = 80},
        [2] = { item = 'iciest coin', chance = 40},
        [3] = { item = 'scrapmetal', chance = 80, amount = math.random(5, 10)},
        [4] = { item = 'rubber', chance = 80, amount = math.random(15, 30)}
    },
    ["B"] = {
        [1] = { item = 'cuffs', chance = 80},
        [2] = { item = 'iciest coin', chance = 40},
        [3] = { item = 'scrapmetal', chance = 80, amount = math.random(5, 10)},
        [4] = { item = 'rubber', chance = 80, amount = math.random(15, 30)}
    },
    ["C"] = {
        [1] = { item = 'radio', chance = 80},
        [2] = { item = 'cuffs', chance = 60},
        [3] = { item = 'scrapmetal', chance = 80, amount = math.random(5, 10)},
        [4] = { item = 'rubber', chance = 80, amount = math.random(15, 30)}
    }

}

RegisterServerEvent('np-boosting:yourmom')
AddEventHandler('np-boosting:yourmom', function(class, number)
    local source = tonumber(source)
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)
    math.randomseed(os.time())
    local cash = math.random(225, 300)
    if number ~= 23231423423423423423 then
        return 
    end
    if class == "S" then cash = math.random(1000,2500) end
    if class == "A" then cash = math.random(1000,1500) end
    if class == "B" then cash = math.random(800, 1200) end
    if class == "C" then cash = math.random(400, 700) end
    for i = 1, #loottable[class] do

        if randomChance(loottable[class][i].chance) then
            TriggerClientEvent('player:receiveItem', source, tostring(loottable[class][i].item), loottable[class][i].amount)
        end
    end
    user:addBank(cash)
    TriggerClientEvent('DoLongHudText',  source, 'You recieved a wire transfer of $'..cash , 1)
end)



Citizen.CreateThread(function()
    while true do
        -- local value = math.random(15000, 30000)
        Citizen.Wait(10000 * 60)
        if availableRuns ~= nil then
            spawnVehicle()
            spawnVehicle()
            -- TriggerClientEvent('np-boosing:boost', -1)
        end
    end
end)

RegisterServerEvent('np-boosting:sendSignal')
AddEventHandler('np-boosting:sendSignal', function()
    TriggerClientEvent('np-boosting', -1)
end)

RegisterServerEvent('np-boosting:currentRuns')
AddEventHandler('np-boosting:currentRuns', function(args, id, class)
    if args == "add" then
        coords[class][id].active = true
        table.insert(currentRuns, id)
    elseif args == "delete" then
        coords[class][id].active = false
        table.remove(currentRuns, id)
    end
        TriggerClientEvent('np-boosting:currentRuns', -1, currentRuns)
end)



function getRandomVehicle()
    math.randomseed(os.time())
    local classes = {"B","C", "C", "B", "C", "B", "C", "A", "A", "A", "S", "S"}
    local value = math.random(1,#classes)
    local saved = {}
    local tempTable = {}
    tempTable["S"] = {}
    tempTable["A"] = {}
    tempTable["B"] = {}
    tempTable["C"] = {}
    for i = 1, #coords[classes[value]] do
        if not coords[classes[value]][i].taken then
            table.insert(tempTable[classes[value]], coords[classes[value]][i])
        end
    end
    local class = classes[value]
    if tempTable[classes[value]][1] ~= nil then
        -- coords[classes][value] = defaultt[classes][value]
        value = math.random(1,#tempTable[classes[value]])
        saved = {
            class = class,
            car = cars[class][math.random(1,#cars[class])]
        }
    else
    end
    return saved
end


RegisterServerEvent('updateCoords')
AddEventHandler('updateCoords', function()
    TriggerClientEvent('receiveCoords', -1, availableRuns)
end)

RegisterServerEvent('np-boosting:addRep')
AddEventHandler('np-boosting:addRep', function(username, password, number)
    local src = source
    math.randomseed(os.time())
    if number == 23231423423423423423 then
        exports["ghmattimysql"]:execute('SELECT * FROM boosting WHERE username = @user AND password = @pass', {['@user'] = username, ["@pass"] = password}, function(data)
            local rep = data[1].reputation
            local random = math.random(1,3)
            exports["ghmattimysql"]:execute("UPDATE boosting SET reputation = @rep WHERE username = @username AND password = @pass", {["@reputation"] = rep + random, ["@user"] = username, ["@pass"] = password})
            exports.ghmattimysql:execute("UPDATE boosting SET `reputation` = @sus WHERE `username` = @user AND `password` = @pass", {
                ['@sus'] = rep + random,
                ['@user'] = username,
                ['@pass'] = password,
            })
            TriggerClientEvent('DoLongHudText', src, 'You have completed the run and receieved ' .. random .. ' reps.')
        end)
    else
        print('cheater')
    end
end)




remoteCalls.register("np-boosting:spawnVehicle", function(location, car, class, id, heading)
    local numberplate, networkid = boostingSpawn(location, heading, car)
    return numberplate
end)


remoteCalls.register("np-boosting:spawnVehicle", function(location, car, class, id, heading)
    local numberplate = boostingSpawn(location, heading, car)
    return numberplate
end)


remoteCalls.register("np-boosting:getAccounts", function(username, password)
    local src = source
    local account = {}
    local accounts = {}
    exports["ghmattimysql"]:execute('SELECT * FROM boosting WHERE username = @user AND password = @pass', {['@user'] = username, ["@pass"] = password}, function(data)
        local accounts = json.decode(data[1].access)
        for i = 1, #accounts do 
            table.insert(account, {
                id = #account+1,
                header = "CID: " .. accounts[i],
                txt = "Manage User",
                params = {
                    event = "np-boosting:usermanagement",
                    args = {
                        id = i,
                        user = username,
                        pass = password,
                        cid = accounts[i],
                }}
            })
        end
        TriggerClientEvent('np-context:sendMenu', src, account)
    end)
end)


remoteCalls.register("np-boosting:addAccess", function(cid, username, password)
    local src = source
    exports["ghmattimysql"]:execute('SELECT * FROM boosting WHERE username = @user AND password = @pass', {['@user'] = username, ["@pass"] = password}, function(data)
        local accounts = json.decode(data[1].access)

        if #accounts > 5 then
            TriggerClientEvent('DoLongHudText', src, 'You have reached the maximum limit for this account!', 2)
            return
        end
        table.insert(accounts, cid)
        exports.ghmattimysql:execute("UPDATE boosting SET `access` = @sus WHERE `username` = @user AND `password` = @pass", {
            ['@sus'] = json.encode(accounts),
            ['@user'] = username,
            ['@pass'] = password,
        })
    end)
end)


remoteCalls.register("np-boosting:removeAccess", function(id, username, password, cid)
    local src = source
    local account = {}
    local accounts = {}
    exports["ghmattimysql"]:execute('SELECT * FROM boosting WHERE username = @user AND password = @pass', {['@user'] = username, ["@pass"] = password}, function(data)
        local accounts = json.decode(data[1].access)
        if accounts[id] == cid then
            table.remove(accounts, id)
            exports.ghmattimysql:execute("UPDATE boosting SET `access` = @sus WHERE `username` = @user AND `password` = @pass", {
                ['@sus'] = json.encode(accounts),
                ['@user'] = username,
                ['@pass'] = password,
            })
            TriggerClientEvent('DoLongHudText', src, 'Removed User with CID '.. cid, 2)

        end
    end)
end)



RegisterServerEvent('np-boosting:updateRuns')
AddEventHandler('np-boosting:updateRuns', function(runs)
        availableRuns = runs
        TriggerClientEvent('receiveCoords', -1, availableRuns)
end)

function spawnVehicle()

    local vehicle = getRandomVehicle()
    local value = math.random(1, #coords[vehicle.class])
    local vector = coords[vehicle.class][value].coords
    local vectorx = vector4(vector.x,vector.y,vector.z, vector.w)
    local location = vector4(vector.x,vector.y,vector.z, vector.w)
        local vectorz = vector3(location.x,location.y,location.z)
        local heading = location.w

    --     local numberplate = boostingSpawn(vectorz, heading, vehicle.car)
        availableRuns[#availableRuns+1] = {id = #availableRuns+1, car = vehicle.car, class = vehicle.class, location = vectorz, heading = location.w, descrip = descriptions[math.random(1, #descriptions)], plate = 0}
        TriggerClientEvent('receiveCoords', -1, availableRuns)

end


remoteCalls.register("np-boosting:getDB", function(username, password, status)
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    if status == "sign" then
        exports["ghmattimysql"]:execute('SELECT * FROM boosting WHERE username = @user AND password = @pass', {['@user'] = username, ["@pass"] = password}, function(data)
            local accounts = json.decode(data[1].access)
            for k,v in ipairs(accounts) do
                if v == char.id then
                    if data[1] ~= nil then
                        TriggerClientEvent('DoLongHudText', pSrc, 'You have signed in!', 2)
                        TriggerClientEvent('np-boosting:contracts', pSrc, data[1].reputation, username, password)
                    else
                        TriggerClientEvent('DoLongHudText', pSrc, 'Login Incorrect!', 2)
                    end
                else
                    TriggerClientEvent('DoLongHudText', pSrc, 'You do not have access to this account!', 2)
                end
            end
        end)
    elseif status == "new" then
        local cid = char.id
        exports["ghmattimysql"]:execute('SELECT * FROM boosting WHERE username = @user', {['@user'] = username}, function(data)
            if data[1] ~= nil then
                TriggerClientEvent('DoLongHudText', pSrc, 'Username is taken!', 2)
                return
            else
                local temp = {cid}
                exports["ghmattimysql"]:execute("INSERT INTO boosting (username,password,access) VALUES (@user, @pass,@accounts)", {["@user"] = username, ["@pass"] = password, ['@accounts'] = json.encode(temp)
                })
                TriggerClientEvent('DoLongHudText', pSrc, 'You have created an account!', 2)
                TriggerClientEvent('np-boosting:contracts', pSrc, 0, username, password)
            end
        end)
    end
end)

RegisterServerEvent('np-boosting:deleteVeh')
AddEventHandler('np-boosting:deleteVeh', function(veh)
local tempVeh = NetworkGetEntityFromNetworkId(veh)
DeleteEntity(tempVeh)
end)

RegisterServerEvent('deletecar')
AddEventHandler('deletecar', function(entity)
    DeleteEntity(NetworkGetEntityFromNetworkId(entity))
end)


function randomChance(percent)
    math.randomseed(os.time())
    return percent >= math.random(1, 100)  
  end


function boostingSpawn(coords, heading, vehicle)
    local src = source
    local vehicleName = vehicle
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
    TriggerClientEvent('np-boosting:getNetworkEntity', src, NetworkGetNetworkIdFromEntity(vehicle))
    return GetVehicleNumberPlateText(vehicle)
end

