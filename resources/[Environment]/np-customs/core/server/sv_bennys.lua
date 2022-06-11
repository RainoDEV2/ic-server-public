local hmm = vehicleBaseRepairCost

RegisterServerEvent('np-customs:attemptPurchase')
AddEventHandler('np-customs:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["np-fw"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('np-customs:purchaseSuccessful', source)
        else
            TriggerClientEvent('np-customs:purchaseFailed', source)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('np-customs:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('np-customs:purchaseFailed', source)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('np-customs:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('np-customs:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('np-customs:updateRepairCost')
AddEventHandler('np-customs:updateRepairCost', function(cost)
    hmm = cost
end)