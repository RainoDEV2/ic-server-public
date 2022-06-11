local scenes = {}

RegisterNetEvent('np-scenes:fetch', function()
    local src = source
    TriggerClientEvent('np-scenes:send', src, scenes)
end)

RegisterNetEvent('np-scenes:add', function(coords, message, color, distance)
    table.insert(scenes, {
        message = message,
        color = color,
        distance = distance,
        coords = coords
    })
    TriggerClientEvent('np-scenes:send', -1, scenes)
    TriggerEvent('np-scenes:log', source, message, coords)
end)

RegisterNetEvent('np-scenes:delete', function(key)
    table.remove(scenes, key)
    TriggerClientEvent('np-scenes:send', -1, scenes)
end)


RegisterNetEvent('np-scenes:log', function(id, text, coords)
    local f, err = io.open('sceneLogging.txt', 'a')
    if not f then return print(err) end
    f:write('Player: ['..id..'] Placed Scene: ['..text..'] At Coords = '..coords..'\n')
    f:close()
end)