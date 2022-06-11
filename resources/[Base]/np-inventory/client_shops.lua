local weashop_locations = {
	{entering = {811.973572,-2155.33862,28.8189938}, inside = {811.973572,-2155.33862,28.8189938}, outside = {811.973572,-2155.33862,28.8189938},delay = 900},
	{entering = { 1692.54, 3758.13, 34.71}, inside = { 1692.54, 3758.13, 34.71}, outside = { 1692.54, 3758.13, 34.71},delay = 600},
	{entering = {252.915,-48.186,69.941}, inside = {252.915,-48.186,69.941}, outside = {252.915,-48.186,69.941},delay = 600},
	{entering = {844.352,-1033.517,28.094}, inside = {844.352,-1033.517,28.194}, outside = {844.352,-1033.517,28.194},delay = 780},
	{entering = {-331.487,6082.348,31.354}, inside = {-331.487,6082.348,31.454}, outside = {-331.487,6082.348,31.454},delay = 600},
	{entering = {-664.268,-935.479,21.729}, inside = {-664.268,-935.479,21.829}, outside = {-664.268,-935.479,21.829},delay = 600},
	{entering = {-1305.427,-392.428,36.595}, inside = {-1305.427,-392.428,36.695}, outside = {-1305.427,-392.428,36.695},delay = 600},
	{entering = {-1119.1, 2696.92, 18.56}, inside = {-1119.1, 2696.92, 18.56}, outside = {-1119.1, 2696.92, 18.56},delay = 600},
	{entering = {2569.978,294.472,108.634}, inside = {2569.978,294.472,108.734}, outside = {2569.978,294.472,108.734},delay = 800},
	{entering = {-3172.584,1085.858,20.738}, inside = {-3172.584,1085.858,20.838}, outside = {-3172.584,1085.858,20.838},delay = 600},
	{entering = {20.0430,-1106.469,29.697}, inside = {20.0430,-1106.469,29.797}, outside = {20.0430,-1106.469,29.797},delay = 600},
}

local tool_shops = {
	{ ['x'] = 44.838947296143, ['y'] = -1748.5364990234, ['z'] = 29.549386978149 },
	{ ['x'] = 2749.2309570313, ['y'] = 3472.3308105469, ['z'] = 55.679393768311 },
}


local twentyfourseven_shops = {
	{ ['x'] = 25.925277709961, ['y'] = -1347.4022216797, ['z'] = 29.482055664062},
    { ['x'] = -48.34285736084, ['y'] = -1757.7890625, ['z'] = 29.414672851562},
    { ['x'] = -707.9208984375, ['y'] = -914.62414550781, ['z'] = 19.20361328125},
    { ['x'] = 1135.6878662109, ['y'] = -981.71868896484, ['z'] = 46.399291992188},
    { ['x'] = -1223.6307373047, ['y'] = -906.76483154297, ['z'] = 12.312133789062},
    { ['x'] = 373.81979370117, ['y'] = 326.0439453125, ['z'] = 103.55383300781},
    { ['x'] = 1163.6439208984, ['y'] = -324.13186645508, ['z'] = 69.197021484375},
    { ['x'] = -2968.298828125, ['y'] = 390.59341430664, ['z'] = 15.041748046875},
    { ['x'] = -3242.4658203125, ['y'] = 1001.6703491211, ['z'] = 12.817626953125},
    { ['x'] = -1820.7427978516, ['y'] = 792.36926269531, ['z'] = 138.11279296875},
    { ['x'] = 2557.1472167969, ['y'] = 382.12747192383,['z'] = 108.60876464844},
    { ['x'] = 2678.8879394531, ['y'] = 3280.3911132812, ['z'] = 55.228515625},
    { ['x'] = 1961.5648193359, ['y'] = 3740.6901855469, ['z'] = 32.329711914062},
    { ['x'] = 1392.3824462891, ['y'] = 3604.5495605469, ['z'] = 34.97509765625},
    { ['x'] = 1698.158203125, ['y'] = 4924.404296875, ['z'] = 42.052001953125},
    { ['x'] = 1728.9230957031, ['y'] = 6414.3823242188, ['z'] = 35.025634765625},
    { ['x'] = 1166.4000244141, ['y'] = 2709.1647949219, ['z'] = 38.142822265625},
    { ['x'] = 547.49011230469, ['y'] = 2671.2131347656, ['z'] = 42.153076171875},
    { ['x'] = 1841.3670654297, ['y'] = 2591.2878417969,['z'] = 46.01171875},
}

local weashop_blips = {}

Citizen.CreateThread(function()
	setShopBlip()
end)


function setShopBlip()

	for station,pos in pairs(weashop_locations) do
		local loc = pos
		pos = pos.entering
		local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
		-- 60 58 137
		SetBlipSprite(blip,110)
		SetBlipScale(blip, 0.6)
		SetBlipColour(blip, 17)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Ammunation')
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,true)
		SetBlipAsMissionCreatorBlip(blip,true)
		weashop_blips[#weashop_blips+1]= {blip = blip, pos = loc}
	end

	for k,v in ipairs(twentyfourseven_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.6)
		SetBlipColour(blip, 0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Shop")
		EndTextCommandSetBlipName(blip)
	end

	for k,v in ipairs(tool_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 544)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tool Shop")
		EndTextCommandSetBlipName(blip)
	end	

end

RegisterNetEvent('shop:general')
AddEventHandler('shop:general', function()
	TriggerEvent("server-inventory-open", "2", "Shop")
	Wait(1000)
end)

RegisterNetEvent('police:general')
AddEventHandler('police:general', function()
	TriggerEvent("server-inventory-open", "10", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('toolshop:general')
AddEventHandler('toolshop:general', function()
	TriggerEvent("server-inventory-open", "4", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('courthouse:idbuy')
AddEventHandler('courthouse:idbuy', function()
	TriggerEvent("player:receiveItem",'idcard', 1)
	Wait(1000)
end)

-------------------------------------
-------- Mechanic Shops Shit --------
-------------------------------------

RegisterNetEvent('mech:craft')
AddEventHandler('mech:craft', function()
	local job = exports["np_handler"]:isPed("myJob")
	if job == "hayes_autos" or job == 'harmony_autos' or job == 'auto_exotics' or job == 'tuner_shop' or job == "best_buds" or job == "bean_machine" then
		TriggerEvent("server-inventory-open", "27", "Craft");	
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "You dont have access to this", 2)
	end
end)

RegisterNetEvent('tunershop:craft')
AddEventHandler('tunershop:craft', function()
	local job = exports["np_handler"]:isPed("myJob")
	if job == "tuner_shop" then
		TriggerEvent("server-inventory-open", "171", "Craft");	
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "You dont have access to this", 2)
	end
end)


RegisterNetEvent("open:storage")
AddEventHandler("open:storage", function(shop)
	local job = exports["np_handler"]:isPed("myJob")
	if job == "hayes_autos" or job == 'harmony_autos' or job == 'auto_exotics' or job == 'tuner_shop' or job == "best_buds" or job == "bean_machine" or job == "burger_shot" or job == "bahamas_bar" or job == "vanilla_unicorn" or job == "news" or job == "winery" or job == "bean_machine" or job == "car_shop" then
		TriggerEvent("server-inventory-open", "1", job);
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "You dont have access to this", 2)
	end
end)

RegisterNetEvent("open:display")
AddEventHandler("open:display", function(shop)
	local job = exports["np_handler"]:isPed("myJob")
	if job == "burger_shot" then
		TriggerEvent("server-inventory-open", "1", "burgershot-display");
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "You dont have access to this", 2)
	end
end)

RegisterNetEvent("winery:craft")
AddEventHandler("winery:craft", function()
	TriggerEvent("server-inventory-open", "221", "Shop");
	Wait(1000)
end)

RegisterNetEvent("open:tray")
AddEventHandler("open:tray", function(shop)
	TriggerEvent("server-inventory-open", "1", shop);
	Wait(1000)
end)

-----------------------
-------- Shops --------
-----------------------

RegisterNetEvent('shops:food')
AddEventHandler('shops:food', function()
	TriggerEvent("server-inventory-open", "550", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('taco:craft')
AddEventHandler('taco:craft', function()
	TriggerEvent("server-inventory-open", "18", "Craft");	
	Wait(1000)
end)

RegisterNetEvent('shops:coffee')
AddEventHandler('shops:coffee', function()
	TriggerEvent("server-inventory-open", "549", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('shops:soda')
AddEventHandler('shops:soda', function()
	TriggerEvent("server-inventory-open", "548", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('shops:water')
AddEventHandler('shops:water', function()
	TriggerEvent("server-inventory-open", "551", "Shop");	
	Wait(1000)
end)

RegisterCommand("test0", function()
  TriggerEvent("shops:flyscrooge")
end)

------------------------
------ Burgershot ------
------------------------

RegisterNetEvent('burgershot:craft')
AddEventHandler('burgershot:craft', function()
	TriggerEvent("server-inventory-open", "897", "Craft");	
	Wait(1000)
end)

RegisterNetEvent('burgershot:order')
AddEventHandler('burgershot:order', function()
	TriggerEvent("server-inventory-open", "654", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('weed:order')
AddEventHandler('weed:order', function()
	TriggerEvent("server-inventory-open", "655", "Shop");	
	Wait(1000)
end)

------------------------
------ Bean Machine ------
------------------------


RegisterNetEvent('bean:craft')
AddEventHandler('bean:craft', function()
	TriggerEvent("server-inventory-open", "1312", "Craft");	
	Wait(1000)
end)

RegisterNetEvent('bean:order')
AddEventHandler('bean:order', function()
	TriggerEvent("server-inventory-open", "1311", "Shop");	
	Wait(1000)
end)

-------------------------------
------ Police Department ------
-------------------------------

RegisterNetEvent('evidence:general')
AddEventHandler('evidence:general', function()
	local job = exports["np_handler"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "trash-1")
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	end
end)

RegisterNetEvent('personallocker:general')
AddEventHandler('personallocker:general', function()
	local cid = exports["np_handler"]:isPed("cid")
	local job = exports["np_handler"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "personalMRPD-"..cid)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	end
end)

RegisterNetEvent('pmeth:general')
AddEventHandler('pmeth:general', function()
	local finished = exports["np-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
		TriggerEvent("server-inventory-open", "25", "Shop")
		Wait(1000)
	end
end)

RegisterNetEvent('prisonap:general')
AddEventHandler('prisonap:general', function()
	local finished = exports["np-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
	  	TriggerEvent("server-inventory-open", "26", "Shop");
	  	Wait(1000)
  	end
end)

RegisterNetEvent('prisonlp:general')
AddEventHandler('prisonlp:general', function()
	local finished = exports["np-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
	  	TriggerEvent("server-inventory-open", "921", "Craft");
	  	Wait(1000)
  	end
end)

RegisterNetEvent("police:get:keyfob")
AddEventHandler("police:get:keyfob", function()
	if not exports["np-inventory"]:hasEnoughOfItem("keyfob",1,false) then
		TriggerEvent("player:receiveItem","keyfob",1,true)
	else 
		TriggerEvent("DoLongHudText", "You already Have a Key Fob", "2")
	end
end)

RegisterNetEvent('slushy:general')
AddEventHandler('slushy:general', function()
	local finished = exports["np-taskbar"]:taskBar(60000,"Making a god slushy...")
	if (finished == 100) then
		TriggerEvent("server-inventory-open", "998", "Shop")
		Wait(1000)
	end
end)

RegisterNetEvent('pfood:general')
AddEventHandler('pfood:general', function()
	TriggerEvent("server-inventory-open", "22", "Shop")
	Wait(1000)
end)

RegisterNetEvent('bestbuds:shop')
AddEventHandler('bestbuds:shop', function()
	TriggerEvent("server-inventory-open", "99", "Craft")
	Wait(1000)
end)

RegisterNetEvent('pnpc:general')
AddEventHandler('pnpc:general', function()
	TriggerEvent("server-inventory-open", "997", "Craft")
	Wait(1000)
end)

RegisterNetEvent('recycle:trade')
AddEventHandler('recycle:trade', function()
	TriggerEvent("server-inventory-open", "103", "Craft")
	Wait(1000)
end)

RegisterNetEvent('ems:general')
AddEventHandler('ems:general', function()
	local job = exports["np_handler"]:isPed("myJob")
	if (job == "ems" or job == "doctor") then
		TriggerEvent("server-inventory-open", "15", "Shop");	
	else
		TriggerEvent("DoLongHudText", "You aint a EMS, bounce out!", 2)
	end
end)

RegisterNetEvent('weapon:general')
AddEventHandler('weapon:general', function()
	local weaponslicence = exports["np_handler"]:isPed("weaponslicence")
	if weaponslicence ~= 0 then
		TriggerEvent("server-inventory-open", "5", "Shop");
		Wait(1000)
	else
		TriggerEvent("server-inventory-open", "6", "Shop");
		Wait(1000)
		TriggerEvent("DoLongHudText", "You dont have an active firearms license, contact the police.", 2)
	end
end)


RegisterNetEvent('robs:general')
AddEventHandler('robs:general', function()
	TriggerEvent("server-inventory-open", "999", "Shop");	
end)


RegisterNetEvent('weed_shop:open')
AddEventHandler('weed_shop:open', function()
	TriggerEvent("server-inventory-open", "420", "Shop");	
end)


function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

RegisterNetEvent('np-hunting:general')
AddEventHandler('np-hunting:general', function()
    TriggerEvent("server-inventory-open", "941", "Shop")
    Wait(1000)
end)

RegisterNetEvent("iciest :idcardbuy")
AddEventHandler("iciest :idcardbuy", function()
   TriggerServerEvent("iciest :idcard")
end)

RegisterNetEvent('iciest :laptop')
AddEventHandler('iciest :laptop', function()
	TriggerEvent("server-inventory-open", "652", "Craft");	
	Wait(1000)
end)