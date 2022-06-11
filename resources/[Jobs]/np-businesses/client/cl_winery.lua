RegisterNetEvent("np-winery:washmoney")
AddEventHandler("np-winery:washmoney", function()
  local myJob = exports["np_handler"]:isPed("myJob")
  if myJob == "winery" then
  if exports["np-inventory"]:hasEnoughOfItem("rollcash",5) then
    TriggerEvent("animation:winery")
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityHeading(PlayerPedId(), 359.19152832031)
    local finished = exports['np-taskbar']:taskBar(10000, 'Washing Money')
      if (finished == 100) then 
		TriggerEvent("inventory:removeItem", "rollcash", 5)
        FreezeEntityPosition(PlayerPedId(),false)
        remoteCalls.execute("np-winery:washmoney")
     end
    else 
        TriggerEvent("DoLongHudText", "You don't have enough money to wash!")
      end
    end 
end)

RegisterNetEvent('animation:winery')
AddEventHandler('animation:winery', function()
	inanimation = true
	local lPed = PlayerPedId()
	RequestAnimDict("mini@repair")
	while not HasAnimDictLoaded("mini@repair") do
		Citizen.Wait(0)
	end

	if IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
		ClearPedSecondaryTask(lPed)
	else
		TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 49, 0, 0, 0, 0)
		seccount = 4
		while seccount > 0 do
			Citizen.Wait(10000)
			FreezeEntityPosition(PlayerPedId(),false)
			seccount = seccount - 1
		end
		ClearPedSecondaryTask(lPed)
	end		
	inanimation = false
end)

function LoadDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(10)
  end
end