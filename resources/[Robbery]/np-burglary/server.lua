local robbableItems = {
 [1] = {chance = 10, id = 0, quantity = math.random(50, 70)},
 [2] = {chance = 5, id = 'plastic', quantity = math.random(1, 2)},
 [3] = {chance = 13, id = 'pistolammo', quantity = 1},
 [4] = {chance = 8, id = 'oxy', quantity = math.random(2,3)},
 [5] = {chance = 55, id = 'heavydutydrill', quantity = 1},
 [6] = {chance = 65, id = 'sledgehammer', quantity = 1},
 [7] = {chance = 12, id = 'bobross', quantity = 1},
 [8] = {chance = 13, id = 'bonsai', quantity = 1},
 [9] = {chance = 75, id = 'stolen2ctchain', quantity = math.random(1,10)},
 [10] = {chance = 80, id = 'stolen8ctchain', quantity = math.random(1,5)},
 [11] = {chance = 85, id = 'stolen10ctchain', quantity = math.random(1,3)},
 [12] = {chance = 75, id = 'fcadrive', quantity = 1},
 [13] = {chance = 91, id = '453432689', quantity = 1},
 [14] = {chance = 91, id = '1593441988', quantity = 1},
}

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local user = exports["np-fw"]:getModule("Player"):GetUser(source)
 TriggerClientEvent('inventory:removeItem', source, 'lockpick', 1)
 TriggerClientEvent('DoLongHudText',  source, 'The lockpick bent out of shape' , 1)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local user = exports["np-fw"]:getModule("Player"):GetUser(source)
 local cash = math.random(225, 300)
 user:addMoney(cash)
 TriggerClientEvent('DoLongHudText',  source, 'You found a $'..cash , 1)
 TriggerClientEvent("robbery:register:finishedLockpick", source)
 TriggerClientEvent("houseRobberies:reset", source)
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local user = exports["np-fw"]:getModule("Player"):GetUser(source)
 local gotID = {}

 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 100) >= item.chance then
    if tonumber(item.id) == 0 and not gotID[item.id] then
      gotID[item.id] = true
      user:addMoney(item.quantity)
      TriggerClientEvent('DoLongHudText',  source, 'You found $'..item.quantity , 1)
    elseif not gotID[item.id] then
      gotID[item.id] = true
      TriggerClientEvent('player:receiveItem', source, item.id, item.quantity)
      TriggerClientEvent('DoLongHudText', source, 'You found '..item.id, 1)
    end
  else
    TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
    end
  end
end)
