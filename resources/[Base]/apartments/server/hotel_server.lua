local houses = {}

RegisterServerEvent('character:loadspawns')
AddEventHandler('character:loadspawns', function(cid)
    houses = {}
    local pSrc = source
    local pNum = math.random(1,88)
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local cid = user:getCurrentCharacter().id
    local coords = GetResourceKvpString(cid.."-coords")
--    print('these are coords ', coords)
    exports.ghmattimysql:execute("SELECT * FROM __motels WHERE cid= ?", {cid}, function(result)
        pData = result
        exports.ghmattimysql:execute("SELECT * FROM __housedata WHERE cid= ?", {cid}, function(data)
            exports.ghmattimysql:execute("SELECT * FROM __housekeys WHERE cid= ?", {cid}, function(data2)
                exports.ghmattimysql:execute("SELECT * FROM jobs_whitelist WHERE cid= ?", {cid}, function(data3)
                    exports.ghmattimysql:execute("SELECT * FROM character_passes WHERE cid= ?", {cid}, function(data4)
                        for k, r in pairs(data) do
                            if r ~= nil then
                                if r.housename ~= nil then
                                    local random = math.random(1111,9999)
                                    houses[random] = {}
                                    table.insert(houses[random], {["house_name"] = r.housename, ["house_model"] = r.house_model, ["house_id"] = r.house_id})
                        
                                end
                            end
                        end
            
                        for k, j in pairs(data2) do
                            if j ~= nil then
                                if j.housename ~= nil then
                                    local random = math.random(1111,9999)
                                    houses[random] = {}
                                    table.insert(houses[random], {["house_name"] = j.housename, ["house_model"] = j.house_model, ["house_id"] = j.house_id})
                                end
                            end
                        end
                            local jobs = {}
                            if data3 ~= nil then
                                for k,v in ipairs(data3) do
                                    local string = v.job:lower()
                                    table.insert(jobs, string)
                                end
                            end
                            if data4 ~= nil then  
                                for k,v in ipairs(data4) do
                                    local string = v.pass_type:lower()
                                    table.insert(jobs, string)
                                end
                            end
--                            print(json.encode(jobs))
                            TriggerClientEvent('hotel:createRoom1', pSrc, json.decode(coords), jobs, pNum, 2, houses)
                            TriggerEvent("np-clothingmenu:get_character_current", pSrc)
                        end)
                end)
            end)
        end)
       
    end)

end)

RegisterServerEvent('np-fw:savecoords')
AddEventHandler('np-fw:savecoords', function(coords)
	local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
	local characterId = user:getVar("character").id
--	print('this is characterId ', characterId)
	if user then
		if characterId then
--			print('these are coords ', coords)
			SetResourceKvp(characterId..'-coords', coords)
		end
	end
	local coords = GetResourceKvpString(characterId.."-coords")
--	print(coords)
end)

RegisterServerEvent("character:setup:new", function()
    local pSrc = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(pSrc)
    local cid = user:getCurrentCharacter().id
    exports.ghmattimysql:execute("UPDATE characters SET `new` = @new WHERE `id` = @id", { ['new'] = "1", ['id'] = cid})
    TriggerClientEvent("np-clothingmenu:defaultReset", pSrc)
end)

RegisterServerEvent("character:new:character", function(cid)
    local pSrc = source
    local pNum = math.random(1,88)
    
    -- exports.ghmattimysql:execute('INSERT INTO __motels(cid, roomType, roomNumber) VALUES(?, ?, ?)', {cid, "2", pNum})
    TriggerClientEvent("hotel:creation:character", pSrc, pNum, 2)
end)

RegisterServerEvent('hotel:updatelocks')
AddEventHandler('hotel:updatelocks', function(status)
    local src = source
    TriggerClientEvent('hotel:updateLockStatus', src, status)
end)
