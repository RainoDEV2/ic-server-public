RegisterServerEvent('rolexdelivery:server')
AddEventHandler('rolexdelivery:server', function(money)
    local src = source
    local user = exports["np-fw"]:getModule("Player"):GetUser(source)

	if user:getCash() >= money then
        user:removeMoney(money)

		TriggerClientEvent("rolexdelivery:startDealing", source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough for this', 2)
	end
end)