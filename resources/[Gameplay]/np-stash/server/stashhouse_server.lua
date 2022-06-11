RegisterNetEvent('np-stash:fetchInitialState')
AddEventHandler('np-stash:fetchInitialState', function()
	local source = source
    local stash = Config.Stash
	TriggerClientEvent('np-stash:setInitialState', source, stash)
end)

RegisterServerEvent('stashesaddtoconfig')
AddEventHandler('stashesaddtoconfig', function(coords, pin, id, distance)
    local source = source
    print(GetPlayerIdentifiers(source)[1])
    if GetPlayerIdentifiers(source)[1] == "steam:1100001024bce67" or "steam:1100001343cdf96" then    
    TriggerClientEvent('DoLongHudText', source, 'StashHouse Added', 2)
        local path = GetResourcePath(GetCurrentResourceName())
        local file = io.open(path.."/server/svstashes.lua", "a") -- Append mode
        file:write("\n    Config.Stash[#Config.Stash + 1] = {")
        file:write("\n        StashEntry = "..coords..",")
        file:write("\n        RequiredPin = "..pin..",")
        file:write("\n        ID = "..id..",")
        file:write("\n        distance = "..distance..",")
        file:write("\n}")
        file:close()

    else
        TriggerClientEvent('DoLongHudText', source, 'Cannot Do This Action', 2)
    end
end)

function round2(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function DeleteString(path, before)
    local inf = assert(io.open(path, "r+"), "Failed to open input file")
    local lines = ""
    while true do
        local line = inf:read("*line")
		if not line then break end
		
		if line ~= before then lines = lines .. line .. "\n" end
    end
    inf:close()
    file = io.open(path, "w")
    file:write(lines)
    file:close()
end