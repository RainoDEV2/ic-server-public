RegisterServerEvent('np-hunting:skinReward')
AddEventHandler('np-hunting:skinReward', function()
  local _source = source
  local user = exports["np-fw"]:getModule("Player"):GetUser(source)
  local randomAmount = math.random(1,30)
  if randomAmount > 1 and randomAmount < 15 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass1', 1)
  elseif randomAmount > 15 and randomAmount < 23 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass2', 1)
  elseif randomAmount > 23 and randomAmount < 29 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass3', 1)
  else 
    TriggerClientEvent('player:receiveItem', _source, "huntingcarcass4", 1)
  end

  --TriggerClientEvent('player:receiveItem', _source, 'meat',math.random(1,4))
end)

RegisterServerEvent('np-hunting:removeBait')
AddEventHandler('np-hunting:removeBait', function()
  local _source = source
  local user = exports["np-fw"]:getModule("Player"):GetUser(source)
  TriggerClientEvent('inventory:removeItem', _source, "huntingbait", 1)
end)

RegisterServerEvent('complete:job')
AddEventHandler('complete:job', function(totalCash)
  local _source = source
  local user = exports["np-fw"]:getModule("Player"):GetUser(source)
  user:addMoney(totalCash)
end)