hasrobbed = {}
hasrobbed[1] = true
hasrobbed[2] = true
hasrobbed[3] = true
hasrobbed[4] = true
hasrobbed[5] = true
hasrobbed[6] = true
hasrobbed[7] = true
hasrobbed[8] = true
hasrobbed[9] = true
hasrobbed[10] = true
hasrobbed[11] = true
hasrobbed[12] = true
hasrobbed[13] = true
hasrobbed[14] = true
hasrobbed[15] = true
hasrobbed[16] = true
hasrobbed[17] = true
hasrobbed[18] = true
hasrobbed[19] = true
hasrobbed[20] = true

local locations = {
	[1] = {-626.5326,-238.3758,38.05},
	[2] = {-625.6032, -237.5273, 38.05},
	[3] = {-626.9178, -235.5166, 38.05},
	[4] = {-625.6701, -234.6061, 38.05},
	[5] = {-626.8935, -233.0814, 38.05},
	[6] = {-627.9514, -233.8582, 38.05},
	[7] = {-624.5250, -231.0555, 38.05},
	[8] = {-623.0003, -233.0833, 38.05},
	[9] = {-620.1098, -233.3672, 38.05},
	[10] = {-620.2979, -234.4196, 38.05},
	[11] = {-619.0646, -233.5629, 38.05},
	[12] = {-617.4846, -230.6598, 38.05},
	[13] = {-618.3619, -229.4285, 38.05},
	[14] = {-619.6064, -230.5518, 38.05},
	[15] = {-620.8951, -228.6519, 38.05},
	[16] = {-619.7905, -227.5623, 38.05},
	[17] = {-620.6110, -226.4467, 38.05},
	[18] = {-623.9951, -228.1755, 38.05},
	[19] = {-624.8832, -227.8645, 38.05},
	[20] = {-623.6746, -227.0025, 38.05},
}


function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent("jewel:robbed")
AddEventHandler("jewel:robbed", function(newSet) 
    hasrobbed = newSet
end)

local jewelKOS = true
RegisterNetEvent('JewelKOS')
AddEventHandler('JewelKOS', function()
	if jewelKOS then
		return
	end
	jewelKOS = true
    SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION3`)
    SetPedRelationshipGroupHash(PlayerPedId(),`MISSION3`)
    Wait(60000)
    SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
    SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
    jewelKOS = false
end)


function giveitems()
	if IsPedArmed(PlayerPedId(), 4 | 1) then
		TriggerServerEvent("jewel:request:relock")
	end
end

isCop = false
 
RegisterNetEvent('nowCopSpawn')
AddEventHandler('nowCopSpawn', function()
    isCop = true
end)

RegisterNetEvent('nowCopSpawnOff')
AddEventHandler('nowCopSpawnOff', function()
    isCop = false
end)

function AttackGlass(num)
	if math.random(100) > 70 or IsPedArmed(PlayerPedId(), 4 | 1) then
		Citizen.Wait(1500)
		ClearPedTasks(PlayerPedId())
		local plyPos = GetEntityCoords(PlayerPedId())
		if math.random(50) > 35 then
			TriggerEvent('np-jewelrob:alert')
		end
		TriggerServerEvent("jewel:hasrobbed",num)
		giveitems()
		hasrobbed[num] = true
	else
		TriggerEvent("customNotification","You failed to break the glass - more force would help.",2)
		ClearPedTasks(PlayerPedId())
	end	
end
RegisterNetEvent('event:control:jewelRob')
AddEventHandler('event:control:jewelRob', function(useID)
	if not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and exports['np_handler']:isPed("countpolice") >= 5 and not hasrobbed[useID] then
		local v = locations[useID]
		local player = GetPlayerPed( -1 )
		TaskTurnPedToFaceCoord(player,v[1],v[2],v[3],1.0)
		Citizen.Wait(2000)
		loadParticle()
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash",v[1],v[2],v[3], 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimation()
		AttackGlass(useID)
	end
end)

-- #MarkedForMarker
local warning = false
Citizen.CreateThread(function()
	while true do
		if (#(GetEntityCoords(PlayerPedId()) - vector3(-626.5326, -238.3758, 38.05)) < 50.0 ) then
			for i=1,#locations do
				local v = locations[i]
				if (#(GetEntityCoords(PlayerPedId()) - vector3(v[1],v[2],v[3])) < 0.8 ) then
					if (not hasrobbed[i]) then
						DrawText3Ds(v[1],v[2],v[3])
					end
				end
			end
			Citizen.Wait(1)
		else
			Citizen.Wait(6000)
		end
	end
end)

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
    RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

function loadAnimation()
	loadAnimDict( "missheist_jewel" ) 
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'robberyglassbreak', 0.5)
	TaskPlayAnim( PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
	Citizen.Wait(2200)
end

function DT(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText3Ds(x,y,z)
	local text = "Press [~r~E~s~] to rob!"
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
    local table = remoteCalls.execute("np-jewelrob:recieveCoords")
    for i = 1, #table do
        exports["np-target"]:AddBoxZone(tostring(i)..'-jewelrob', vector3(table[i]["coords"].x, table[i]["coords"].y, table[i]["coords"].z), table[i]["coords"].width, table[i]["coords"].height, {
            name= tostring(i)..'-jewelrob',
            debugPoly=false,
            heading= table[i]["coords"].h,
            minZ= table[i]["coords"].minZ,
            maxZ= table[i]["coords"].maxZ
        }, {
            options = {
                {
                    event = table[i].event,
                    icon = table[i].icon,
                    label = table[i].label
                },
            },
            job = {"all"},
            distance = 1.5
        })
    end
end)

RegisterNetEvent('np-jewelrob:keypad')
AddEventHandler('np-jewelrob:keypad', function()
	StartPanel()
    exports['np-memory']:StartMinigame({
        success = 'np-keypad:unlockdoor',
        fail = 'fleeca:fail:panel'
    })
end)

RegisterNetEvent('np-request:depositbox')
AddEventHandler('np-request:depositbox', function()
   remoteCalls.execute("np-jewlrob:unlockbox")
end)

RegisterNetEvent('np-keypad:unlockdoor')
AddEventHandler('np-keypad:unlockdoor', function()
	local ply = PlayerPedId()
	ClearPedTasksImmediately(ply)
	TriggerEvent('DoShortHudText', 'The keypad has been fried')
	Citizen.Wait(3000)
	TriggerEvent('DoShortHudText', 'Door has been unlocked!', 1)
	TriggerServerEvent("np-doors:changeLock-status", 124, false)
end)

RegisterNetEvent("np-jewlrob:safecrack")
AddEventHandler("np-jewlrob:safecrack", function()
	if exports["np-inventory"]:hasEnoughOfItem("advlockpick",1) then
		TriggerEvent("safecracking:loop",10,"robbery:jewelrob")
	else
		TriggerEvent('DoShortHudText', 'You are missing items!', 1)
	end
end)

RegisterNetEvent("robbery:jewelrob")
AddEventHandler("robbery:jewelrob", function()
	local chance = math.random(1, 100)
	if chance <= 50 then
		TriggerEvent('player:receiveItem', 'electronickit', 1)
	end
	TriggerEvent('player:receiveItem', 'bdiamond', 1)
	TriggerEvent('DoLongHudText', 'You have cracked the deposit box!', 2)
end)

function StartPanel()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, -629.15826416016, -230.81062316895, 38.057060241699-0.9, 2.0, -1, 0.0)
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, 30.252712249756)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", -629.15826416016, -230.81062316895, 38.057060241699 -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, 30.252712249756)
    while IsEntityPlayingAnim(ply, "anim@heists@ornate_bank@hack", "hack_enter", 3) do
        Wait(0)
    end
    laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
    Wait(0)
    SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
    PlaceObjectOnGroundProperly(laptop)
    Wait(0)
    TaskPlayAnim(ply, "anim@heists@ornate_bank@hack", "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)
end