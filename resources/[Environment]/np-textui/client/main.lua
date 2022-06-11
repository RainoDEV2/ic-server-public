RegisterNetEvent('np-textui:ShowUI')
AddEventHandler('np-textui:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('np-textui:HideUI')
AddEventHandler('np-textui:HideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)