local IRP = IRP or {}
IRP.Scoreboard = {}
IRP._Scoreboard = {}

IRP.Scoreboard.Menu = {}

IRP._Scoreboard.Players = {}
IRP._Scoreboard.Recent = {}
IRP._Scoreboard.SelectedPlayer = nil
IRP._Scoreboard.MenuOpen = false
IRP._Scoreboard.Menus = {}

local function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function IRP.Scoreboard.AddPlayer(self, data)
    IRP._Scoreboard.Players[data.src] = data
end

function IRP.Scoreboard.RemovePlayer(self, data)
    IRP._Scoreboard.Players[data.src] = nil
    IRP._Scoreboard.Recent[data.src] = data
end

function IRP.Scoreboard.RemoveRecent(self, src)
    IRP._Scoreboard.Recent[src] = nil
end


function IRP.Scoreboard.AddAllPlayers(self, data)
    IRP._Scoreboard.Players[data.src] = data
end

function IRP.Scoreboard.GetPlayerCount(self)
    local count = 0

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then count = count + 1 end
    end

    return count
end

Citizen.CreateThread(function()
    local function DrawMain()
        if WarMenu.Button("Total:", tostring(IRP.Scoreboard:GetPlayerCount()), {r = 135, g = 206, b = 250, a = 150}) then end

        for k,v in spairs(IRP._Scoreboard.Players, function(t, a, b) return t[a].src < t[b].src end) do
            local playerId = GetPlayerFromServerId(v.src)

            if NetworkIsPlayerActive(playerId) or GetPlayerPed(playerId) == PlayerPedId() then
                if WarMenu.MenuButton("[" .. v.src .. "] " .. v.steamid .. " ", "options") then IRP._Scoreboard.SelectedPlayer = v end
            else
                if WarMenu.MenuButton("[" .. v.src .. "] - instanced?", "options", {r = 255, g = 0, b = 0, a = 255}) then IRP._Scoreboard.SelectedPlayer = v end
            end
        end

        

        if WarMenu.MenuButton("Recent D/C's", "recent") then
        end
    end

    local function DrawRecent()
        for k,v in spairs(IRP._Scoreboard.Recent, function(t, a, b) return t[a].src < t[b].src end) do
            if WarMenu.MenuButton("[" .. v.src .. "] " .. v.name, "options") then IRP._Scoreboard.SelectedPlayer = v end
        end
    end

    local function DrawOptions()
        if WarMenu.Button("Steam ID:", IRP._Scoreboard.SelectedPlayer.steamid) then end
        if WarMenu.Button("Community ID:", IRP._Scoreboard.SelectedPlayer.comid) then end
        if WarMenu.Button("Server ID:", IRP._Scoreboard.SelectedPlayer.src) then end
    end

    IRP._Scoreboard.Menus = {
        ["scoreboard"] = DrawMain,
        ["recent"] = DrawRecent,
        ["options"] = DrawOptions
    }

    local function Init()
        WarMenu.CreateMenu("scoreboard", "Player List")
        WarMenu.SetSubTitle("scoreboard", "Players")

        WarMenu.SetMenuWidth("scoreboard", 0.5)
        WarMenu.SetMenuX("scoreboard", 0.71)
        WarMenu.SetMenuY("scoreboard", 0.017)
        WarMenu.SetMenuMaxOptionCountOnScreen("scoreboard", 30)
        WarMenu.SetTitleColor("scoreboard", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("scoreboard", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("scoreboard", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("scoreboard", 255, 255, 255, 255)

        -- WarMenu.CreateSubMenu("recent", "scoreboard", "Recent D/C's")
        WarMenu.SetMenuWidth("recent", 0.5)
        WarMenu.SetTitleColor("recent", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("recent", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("recent", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("recent", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("options", "scoreboard", "User Info")
        WarMenu.SetMenuWidth("options", 0.5)
        WarMenu.SetTitleColor("options", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("options", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("options", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("options", 255, 255, 255, 255)
    end

    Init()
    timed = 0
    while true do
        for k,v in pairs(IRP._Scoreboard.Menus) do
            if WarMenu.IsMenuOpened(k) then
                v()
                WarMenu.Display()
            else
                if timed > 0 then
                    timed = timed - 1
                end
            end
        end

        Citizen.Wait(1)
    end


end)

function IRP.Scoreboard.Menu.Open(self)
    IRP._Scoreboard.SelectedPlayer = nil
    WarMenu.OpenMenu("scoreboard")
end

function IRP.Scoreboard.Menu.Close(self)
    for k,v in pairs(IRP._Scoreboard.Menus) do
        WarMenu.CloseMenu(K)        shouldDraw =false    end
end

Controlkey = {["generalScoreboard"] = {303,"U"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
    Controlkey["generalScoreboard"] = table["generalScoreboard"]
end)

Citizen.CreateThread(function()
    local function IsAnyMenuOpen()
        for k,v in pairs(IRP._Scoreboard.Menus) do
            if WarMenu.IsMenuOpened(k) then return true end
        end

        return false
    end

    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, Controlkey["generalScoreboard"][1]) then
            if not IsAnyMenuOpen() then
                IRP.Scoreboard.Menu:Open()
            end
        else
            if IsAnyMenuOpen() then IRP.Scoreboard.Menu:Close() end
            Citizen.Wait(100)
        end
    end
end)

RegisterNetEvent("np-scoreboard:RemovePlayer")
AddEventHandler("np-scoreboard:RemovePlayer", function(data)
    IRP.Scoreboard:RemovePlayer(data)
end)

RegisterNetEvent("np-scoreboard:AddPlayer")
AddEventHandler("np-scoreboard:AddPlayer", function(data)
    IRP.Scoreboard:AddPlayer(data)
end)

RegisterNetEvent("np-scoreboard:RemoveRecent")
AddEventHandler("np-scoreboard:RemoveRecent", function(src)
    IRP.Scoreboard:RemoveRecent(src)
end)

RegisterNetEvent("np-scoreboard:AddAllPlayers")
AddEventHandler("np-scoreboard:AddAllPlayers", function(data)
    IRP.Scoreboard:AddAllPlayers(data)
end)
