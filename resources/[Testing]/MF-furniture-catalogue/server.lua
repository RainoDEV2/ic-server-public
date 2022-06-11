function furnicatalogue:TryBuy(source,price)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(0); end
  local money = xPlayer.getMoney()
  if money >= price then
    xPlayer.removeMoney(price)
    return true
  else
    return false
  end
end

RegisterNetEvent('furnicatalogue:Start')
AddEventHandler('furnicatalogue:Start', function(...) TriggerEvent('furnicatalogue:Request', source); end)
ESX.RegisterServerCallback('furnicatalogue:TryBuy', function(source,cb,price) cb(furnicatalogue:TryBuy(source,price)); end)