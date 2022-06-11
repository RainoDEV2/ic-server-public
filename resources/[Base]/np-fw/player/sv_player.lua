IRP.Users = IRP.Users or {}
IRP.Player = IRP.Player or {}

function IRP.Player.GetUser(self, id)
    return IRP.Users[id] and IRP.Users[id] or false
end

function IRP.Player.GetUsers(self)
    local tmp = {}

    for k, v in pairs(IRP.Users) do
        tmp[#tmp+1]= k
    end

    return tmp
end

local function GetUser(user)
    return IRP.Users[user.source]
end

local function AddMethod(player)
    function player.getVar(self, var)
        return GetUser(self)[var]
    end

    function player.setVar(self, var, data)
        GetUser(self)[var] = data
    end
    
    function player.networkVar(self, var, data)
        self:setVar(var, data)
        TriggerClientEvent("np-fw:networkVar", GetUser(self):getVar("source"), var, data)
    end

    function player.getRank(self)
        return GetUser(self).rank
    end

    function player.setRank(self, rank)
        GetUser(self).rank = rank
        self:networkVar("rank", rank)
    end

    function player.setCharacters(self, data)
        GetUser(self).characters = data
    end

    function player.setCharacter(self, data)
        GetUser(self).character = data
    end

    function player.getCasino(self)
        return GetUser(self).character.casino
    end

    function player.getCash(self)
        return GetUser(self).character.cash
    end

    function player.getBalance(self)
        return GetUser(self).character.bank
    end

    function player.getDirtyMoney(self)
        return GetUser(self).character.dirty_money
    end

    function player.getGangType(self)
        return GetUser(self).character.gang_type
    end

    function player.getStressLevel(self)
        return GetUser(self).character.stress_level
    end

    function player.getJudgeType(self)
        return GetUser(self).character.judge_type
    end

    function player.alterDirtyMoney(self, amt)
        local characterId = GetUser(self.character.id)

        GetUser(self).character.dirty_money = amt

        IRP.DB:UpdateCharacterDirtyMoney(GetUser(self), characterId, amt, function(updatedMoney, err)
            if updatedMoney then
                --We are good here.
            end
        end)
    end

    function player.alterStressLevel(self, amt)
        local characterid = GetUser(self).character.id

        GetUser(self).character.stress_level = amt

        IRP.DB:UpdateCharacterStressLevel(GetUser(self), characterId, amt, function(updatedMoney, err)
            if updatedMoney then
                --We are good here.
            end
        end)
    end

    function player.resetDirtyMoney(self)
        local characterid = GetUser(self).character.id

        GetUser(self).character.dirty_money = 0

        IRP.DB:UpdateCharacterDirtyMoney(GetUser(self), characterId, 0, function(updatedMoney, err)
            if updatedMoney then
                --We are good here.
            end
        end)
    end

    function player.addCasino(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local casino = GetUser(self):getCasino() + amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.casino = casino

        IRP.DB:UpdateCharacterCasino(GetUser(self), characterId, casino, function(updatedMoney, err) 
            if updatedMoney then
                TriggerClientEvent("banking:addCasino", GetUser(self).source, amt)
                TriggerClientEvent("banking:updateCasino", GetUser(self).source, GetUser(self):getCasino(), amt)
            end
        end)
    end

    function player.removeCasino(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local casino = GetUser(self):getCasino() - amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.casino = GetUser(self).character.casino - amt


            IRP.DB:UpdateCharacterCasino(GetUser(self), characterId, casino, function(updatedMoney, err) 
                if updatedMoney then
                    TriggerClientEvent("banking:removeCasino", GetUser(self).source, amt)
                    TriggerClientEvent("banking:updateCasino", GetUser(self).source, GetUser(self):getCasino(), amt)
                end
            end)
    end

    function player.addMoney(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local cash = GetUser(self):getCash() + amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.cash = cash

        IRP.DB:UpdateCharacterMoney(GetUser(self), characterId, cash, function(updatedMoney, err) 
            if updatedMoney then
                TriggerClientEvent("banking:addCash", GetUser(self).source, amt)
                TriggerClientEvent("banking:updateCash", GetUser(self).source, GetUser(self):getCash(), amt)
            end
        end)
    end

    function player.removeMoney(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local cash = GetUser(self):getCash() - amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.cash = GetUser(self).character.cash - amt


            IRP.DB:UpdateCharacterMoney(GetUser(self), characterId, cash, function(updatedMoney, err) 
                if updatedMoney then
                    TriggerClientEvent("banking:removeCash", GetUser(self).source, amt)
                    TriggerClientEvent("banking:updateCash", GetUser(self).source, GetUser(self):getCash(), amt)
                end
            end)
    end

    
    function player.removeBank(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local bank = GetUser(self):getBalance() - amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.bank = GetUser(self).character.bank - amt

        IRP.DB:UpdateCharacterBank(GetUser(self), characterId, bank, function(updatedMoney, err) 
            if updatedMoney then
                TriggerClientEvent("banking:removeBalance", GetUser(self).source, amt)
                TriggerClientEvent("banking:updateBalance", GetUser(self).source, GetUser(self):getBalance(), amt)
            end
        end)
    end

    function player.addBank(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local bank = GetUser(self):getBalance() + amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.bank = bank

        IRP.DB:UpdateCharacterBank(GetUser(self), characterId, bank, function(updatedMoney, err) 
            if updatedMoney then
                TriggerClientEvent("banking:addBalance", GetUser(self).source, amt)
                TriggerClientEvent("banking:updateBalance", GetUser(self).source, GetUser(self):getBalance(), amt)
            end
        end)
    end

    function player.getNumCharacters(self)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters then return 0 end
        return #GetUser(self).characters
    end

    function player.ownsCharacter(self, id)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters or GetUser(self):getNumCharacters() <= 0 then return false end

        for k,v in ipairs(GetUser(self).characters) do 
            if v.id == id then return true end 
        end

        return false
    end

    function player.getGender(self)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters or not GetUser(self).characterLoaded then return false end

        return GetUser(self).character.gender
    end
        
    function player.getCharacters(self)
        return GetUser(self).characters
    end

    function player.getCharacter(self, id)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters or GetUser(self):getNumCharacters() <= 0 then return false end
        if not GetUser(self):ownsCharacter(id) then return false end

        for k,v in ipairs(GetUser(self).characters) do 
            if v.id == id then return v end
        end

        return false
    end

    function player.getCurrentCharacter(self)
        if not GetUser(self).charactersLoaded or not GetUser(self).characterLoaded or GetUser(self):getNumCharacters() <= 0 then return false end
        return GetUser(self).character
    end

    return player
end

    local function CreatePlayer(src)
        local self = {}

        self.source = src
        self.name = GetPlayerName(src)
        self.hexid = IRP.Util:GetHexId(src)
        
        if not self.hexid then
            DropPlayer(src, "Error fetching steamid")
            return
        end

        self.comid = IRP.Util:HexIdToComId(self.hexid)
        self.steamid = IRP.Util:HexIdToSteamId(self.hexid)
        self.license = IRP.Util:GetLicense(src)
        self.ip = GetPlayerEP(src)
        self.rank = "user"

        self.characters = {}
        self.character = {}

        self.charactersLoaded = false
        self.characterLoaded = false

        local methods = AddMethod(self)

        IRP.Users[src] = methods

        return methods
    end


function IRP.Player.CreatePlayer(self, src, recrate)
    if recreate then IRP.Users[src] = nil end
    
    if IRP.Users[src] then return IRP.Users[src] end

    return CreatePlayer(src)
end

local pos = {}
RegisterServerEvent('np-fw:updatecoords')
AddEventHandler('np-fw:updateCoords', function(x,y,z)
    local src = source
    pos[src] = {x,y,z}
end)

RegisterServerEvent("retreive:licenes:server")
AddEventHandler("retreive:licenes:server", function()
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    local characterId = user:getVar("character").id
    exports.ghmattimysql:execute('SELECT * FROM user_licenses WHERE owner = ? AND type = ?', {characterId, "Firearm"}, function(callback)
        TriggerClientEvent("wtflols", src, callback[1].status)
    end)
end)


RegisterServerEvent("retreive:jail")
AddEventHandler("retreive:jail", function(cid)
    local src = source
    exports.ghmattimysql:execute("SELECT `jail_time` FROM `characters` WHERE id = ?", {cid}, function(result)
        if result[1].jail_time >= 1 then
            TriggerClientEvent("beginJail2", src, result[1].jail_time, true)
        end
    end)
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    if reason == nil then reason = "Unknown" end
    local user = IRP.Player:GetUser(src)
    local posE = json.encode(pos[src])
    pos[src] = nil

    local pUser = exports["np-fw"]:getModule("Player"):GetUser(src)
    local char = pUser:getVar("character")
	local job = GetCurrentJob(src)
	local userjob = user:getVar("job")
    if userjob == "police" then
        exports['np-emergencyjobs']:DisconnectJobUpdater(userjob)
    elseif userjob == "ems" then 
         exports['np-emergencyjobs']:DisconnectJobUpdater(userjob)
    end

    IRP.Users[src] = nil
    TriggerEvent('np-fw:playerDropped', src, user)
end)