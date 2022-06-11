local steamIds = {
    ["steam:11000010aa15521"] = true --kevin
}



RegisterServerEvent('np-doors:alterlockstate2')
AddEventHandler('np-doors:alterlockstate2', function()
    --URP.DoorCoords[10]["lock"] = 0

    TriggerClientEvent('np-doors:alterlockstateclient', source, URP.DoorCoords)

end)

RegisterServerEvent('np-doors:alterlockstate')
AddEventHandler('np-doors:alterlockstate', function(alterNum)
    print('lockstate:', alterNum)
    URP.alterState(alterNum)
end)

RegisterServerEvent('np-doors:ForceLockState')
AddEventHandler('np-doors:ForceLockState', function(alterNum, state)
    URP.DoorCoords[alterNum]["lock"] = state
    TriggerClientEvent('URP:Door:alterState', -1,alterNum,state)
end)

function isDoorLocked(door)
    if URP.DoorCoords[door].lock == 1 then
        return true
    else
        return false
    end
end