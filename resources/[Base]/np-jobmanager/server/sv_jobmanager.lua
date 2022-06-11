IRP.Jobs.CurPlayerJobs = {}

for k,v in pairs(IRP.Jobs.ValidJobs) do
    IRP.Jobs.CurPlayerJobs[k] = {}
end

function IRP.Jobs.IsWhiteListed(self, hexId, characterId, job, callback)
    if not hexId or not characterId then return end

    local q = [[SELECT owner, cid, job, rank FROM jobs_whitelist WHERE cid = @cid AND job = @job LIMIT 1]]
    local v = {["owner"] = hexId, ["cid"] = characterId, ["job"] = job}

    exports.ghmattimysql:execute(q, v, function(results)
        if not results then callback(false, false) return end

        local isWhiteListed = (results and results[1]) and results[1] or false
        local rank = (isWhiteListed and results[1].rank) and results[1].rank or false
        callback(isWhiteListed, rank)
    end)
end

function IRP.Jobs.JobExists(self, job)
    return IRP.Jobs.ValidJobs[job] ~= nil
end

function IRP.Jobs.CountJob(self, job)
    if not IRP.Jobs:JobExists(job) then return 0 end

    local count = 0
    for k,v in pairs(IRP.Jobs.CurPlayerJobs[job]) do
        if job == "ems" then
            if v.isWhiteListed == true then
                count = count + 1
            end
        else
            count = count + 1
        end
    end

    return count
end

function IRP.Jobs.CanBecomeJob(self, user, job, callback)
    if not user then callback(false) return end
    if not user:getVar("characterLoaded") then callback(false, "Character not loaded") return end

    local src = user:getVar("source")
    local hexId = user:getVar("hexid")
    local characterId = user:getVar("character").id

    -- if IRP.Jobs.ValidJobs[job].requireDriversLicense and not exports["police"]:CheckLicense(characterId, "Drivers License") then
    --     callback(false, "You need a drivers license.")
    --     return
    -- end

    if not hexId or not characterId or not src then callback(false, "Id's don't exist") return end
        if not IRP.Jobs.ValidJobs[job] then callback(false, "Job isn't a valid job") return end
        
        TriggerEvent("np-jobmanager:attemptBecomeJob", src, characterId, function(allowed, reason)
            if not allowed then callback(false, reason) return end
        end)

        if WasEventCanceled() then callback(false) return end

        -- if IRP.Jobs:CountJob(job) < 1 and IRP.Jobs.ValidJobs[job].name == "EMS" then
        --     callback(true)
        --     return
        -- else
        --     callback(false)
        --     return
        -- end

        if IRP.Jobs.ValidJobs[job].whitelisted then
            IRP.Jobs:IsWhiteListed(hexId, characterId, job, function(whiteListed, rank)
                if not whiteListed then callback(false, "You're not whitelisted for this job") return end
                callback(true, nil, rank)
            end)
            return
        end

        if IRP.Jobs:JobExists(job) then
            local jobTable = IRP.Jobs.ValidJobs[job]
            if jobTable and jobTable.max then
                if IRP.Jobs:CountJob(job) >= jobTable.max then callback(false, "There are too many employees for this job right now, try again later") return end
            end
        end
        callback(true)
end

function IRP.Jobs.AddWhiteList(self, user, job, rank)
    print('test')
    local q = [[INSERT INTO jobs_whitelist (cid, owner, job, rank) VALUES (@cid, @owner, @job, @rank)]]
    local v = {["cid"] = tonumber(user), ["owner"] = tonumber(user), ["job"] = job, ["rank"] = rank}
    exports.ghmattimysql:execute(q, v)
end


function IRP.Jobs.RemoveWhitelist(self, user, job)
    print('test')
    local q = [[DELETE FROM jobs_whitelist WHERE cid = @cid AND job = @job ]]
    local v = {["cid"] = tonumber(user), ["owner"] = tonumber(user), ["job"] = job}
    exports.ghmattimysql:execute(q, v)
end

function IRP.Jobs.SetJob(self, user, job, notify, callback)
    if not user then return false end
    if not job or type(job) ~= "string" then return false end
    if not user:getVar("characterLoaded") then return false end 


    IRP.Jobs:CanBecomeJob(user, job, function(allowed, reason, rank)
        if not allowed then
            if reason and type(reason) == "string" then
                TriggerClientEvent("DoLongHudText", user.source, tostring(reason), 1)
            end
            return
        end

        local src = user:getVar("source")
        local oldJob = user:getVar("job")
        local hexId = user:getVar("hexid")
        local characterId = user:getVar("character").id

        if oldJob then
            IRP.Jobs.CurPlayerJobs[oldJob][src] = nil
        end

        user:setVar("job", job)
        IRP.Jobs.CurPlayerJobs[job][src] = {rank = rank and rank or 0, lastPayCheck = GetGameTimer(),isWhiteListed = false}

        local name = IRP.Jobs.ValidJobs[job].name

        TriggerClientEvent("np-jobmanager:playerBecameJob", src, job, name, false)
        TriggerClientEvent("np-jobmanager:playerBecomeEvent", src, job, name, notify)

        if IRP.Jobs:CountJob("trucker") >= 1 then
            TriggerEvent("lscustoms:IsTruckerOnline",true)
        elseif IRP.Jobs:CountJob("trucker") <= 0 then
            TriggerEvent("lscustoms:IsTruckerOnline", false)
        end

        if callback then callback() end
    end)
end

AddEventHandler("playerDropped", function(reason)
    local src = source

    for j,u in pairs(IRP.Jobs.CurPlayerJobs) do
        for k,s in pairs(u) do
            if k == src then IRP.Jobs.CurPlayerJobs[j][k] = nil end
        end
    end
end)

AddEventHandler("np-fw:characterLoaded", function(user, char)
    IRP.Jobs:SetJob(user, "unemployed", false)
end)

-- Need to think of a better way to do this, says no such export when resource is started
AddEventHandler("np-fw:exportsReady", function()
    exports["np-fw"]:addModule("JobManager", IRP.Jobs)
end)

local policebonus = 0
local emsbonus = 0
local civbonus = 0

RegisterServerEvent('updatePays')
AddEventHandler('updatePays', function(policebonus1,emsbonus1,civbonus1)
    policebonus = policebonus1
    emsbonus = emsbonus1
    civbonus = civbonus1
end)

RegisterServerEvent('updateSinglePays')
AddEventHandler('updateSinglePlays', function(bonus,bonusType)
    bonusType = bonusType
    bonus = bonus
    if bonusType == 'police' then
        policebonus = bonus
    end
    if bonusType == 'ems' then
        emsbonus = bonus
    end
    if bonusType == 'civilian' then
        civbonus = bonus
    end
end)

Citizen.CreateThread(function()
    while true do
        local src = source
        local curTime = os.time()
        for job,tbl in pairs(IRP.Jobs.CurPlayerJobs) do
            if IRP.Jobs.ValidJobs[job].paycheck then
                local payCheck = IRP.Jobs.ValidJobs[job].paycheck

                if IRP.Jobs.ValidJobs[job].name == "Police Officer" then
                    payCheck = payCheck + policebonus

                elseif IRP.Jobs.ValidJobs[job].name == "EMS" then
                    payCheck = payCheck + emsbonus

                else
                    payCheck = payCheck + civbonus
                end

                for src,data in pairs(tbl) do
                    local user = exports["np-fw"]:getModule("Player"):GetUser(src)
                    if user then
                        if tonumber(curTime) == tonumber(data.lastPayCheck) or tonumber(data.lastPayCheck) >= 480 then
                            IRP.Jobs.CurPlayerJobs[job][src].lastPayCheck = curTime
                            TriggerEvent("server:givepayJob", job, math.floor(payCheck), src)
                        else

                        end
                    end
                end
            end
        end

        Citizen.Wait(1200000)
    end
end)

RegisterServerEvent('jobssystem:jobs')
AddEventHandler('jobssystem:jobs', function(job, src)
    if src == nil or src == 0 then src = source end

    local jobs = exports["np-fw"]:getModule("JobManager")
    local user = exports["np-fw"]:getModule("Player"):GetUser(src)

    if not user then return end
    if not jobs then return end

    jobs:SetJob(user, tostring(job))

end)

RegisterCommand('setjob', function(source, args)
TriggerEvent('jobssystem:jobs', args[1], source)
end)

RegisterCommand('addwhitelist', function(source, args)
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)
    local rank = user:getRank()
    local jobs = exports["np-fw"]:getModule("JobManager")
    local characterId = user:getVar("character").id
    local q = [[SELECT rank FROM jobs_whitelist WHERE cid = @cid AND job = @job]]
    local v = {["cid"] = characterId, ["@job"] = args[3]}
    exports.ghmattimysql:execute(q, v, function(result)
        print(json.encode(result))
        if result[1] ~= nil or rank == "dev" then
            if rank == "dev" or result[1].rank == 7 or result[1].rank == 6 or result[1].rank == 5 then
                TriggerClientEvent('DoLongHudText', tonumber(args[1]), "You have been hired with " .. args[3])
                jobs:AddWhiteList(args[2], args[3], args[4])
            else
                TriggerClientEvent('DoLongHudText', source, "You are not rank 7 of the required job!")
            end
        else
            TriggerClientEvent('DoLongHudText', source, "You are not apart of the required job!")
        end
    end)
end)


RegisterCommand('removewhitelist', function(source, args)
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)
    local rank = user:getRank()
    local jobs = exports["np-fw"]:getModule("JobManager")
    local characterId = user:getVar("character").id
    local q = [[SELECT rank FROM jobs_whitelist WHERE cid = @cid AND job = @job]]
    local v = {["cid"] = characterId, ["@job"] = args[3]}
    print(rank)
    exports.ghmattimysql:execute(q, v, function(result)
        print(json.encode(result))
        if args[2] == characterId then
            TriggerClientEvent('DoLongHudText', source, "You can't fire yourself silly hehe", 2)
            return
        end
        if rank == "dev" or result[1] ~= nil then
            if rank == "dev" or result[1].rank == 7 or result[1].rank == 6 or result[1].rank == 5 then
                TriggerClientEvent('DoLongHudText', tonumber(args[1]), "You have been fired :feelsbadman:")
                jobs:RemoveWhitelist(args[2], args[3])
            else
                TriggerClientEvent('DoLongHudText', source, "You are not rank 7 of the required job!")
            end
        else
            TriggerClientEvent('DoLongHudText', source, "You are not apart of the required job!")
        end
    end)
end)

RegisterCommand('promote', function(source, args)
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)
    local jobs = exports["np-fw"]:getModule("JobManager")
    local characterId = user:getVar("character").id
    local q = [[SELECT rank FROM jobs_whitelist WHERE cid = @cid AND job = @job]]
    local v = {["cid"] = characterId, ["@job"] = args[3]}
    print(rank)
    exports.ghmattimysql:execute(q, v, function(result)
        print(json.encode(result))
        if args[2] == characterId then
            TriggerClientEvent('DoLongHudText', source, "You can't fire yourself silly hehe", 2)
            return
        end
        if result[1] ~= nil then
            if result[1].rank == 7 then
                TriggerClientEvent('DoLongHudText', tonumber(args[1]), "You have been promoted to ")
                jobs:SetRank(tonumber(args[2]), args[3], tonumber(args[4]))
            else
                TriggerClientEvent('DoLongHudText', source, "You are not rank 7 of the required job!")
            end
        else
            TriggerClientEvent('DoLongHudText', source, "You are not apart of the required job!")
        end
    end)
end)