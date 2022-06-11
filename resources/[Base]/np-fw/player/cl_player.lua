IRP.Player = IRP.Player or {}
IRP.LocalPlayer = IRP.LocalPlayer or {}

local function GetUser()
    return IRP.LocalPlayer
end

function IRP.LocalPlayer.setVar(self, var, data)
    GetUser()[var] = data
end

function IRP.LocalPlayer.getVar(self, var)
    return GetUser()[var]
end

function IRP.LocalPlayer.setCurrentCharacter(self, data)
    if not data then return end
    GetUser():setVar("character", data)
end

function IRP.LocalPlayer.getCurrentCharacter(self)
    return GetUser():getVar("character")
end

RegisterNetEvent("np-fw:networkVar")
AddEventHandler("np-fw:networkVar", function(var, val)
    IRP.LocalPlayer:setVar(var, val)
end)

