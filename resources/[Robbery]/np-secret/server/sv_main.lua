-- RegisterServerEvent("np-fleeca:item")
-- AddEventHandler("np-fleeca:item", function()
--   local pSrc = source 
--   TriggerClientEvent("DoLongHudText", pSrc, "Lester Is Getting The Item Hold On.", 1)
--   Citizen.Wait(1500)
--   TriggerClientEvent("player:receiveItem", pSrc, "cpu", 1)
--   TriggerClientEvent("chatMessage", pSrc, "EMAIL - Iciest Secret", 8, "Iciest Secret: Go Find Other PC Parts Nerd!")
-- end)

RegisterServerEvent("np-secret:craft")
AddEventHandler("np-secret:craft", function()
  local pSrc = source 
  TriggerClientEvent("inventory:removeItem", pSrc, "cpu", 1)
  TriggerClientEvent("inventory:removeItem", pSrc, "powersupply", 1)
  TriggerClientEvent("DoLongHudText", pSrc, "You Successfully Crafted a Laptop, Wait 3 Minutes.")
  TriggerClientEvent("player:receiveItem", pSrc, "hacklaptop", 1)
end)

RegisterNetEvent("np-secret:menu")
AddEventHandler("np-secret:menu", function()
    local pSrc = source 
	TriggerClientEvent('np-context:sendMenu', pSrc, {
		{
			id = "1",
			header = "Craft Heist Laptop",
			txt = "1 CPU / Secret Item | +1 Laptop",
			params = {
				event = "np-secret:craft",
			}
		},
		{
			id = "2",
			header = "Close Menu",
			txt = "Exit the menu!",
			params = {
				event = "",
			}
		},
	})
end)