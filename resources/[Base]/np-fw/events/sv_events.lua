IRP.Events = IRP.Events or {}
IRP.Events.Registered = IRP.Events.Registered or {}

RegisterServerEvent("np-events:listenEvent")
AddEventHandler("np-events:listenEvent", function(id, name, args)
    local src = source

    if not IRP.Events.Registered[name] then return end

    IRP.Events.Registered[name].f(IRP.Events.Registered[name].mod, args, src, function(data)
        TriggerClientEvent("np-events:listenEvent", src, id, data)
    end)
end)

function IRP.Events.AddEvent(self, module, func, name)
    IRP.Events.Registered[name] = {
        mod = module,
        f = func
    }
end



