IRP.Core = IRP.Core or {}

function IRP.Core.ConsoleLog(self, msg, mod)
    if not tostring(msg) then return end
    if not tostring(mod) then mod = "No Module" end
    
    local pMsg = string.format("[IRP LOG - %s] %s", mod, msg)
    if not pMsg then return end

end

RegisterNetEvent("np-fw:consoleLog")
AddEventHandler("np-fw:consoleLog", function(msg, mod)
    IRP.Core:ConsoleLog(msg, mod)
end)

function getModule(module)
    if not IRP[module] then 
      --  print("Warning: '" .. tostring(module) .. "' module doesn't exist") 
        return false 
    end
    return IRP[module]
end

function addModule(module, tbl)
    if IRP[module] then 
       -- print("Warning: '" .. tostring(module) .. "' module is being overridden") 
    end
    IRP[module] = tbl
end

IRP.Core.ExportsReady = false

function IRP.Core.WaitForExports(self)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if exports and exports["np-fw"] then
                TriggerEvent("np-fw:exportsReady")
                IRP.Core.ExportsReady = true
                return
            end
        end
    end)
end

exports("getModule", getModule)
exports("addModule", addModule)

IRP.Core:WaitForExports()

