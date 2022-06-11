IRP.Events = IRP.Events or {}
IRP.Events.Total = 0
IRP.Events.Active = {}

function IRP.Events.Trigger(self, event, args, callback)
    local id = IRP.Events.Total + 1
    IRP.Events.Total = id

    id = event .. ":" .. id

    if IRP.Events.Active[id] then return end

    IRP.Events.Active[id] = {cb = callback}
    
    TriggerServerEvent("np-events:listenEvent", id, event, args)
end

RegisterNetEvent("np-events:listenEvent")
AddEventHandler("np-events:listenEvent", function(id, data)
    local ev = IRP.Events.Active[id]
    
    if ev then
        ev.cb(data)
        IRP.Events.Active[id] = nil
    end
end)

