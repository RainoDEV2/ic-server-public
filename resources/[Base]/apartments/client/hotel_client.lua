local nearType2 = false
local curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
local myroomcoords = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211 }
local currentRoom = {}
local CurrentForced = {x = 0.0,y = 0.0,z=0.0}
local insideApartment = false
currentselection = 1
curappartmentnumber = 0
forcedID = 0
local isnew = false

myRoomNumber = 0
curRoomType = 1
myRoomType = 1
isForced = false

function inRoom()
	if #(vector3(myroomcoords.x,myroomcoords.y,myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 40.0 then
		return true
	else
		return false
	end
end

RegisterNetEvent('hotel:forceOut')
AddEventHandler('hotel:forceOut', function(roomNumber,roomtype)
	isForced = false
	returnCurrentRoom(roomtype,roomNumber)
	if #(vector3(CurrentForced.x, CurrentForced.y, CurrentForced.z) - GetEntityCoords(PlayerPedId())) < 90.0 then
		CleanUpArea()
		if roomNumber == 2 then
			SetEntityCoords(PlayerPedId(),-265.74459838867, -955.15289306641, 31.223152160645)
			SetEntityHeading(PlayerPedId(), 217.77249145508)
		end
	end
	if myRoomNumber == roomNumber then
		CleanUpArea()
		if #(vector3(CurrentForced.x, CurrentForced.y, CurrentForced.z) - GetEntityCoords(PlayerPedId())) < 90.0 then
			if roomNumber == 2 then
				SetEntityCoords(PlayerPedId(),-265.74459838867, -955.15289306641, 31.223152160645)
				SetEntityHeading(PlayerPedId(), 217.77249145508)
			end
		end
	end
end)

function returnCurrentRoom(roomtype,roomNumber)
	if roomtype == 2 then 
		local generator = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
		generator.x = (175.09986877441) + ((roomNumber * 25.0))
		generator.y = (-904.7946166992) - ((roomNumber * 25.0))
		CurrentForced = generator
	end
end

local myspawnpoints = {}
local spawning = false
RegisterNetEvent('hotel:creation:character') -- Only use for first spawn
AddEventHandler('hotel:creation:character', function(numMultiplier,roomType)
	myRoomNumber = numMultiplier
	myRoomType = roomType
	Citizen.Wait(500)
	DoScreenFadeIn(100)
	processBuildType(myRoomNumber, myRoomType)
	TriggerEvent("character:finishedLoadingChar", true)
	TriggerEvent("np-fw:playerSpawned")
	Citizen.Wait(500)
	TriggerServerEvent("np-login:licenses")
	TriggerEvent("DoLongHudText", "Open your backpack; it's full of useful items!", 15)
end)

RegisterNetEvent('hotel:createRoom1')
AddEventHandler('hotel:createRoom1', function(coords, jobs, numMultiplier,roomType,mykeys, illness,isImprisoned,isClothesSpawn)
	local jobSpawns = {
		["police"] = { ['x'] = 461.62664794922, ['y'] = -996.35748291016, ['z'] =  30.682750701904, ['h'] =  88.659965515137, ['info'] = ' Police Spawn', ["typeSpawn"] = 1 },
		["ems"] = { ['x'] = 301.30642700195, ['y'] = -599.59326171875, ['z'] =  43.289108276367, ['h'] =  345.66589355469, ['info'] = ' EMS Spawn', ["typeSpawn"] = 1},
		["hayes_autos"] = { ['x'] = -1428.2806396484, ['y'] = -458.31207275391, ['z'] =  35.914546966553, ['h'] =  319.4404296875, ['info'] = ' Hayes Autos Spawn', ["typeSpawn"] = 1},
		["auto_exotics"] = { ['x'] = 550.64288330078, ['y'] = -182.2551574707, ['z'] = 54.431446075439, ['h'] = 359.6044921875, ['info'] = ' Auto Exotics Spawn', ["typeSpawn"] = 1},
		["judge"] = { ['x'] = -568.20434570312, ['y'] =  -210.05520629883, ['z'] =  38.219043731689, ['h'] = 319.45083618164, ['info'] = ' DOJ Spawn', ["typeSpawn"] = 1},
		["winery"] = { ['x'] = -1902.1671142578, ['y'] =  2070.5620117188, ['z'] =  140.84809875488, ['h'] = 257.40466308594, ['info'] = ' Winery Spawn', ["typeSpawn"] = 1},
		["harmony_autos"] = { ['x'] = 1188.1392822266, ['y'] =  2636.7790527344, ['z'] =  38.330310821533, ['h'] = 5.835319519043, ['info'] = ' Harmony Autos Spawn', ["typeSpawn"] = 1},
		["car_shop"] = { ['x'] = -34.633518218994, ['y'] =  -1106.3970947266, ['z'] =  26.860502243042, ['h'] = 65.278160095215, ['info'] = ' PDM Spawn', ["typeSpawn"] = 1},
	}

	print('this are jobs ', json.encode(jobs))
	local imprisoned = false
	imprisoned = isImprisoned
	spawning = false
	TriggerEvent("spawning",true)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)
	SetEntityInvincible(PlayerPedId(),true)
	myRoomNumber = numMultiplier
	myRoomType = roomType

	TriggerEvent("hotel:myroomtype",myRoomType)
	myspawnpoints  = {
		[1] =  { ['x'] = -204.93,['y'] = -1010.13,['z'] = 29.55,['h'] = 180.99, ['info'] = ' Alta Street Train Station', ["typeSpawn"] = 1 },
		[5] =  { ['x'] = -214.24,['y'] = 6178.87,['z'] = 31.17,['h'] = 40.11, ['info'] = ' Paleto Bus Stop', ["typeSpawn"] = 1 },
		[7] =  { ['x'] = 453.29,['y'] = -662.23,['z'] = 28.01,['h'] = 5.73, ['info'] = ' LS Bus Station', ["typeSpawn"] = 1 },
		[10] =  { ['x'] = 1839.656,['y'] =3672.86401,['z'] = 34.27666,['h'] = 219.7886, ['info'] = ' Sandy Medical Center', ["typeSpawn"] = 1 },

	}
	
	if illness == "dead" or illness == "icu" then
		return
	end

	if roomType == 2 then
		myspawnpoints[#myspawnpoints + 1] = { ['x'] = -267.65209960938, ['y'] = -959.20068359375,['z'] = 31.22313117981,['h'] = 206.28782653809, ['info'] = 'Alta Apartments', ["typeSpawn"] = 2 }
	end

	
	if coords then
		if coords.x then
			if coords.y then
				if coords.z then
--					print('got coords ', coords)
					myspawnpoints[#myspawnpoints + 1] = { ['x'] = coords.x, ['y'] = coords.y,['z'] = coords.z,['h'] = 60, ['info'] = 'Last Location', ["typeSpawn"] = 1 }
				end
			end
		end
	end

	if jobs ~= nil then
		for k,v in ipairs(jobs) do
			myspawnpoints[#myspawnpoints + 1] = jobSpawns[v]
		end
	end


	if mykeys ~= 0 then
		for i, v in pairs(mykeys) do
			local house_model = tonumber(mykeys[i][1]["house_model"])
			local house_id = tonumber(mykeys[i][1]["house_id"])

			local keyinsert = robberycoords[house_id]

			if house_model == 2 then
				keyinsert = robberycoordsMansions[house_id]
				keyinsert["info"] = mykeys[i][1]["house_name"]
			end
			if house_model < 3 or house_model == 5 then
				keyinsert["typeSpawn"] = 3
				keyinsert["info"] = mykeys[i][1]["house_name"]
				keyinsert["house_model"] = mykeys[i][1]["house_model"]
				keyinsert["house_id"] = mykeys[i][1]["house_id"]
				myspawnpoints[#myspawnpoints + 1] = keyinsert
			end
		end
	end
	if isnew == true then
		if roomType == 2 then
			apartmentName = ' Apartments 2'
		end
		confirmSpawning(true)
	else
		if not imprisoned then
			SendNUIMessage({
				openSection = "main",
			})

			SetNuiFocus(true,true)
			doSpawn(myspawnpoints)
			DoScreenFadeIn(2500)
			currentselection = 1
			doCamera()
		elseif imprisoned then
			DoScreenFadeIn(2500)
			doCamera(true)
			prisionSpawn()
		end
	end
 
	

end)

function prisionSpawn()
	spawning = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)


	local x = 1802.51
	local y = 2607.19
	local z = 46.01
	local h = 93.0

	ClearFocus()
	SetNuiFocus(false,false)
	-- spawn them here.
    
    
	RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
	DestroyCam(cam, false)
	SetEntityCoords(PlayerPedId(),x,y,z)
	SetEntityHeading(PlayerPedId(),h)		

	SetEntityInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)

	Citizen.Wait(2000)
	TriggerEvent("attachWeapons")
	TriggerEvent("spawning",false)

	TriggerEvent("tokovoip:onPlayerLoggedIn", true)
	Citizen.Wait(2000)
	TriggerServerEvent("request-dropped-items")
	TriggerServerEvent("HOWMUCHCASHUHGOT")
	TriggerServerEvent("server-request-update",exports["np_handler"]:isPed("cid"))
	TriggerServerEvent("jail:charecterFullySpawend")
	if(DoesCamExist(cam)) then
		DestroyCam(cam, false)
	end
	 TriggerServerEvent("stocks:retrieveclientstocks")
end

RegisterNUICallback('selectedspawn', function(data, cb)

	if spawning then
		return
	end
    currentselection = data.tableidentifier
    -- altercam
    doCamera()
end)
RegisterNUICallback('confirmspawn', function(data, cb)
	spawning = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)
	SendNUIMessage({
		openSection = "close",
	})	
	startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	RenderScriptCams(false, true, 500, true, true)
	SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	SetEntityVisible(PlayerPedId(), true, 0)
	FreezeEntityPosition(PlayerPedId(), false)
    SetPlayerInvisibleLocally(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)

    DestroyCam(startcam, false)
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    Citizen.Wait(0)
    FreezeEntityPosition(PlayerPedId(), false)
	confirmSpawning(false)
end)

function confirmSpawning(isClothesSpawn)

	local x = myspawnpoints[currentselection]["x"]
	local y = myspawnpoints[currentselection]["y"]
	local z = myspawnpoints[currentselection]["z"]
	local h = myspawnpoints[currentselection]["h"]

	ClearFocus()

	SetNuiFocus(false,false)
	-- spawn them here.
    
    
	RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
	DestroyCam(cam, false)

	
	if myspawnpoints[currentselection]["typeSpawn"] == 1 then
		SetEntityCoords(PlayerPedId(),x,y,z)
		SetEntityHeading(PlayerPedId(),h)		
	elseif myspawnpoints[currentselection]["typeSpawn"] == 2 then
		processBuildType(myRoomNumber, myRoomType)
		TriggerEvent("hotel:myroomtype",myRoomType)
	elseif myspawnpoints[currentselection]["typeSpawn"] == 3 then
		local house_id = myspawnpoints[currentselection]["house_id"]
		local house_model = myspawnpoints[currentselection]["house_model"]
		TriggerServerEvent("house:enterhouse",exports['np_handler']:isPed('cid'),house_id,house_model)
	end
	
	SetEntityInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)
	TriggerEvent("attachWeapons")
	TriggerEvent("spawning",false)
	TriggerServerEvent("jail:charecterFullySpawend")
	Citizen.Wait(5000)
	SetEntityVisible(PlayerPedId(), true)
	FreezeEntityPosition(PlayerPedId(), false)
	RenderScriptCams(false,  false,  0,  true,  true)
	SetEntityCollision(PlayerPedId(),  true,  true)
	SetEntityVisible(PlayerPedId(),  true)
	SetNuiFocus(false, false)
	EnableAllControlActions(0)
	DoScreenFadeIn(4000)
	Citizen.Wait(2000)
	if(DoesCamExist(cam)) then
		DestroyCam(cam, false)
	end
end

function doSpawn(array)

	for i = 1, #array do

		SendNUIMessage({
			openSection = "enterspawn",
			textmessage = array[i]["info"],
			tableid = i,
		})
	end
	TriggerServerEvent("np-shops:getCharecter")
end

cam = 0
local camactive = false
local killcam = true
function doCamera(prison)
	killcam = true
	if spawning then
		return
	end
	Citizen.Wait(1)
	killcam = false
	local camselection = currentselection
	DoScreenFadeOut(1)
	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	local x,y,z,h

	if prison then
		 x = 1802.51
		 y = 2607.19
		 z = 46.01
		 h = 93.0
	else
		 x = myspawnpoints[currentselection]["x"]
		 y = myspawnpoints[currentselection]["y"]
		 z = myspawnpoints[currentselection]["z"]
		 h = myspawnpoints[currentselection]["h"]
	end
	
	i = 3200
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	SetCamActive(cam,  true)
	RenderScriptCams(true,  false,  0,  true,  true)
	DoScreenFadeIn(1500)
	local camAngle = -90.0
	while i > 1 and camselection == currentselection and not spawning and not killcam do
		local factor = i / 50
		if i < 1 then i = 1 end
		i = i - factor
		SetCamCoord(cam, x,y,z+i)
		if i < 1200 then
			DoScreenFadeIn(600)
		end
		if i < 90.0 then
			camAngle = i - i - i
		end
		SetCamRot(cam, camAngle, 0.0, 0.0)
		Citizen.Wait(1)
	end

end


function defaultSpawn()
	moveToMyHotel(myRoomType)	
	TriggerEvent("hotel:myroomtype",myRoomType)
end

function moveToMyHotel(roomType)
	TriggerEvent("resetPhone")
	processBuildType(myRoomNumber,roomType)
end

function moveToMultiplierHotel(numMultiplier,roomType)
	processBuildType(tonumber(numMultiplier),tonumber(roomType))
end

function processBuildType(numMultiplier,roomType)
	DoScreenFadeOut(1)
	insideApartment = true
	TriggerEvent("DensityModifierEnable",false)
	TriggerEvent('np-weathersync:client:DisableSync')
	SetEntityInvincible(PlayerPedId(), true)
	TriggerEvent("enabledamage",false)
	--DoScreenFadeOut(1)

	TriggerEvent("dooranim")	
	if roomType == 2 then
		buildRoom2(numMultiplier,roomType)
	end

	curappartmentnumber = numMultiplier

	TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose', 0.2)
	TriggerEvent("dooranim")

	CleanUpPeds()
	--DoScreenFadeIn(100)
	SetEntityInvincible(PlayerPedId(), false)
	FreezeEntityPosition(PlayerPedId(),false)
	TriggerEvent("enabledamage",true)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end



function CleanUpPeds()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstPed()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 50.0 and ObjectFound ~= playerped then
    		if IsPedAPlayer(ObjectFound) or IsEntityAVehicle(ObjectFound) then
    		else
    			DeleteEntity(ObjectFound)
    		end            
        end
        success, ObjectFound = FindNextPed(handle)
    until not success
    EndFindPed(handle)
end

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 50.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    curappartmentnumber = 0
    TriggerEvent("DensityModifierEnable",true)
	TriggerEvent("np-weathersync:client:EnableSync")
end

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

function getRotation(input)
	return 360/(10*input)
end

function buildRoom2(numMultiplier,roomType)
	local generator = { x=286.28950000 , y = -925.59500000, z = -22.61290000}
	generator.x = (286.28950000) + ((numMultiplier * 12.0))
	
	if numMultiplier == myRoomNumber then
		myroomcoords = generator
	else
		curRoom = generator
	end

	SetEntityCoords(PlayerPedId(), 303.1188659668, -924.82373046875, -21.558765411377)
	SetEntityHeading(PlayerPedId(), 179.83103942871)
	FreezeEntityPosition(PlayerPedId(), true)

	RequestModel(GetHashKey("bam_motel_shell"))
	while not HasModelLoaded(GetHashKey("bam_motel_shell")) do
		RequestModel(GetHashKey("bam_motel_shell"))
		Citizen.Trace("Loading Model")
   		Citizen.Wait(100)
	end

	Citizen.Wait(4500)

	local building = CreateObject(GetHashKey('bam_motel_shell'),generator.x,generator.y,generator.z,false,false,false)

	FreezeEntityPosition(building,true)
	Citizen.Wait(100)
	
	CreateObject(GetHashKey("bam_motel_room01"), generator.x, generator.y, generator.z,false,false,false)
	CreateObject(GetHashKey("bam_motel_room02"),generator.x,generator.y,generator.z,false,false,false)
	CreateObject(GetHashKey("bam_motel_frames"),generator.x,generator.y,generator.z,false,false,false)
	CreateObject(GetHashKey("bam_motel_closet"),generator.x+0.89324950,generator.y+2.91949500,generator.z + 0.5,false,false,false)
	CreateObject(GetHashKey("V_49_MotelMP_Clothes"),generator.x+0.89324950,generator.y+2.88928200,generator.z + 0.5,false,false,false)
	CreateObject(GetHashKey("Prop_LD_Shoe_01"),generator.x+0.89324950,generator.y+2.85028100,generator.z,false,false,false)
	CreateObject(GetHashKey("ex_Prop_TV_SetTop_Box"),generator.x+3.40274000,generator.y+0.73193360,generator.z + 0.9,false,false,false)
	local Television = CreateObject(GetHashKey("Prop_TV_Flat_02"),generator.x+2.64279200,generator.y+0.75183110,generator.z + 0.9,false,false,false)
	CreateObject(GetHashKey("ex_Prop_TV_SetTop_Remote"),generator.x+3.40274000,generator.y+0.73193360,generator.z -0.43401530,false,false,false)
	local coffee = CreateObject(GetHashKey("apa_mp_h_acc_coffeeMachine_01"),generator.x+1.73294100,generator.y+0.73193360,generator.z + 0.9,false,false,false)
	CreateObject(GetHashKey("Prop_Mug_01"),generator.x+1.93844600,generator.y+0.73193360,generator.z + 0.9,false,false,false)
	local lamp1 = CreateObject(GetHashKey("apa_mp_h_lit_LampTable_005"),generator.x+1.88562000,generator.y -4.05139100,generator.z + 0.45,false,false,false)
	local lamp2 = CreateObject(GetHashKey("apa_mp_h_lit_LampTable_005"),generator.x+5.28677400,generator.y -4.05139100,generator.z + 0.45,false,false,false)
	local lamp3 = CreateObject(GetHashKey("apa_mp_h_lit_LampTable_005"),generator.x+0.20452880,generator.y -4.05139100,generator.z + 0.5,false,false,false)
	local lamp4 = CreateObject(GetHashKey("apa_mp_h_lit_LampTable_005"),generator.x-2.89892600,generator.y -4.05139100,generator.z + 0.5,false,false,false)
	local fruit = CreateObject(GetHashKey("ex_mp_h_acc_FruitBowl_01"),generator.x+3.48535200,generator.y -2.44305400,generator.z + 0.45,false,false,false)
	CreateObject(GetHashKey("apa_mp_h_acc_RugWoolS_03"),generator.x+3.48535200,generator.y -2.44305400,generator.z + 0.0,false,false,false)
	CreateObject(GetHashKey("P_Yoga_Mat_02_S"),generator.x+3.9,generator.y + 0.53466800,generator.z + 0.0,false,false,false)
	local phone = CreateObject(GetHashKey("hei_Prop_Hei_Bank_Phone_01"),generator.x-2.63116400,generator.y -4.05139100,generator.z + 0.5,false,false,false)

	local raccoon = CreateObject(GetHashKey("bam_motel_bmirror"),generator.x-3.89477500,generator.y+2.66748000, generator.z+0.16340260 ,false,false,false)
	CreateObject(GetHashKey("bam_motel_blinds"),generator.x,generator.y,generator.z - 0.45,false,false,false)
	CreateObject(GetHashKey("bam_motel_bath"),generator.x,generator.y,generator.z,false,false,false)
	local art = CreateObject(GetHashKey("bam_motel_art"),generator.x,generator.y,generator.z + 1.3,false,false,false)

	local rapping = CreateObject(GetHashKey("bam_motel_mirror"),generator.x-0.59313970,generator.y+4.45361300,generator.z + 0.5,false,false,false)
	local penis = CreateObject(GetHashKey("Apa_p_mp_door_Apart_door_black"),generator.x-1.78878800,generator.y+4.04730200,generator.z-0.23522950,false,false,false)
	local clock = CreateObject(GetHashKey("Prop_Game_Clock_02"),generator.x+1.22537200,generator.y -1.86096200,generator.z + 1.5,false,false,false)
	local tv = CreateObject(GetHashKey("Prop_TV_Flat_Michael"),generator.x-2.83258100,generator.y + 0.97863770,generator.z + 1.5,false,false,false)
	local tv = CreateObject(GetHashKey("V_Res_FH_speakerDock"),generator.x-2.83258100,generator.y + 0.97863770,generator.z + 0.97,false,false,false)

	FreezeEntityPosition(fruit,true)
	FreezeEntityPosition(lamp1,true)
	FreezeEntityPosition(lamp2,true)
	FreezeEntityPosition(lamp3,true)
	FreezeEntityPosition(lamp4,true)
	FreezeEntityPosition(coffee,true)
	FreezeEntityPosition(art,true)
	FreezeEntityPosition(Television,true)
	FreezeEntityPosition(rapping,true)
	FreezeEntityPosition(raccoon,true)
	FreezeEntityPosition(penis, true)
	FreezeEntityPosition(clock, true)
	SetEntityHeading(fruit,GetEntityHeading(fruit)+270)
	SetEntityHeading(raccoon,GetEntityHeading(raccoon)+93)
	SetEntityHeading(phone,GetEntityHeading(phone)+189)
	SetEntityHeading(clock,GetEntityHeading(clock)+ 275)
	SetEntityHeading(rapping,GetEntityHeading(rapping)+ 1)
  	SetEntityCoords(PlayerPedId(), generator.x+ 4.8,generator.y + 0.6,generator.z+0.10)
  	SetEntityHeading(PlayerPedId(), 177.9542388916)
  	Wait(2000)
  	FreezeEntityPosition(PlayerPedId(), false)


	if not isForced then
		TriggerServerEvent('hotel:getID')
	end
	curRoomType = 2

end

function FloatTilSafe(numMultiplier,roomType,buildingsent)
	SetEntityInvincible(PlayerPedId(),true)
	FreezeEntityPosition(PlayerPedId(),true)
	local plyCoord = GetEntityCoords(PlayerPedId())
	local processing = 3
	local counter = 100
	local building = buildingsent
	while processing == 3 do
		Citizen.Wait(100)
		if DoesEntityExist(building) then

			processing = 2
		end
		if counter == 0 then
			processing = 1
		end
		counter = counter - 1
	end

	if counter > 0 then
		SetEntityCoords(PlayerPedId(),plyCoord)
		CleanUpPeds()
	elseif processing == 1 then
		if roomType == 2 then
			SetEntityCoords(PlayerPedId(),287.3512,-647.3933,41.980)
		end
		TriggerEvent("DoLongHudText","Failed to load, please retry.",2)	
	end
	TriggerEvent("reviveFunction")	

end



function DrawText3Ds(x,y,z, text)
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

local canInteract = true

RegisterNetEvent('hotel:interactState')
AddEventHandler('hotel:interactState', function(state)
	canInteract = state
end)

local comparedst = 1000
function smallestDist(typeCheck)
	if typeCheck < comparedst then
		comparedst = typeCheck
	end
end

Controlkey = {
	["generalUse"] = {38,"E"},
	["housingMain"] = {38,"E"},
	["housingSecondary"] = {47,"G"}
} 

RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["housingMain"] = table["housingMain"]
	Controlkey["housingSecondary"] = table["housingSecondary"]

	if Controlkey["housingSecondary"] == nil or Controlkey["housingMain"] == nil or Controlkey["generalUse"] == nil then
		Controlkey = {["generalUse"] = {38,"E"},["housingMain"] = {74,"H"},["housingSecondary"] = {47,"G"}} 
	end
end)

RegisterNetEvent('character:isNew')
AddEventHandler('character:isNew', function(isNew)
	isnew = isNew
end)

Citizen.CreateThread(function()

 	while true do
		Citizen.Wait(0)

		comparedst = 1000

		local plyId = PlayerPedId()
		local plyCoords = GetEntityCoords(plyId)

		local entry2nd = #(vector3(-265.7887878418, -955.20324707031, 31.223152160645) - plyCoords)
	
		smallestDist(entry2nd)


		if insideApartment or comparedst < 100 then
			if (entry2nd < 5 and myRoomType == 2) then

				if myRoomType == 2 then
					if nearType2 then
						TriggerEvent('np-textui:ShowUI', 'show', ("["..Controlkey["housingMain"][2].."] %s"):format("To Enter Apartments"))
					end
				end

				if IsControlJustReleased(1,Controlkey["housingMain"][1]) then
					TriggerEvent("DoLongHudText","Entering Apartment Room!",1)

					Citizen.Wait(300)
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.2)

					if #(vector3(-265.7887878418, -955.20324707031, 31.223152160645) - plyCoords) < 5 and myRoomType == 2 then
						processBuildType(myRoomNumber,myRoomType)
					else
						TriggerEvent("DoLongHudText","Moved too far away!",2)
					end			
				end
			end



			if #(vector3(myroomcoords.x +1, myroomcoords.y + 3.2, myroomcoords.z) - plyCoords) < 1.5 and curRoomType == 2 then
				DrawText3Ds(myroomcoords.x + 1, myroomcoords.y + 3.2, myroomcoords.z+ 1, '[~g~'..Controlkey["housingSecondary"][2]..'~s~] - change characters | /outfits.')
				TriggerEvent("np-clothingmenu:enable", true)
				if IsControlJustReleased(1,Controlkey["housingSecondary"][1]) then
					logout()
				end
			end
			if 	
			(#(vector3(myroomcoords.x + 4.8,myroomcoords.y + 0.6 ,myroomcoords.z) - plyCoords) < 3.0 and curRoomType == 2) 
			then
				
				if curRoomType == 2 then
					DrawText3Ds(myroomcoords.x + 4.8,myroomcoords.y + 0.6 ,myroomcoords.z+1.20, '[~g~'..Controlkey["housingMain"][2]..'~s~] - Exit Apartment')
					TriggerEvent("np-clothingmenu:enable", false)
				end

				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.2)
					Wait(330)
					CleanUpArea()
					isForced = false
					TriggerEvent("enabledamage",false)
					if curRoomType == 2 then
						SetEntityCoords(PlayerPedId(),-265.74459838867, -955.15289306641, 31.223152160645)
						SetEntityHeading(PlayerPedId(), 117.88721466064)
					end
					TriggerEvent("enabledamage",true)
					insideApartment = false
					Citizen.Wait(100)
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose',0.2)
					curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
					TriggerEvent("attachWeapons")
				end
 
			end

		if 	(#(vector3(myroomcoords.x - 1.6, myroomcoords.y + 1.20, myroomcoords.z + 1.00) - plyCoords) < 2.0 and curRoomType == 1) or 
		    (#(vector3(myroomcoords.x - 1.6, myroomcoords.y + 1.20, myroomcoords.z + 1.00) - plyCoords) < 2.0 and curRoomType == 2) or 
			(#(vector3(myroomcoords.x + 1.5, myroomcoords.y + 8.00, myroomcoords.z + 1.00) - plyCoords) < 5.0 and curRoomType == 3) 
			and canInteract 
		then
				if curRoomType == 2 then
					DrawText3Ds(myroomcoords.x - 2.8,myroomcoords.y + 0.2, myroomcoords.z+1, '[~g~'..Controlkey["housingMain"][2]..'~s~] - Open Stash')
				end

				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
					if inRoom() then
						canInteract = false
						TriggerEvent('InteractSound_CL:PlayOnOne','StashOpen', 0.6)
						maxRoomWeight = 100.0 * (curRoomType * 2)
						if not isForced then
							TriggerServerEvent('hotel:getID')
						end
						TriggerEvent("server-inventory-open", "1", "motel"..curRoomType.."-".. exports["np_handler"]:isPed("cid"))

						TriggerEvent("actionbar:setEmptyHanded")
					else
						TriggerEvent("DoLongHudText","This is not your stash!",2)
					end
					Citizen.Wait(1900)
				end
			end

		if 	(#(vector3(curRoom.x - 1.6, curRoom.y + 1.20, curRoom.z + 1.00) - plyCoords) < 2.0 and curRoomType == 1) or 
			(#(vector3(curRoom.x + 9.8, curRoom.y - 1.35, curRoom.z + 0.15) - plyCoords) < 2.0 and curRoomType == 2) or 
			(#(vector3(curRoom.x + 1.5, curRoom.y + 8.00, curRoom.z + 1.00) - plyCoords) < 2.0 and curRoomType == 3) and 
			canInteract 
		then

			if curRoomType == 2 then
				DrawText3Ds(curRoom.x+9.8, curRoom.y - 1.35, curRoom.z+2.15, '[~g~'..Controlkey["housingMain"][2]..'~s~] - Open Stash')
			elseif curRoomType == 3 then
				DrawText3Ds(curRoom.x + 1.5, curRoom.y + 8, curRoom.z+1, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
			elseif curRoomType == 1 then
				DrawText3Ds(curRoom.x - 1.6,curRoom.y + 1.2, curRoom.z+1, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
			end

			if IsControlJustReleased(1, Controlkey["housingMain"][1]) then

				local myJob = exports["np_handler"]:isPed("myJob")
				local LEO = false
				if myJob == "police" or myJob == "judge" then
					LEO = true
				end

				if LEO then
					canInteract = false
					TriggerEvent('InteractSound_CL:PlayOnOne','StashOpen', 0.6)
					maxRoomWeight = 500.0 * curRoomType
					TriggerServerEvent('hotel:getID')
					--TriggerServerEvent('hotel:GetInteract',maxRoomWeight,forcedID)

					TriggerEvent("server-inventory-open", "1", "motel"..curRoomType.."-"..forcedID)

				else
					TriggerEvent("DoLongHudText","This is not your stash!",2)
				end
				Citizen.Wait(1900)
			end

		end



	
		if 	
			(#(vector3(curRoom.x + 4.3,curRoom.y - 15.95,curRoom.z+0.42) - plyCoords) < 3.0 and curRoomType == 2) 
		then
				if curRoomType == 2 then
					DrawText3Ds(curRoom.x + 4.3,curRoom.y - 15.95,curRoom.z+2.42, '[~g~'..Controlkey["housingMain"][2]..'~s~] - Exit Apartment')
				end


				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then

					Wait(200)
					CleanUpArea()

					if curRoomType == 2 then
						SetEntityCoords(PlayerPedId(),-265.74459838867, -955.15289306641, 31.223152160645)
						SetEntityHeading(PlayerPedId(), 217.77249145508)
					end

					Citizen.Wait(2000)
					curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
					TriggerEvent("attachWeapons")
				end

			end			
		end
	end
end)

function logout()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)
    CleanUpArea()
    Citizen.Wait(1000)   
	TriggerEvent("np-fw:clearStates")
    exports["np-fw"]:getModule("SpawnManager"):Initialize()
	Citizen.Wait(1000)
end

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("apartment_enter", vector3(-265.85, -955.26, 31.22), 2.6, 3.0, {
		name="apartment_enter",
		heading=27,
		--debugPoly=true,
		minZ=30.22,
		maxZ=34.22
    }) 
end)


RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "apartment_enter" then
        nearType2 = true
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "apartment_enter" then
        nearType2 = false
    end
    TriggerEvent('np-textui:HideUI')
end)

RegisterNetEvent("apartments:leave", function()
	TriggerEvent("dooranim")
	TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen',0.2)
	Wait(330)
	CleanUpArea()
	TriggerEvent("enabledamage",false)
	SetEntityCoords(PlayerPedId(),-265.74459838867, -955.15289306641, 31.223152160645)
	SetEntityHeading(PlayerPedId(), 217.77249145508)
	TriggerEvent("enabledamage",true)
	Citizen.Wait(100)
	TriggerEvent("dooranim")
	TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose', 0.2)
	TriggerEvent("attachWeapons")
	TriggerEvent("np-clothingmenu:enable", false)
end)
