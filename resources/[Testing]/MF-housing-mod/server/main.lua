local housing = playerhousing

MySQL.ready(function(...) housing.SqlReady = true; end)

-----------
-- STUFF --
-----------

function housing:Awake(...)
  while not self.SqlReady do Citizen.Wait(0); end
  exports.ghmattimysql:execute('SELECT * FROM playerhousing',{},function(data)
    local houseData = Houses;
    for k,v in pairs(houseData) do
      local match = table.find(data,"id",k)
      if match then
        houseData[k].owner = match.owner
        local wardrobePos = false
        if match.wardrobe then
          local w = json.decode(match.wardrobe)
          if w and w.x then
            wardrobePos = vector3(w.x,w.y,w.z)
          end
        end
        houseData[k].wardrobe = wardrobePos
      end
      houseData[k].id = k
    end
    self.HouseData = houseData
    self.Started = true 
  end)
end

function housing:Continue(d,p)
  local ret = false
  if d and d[1] and d[1].last_house then ret = d[1].last_house
  else ret = 0; end
  TriggerEvent('playerhousing:Request',p,self.HouseData,ret,self.Kash and self.Kash[p] or false);
end

function housing:BuyHouse(house)
  local src = source
  local user = exports["np-fw"]:getModule("Player"):GetUser(src)

  local cash = user:getCash()
  local cont;
  if money and money >= house.Price then
    xPlayer.removeMoney(house.Price)
    cont = true
  else
    if cash and cash >= house.Price then
      user:removeMoney(amt)
      cont = true
    end
  end
  if cont then
    if self.HouseData[house.id] and not self.HouseData[house.id].owner then
      local identifier = GetPlayerIdentifier(source)
      if self.Kash and self.Kash[source] then identifier = self.Kash[source]; end
      self.HouseData[house.id].owner = identifier
      TriggerClientEvent('playerhousing:SyncHouse',-1,self.HouseData[house.id])
      exports.ghmattimysql:execute('INSERT INTO playerhousing SET id=@id,owner=@owner,rented=@rented,price=@price',{['@id'] = house.id,['@owner'] = identifier,['@rented'] = 1,['@price'] = house.Price})
    end
  end
end

function housing:GetVehicles(source,houseId)  
  local retData
  exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE lasthouse=@houseId',{['@houseId'] = houseId},function(data)
    if data and data[1] then
      for k,v in pairs(data) do
        data[k].vehicle = json.decode(v.vehicle)
        data[k].state = (self.UsingJamGarage and v.jamstate) or v.stored or 0
      end
      retData = data
    else
      retData = {}
    end
  end)
  while not retData do Citizen.Wait(0); end
  return retData
end

function housing:SetCarState(plate,state,house)
  if self.Busy then
    while self.Busy do Citizen.Wait(0); end
  end
  self.Busy = true
  if self.UsingJamGarage then
    exports.ghmattimysql:execute('UPDATE owned_vehicles SET jamstate=@state,lasthouse=@house WHERE plate=@plate',{['@state'] = state,['@house'] = house,['@plate'] = plate},function(ret)
      self.Busy = false
    end)
  else
    exports.ghmattimysql:execute('UPDATE owned_vehicles SET stored=@stored,lasthouse=@house WHERE plate=@plate',{['@stored'] = state,['@house'] = house,['@plate'] = plate},function(ret)
      self.Busy = false
    end)
  end
end

function housing:SetWardrobe(source,house,pos)
  local identifier;
  if self.Kash and self.Kash[source] then identifier = self.Kash[source]
  else identifier = GetPlayerIdentifier(source); end  
  self.HouseData[house].wardrobe = pos; 
  TriggerClientEvent('playerhousing:SyncHouse',-1,self.HouseData[house])
  local tPos = {x=pos.x,y=pos.y,z=pos.z}
  exports.ghmattimysql:execute('UPDATE playerhousing SET wardrobe=@wardrobe WHERE id=@id',{['@wardrobe'] = json.encode(tPos),['@id'] = house})
end

-------------
-- KASH BS --
-------------

function housing:AddKash(source,id)
  self.Kash = self.Kash or {}
  self.Kash[source] = 'Char'..id..self:GetIdentifierWithoutSteam(GetPlayerIdentifier(source));
end

function housing:GetIdentifierWithoutSteam(Identifier)
  return string.gsub(Identifier, "steam", "")
end

function housing:ChangeBackIdentifier(identifier)
  local st,fn = string.find(identifier,":")
  return "steam:"..string.sub(identifier,fn+1)
end

---------------
-- SQL STUFF --
---------------

function housing:SqlFetch(table,fetch,val)
  while self.SqlBusy do Citizen.Wait(0); end
  self.SqlBusy = true
  local retData
  if fetch then
    exports.ghmattimysql:execute('SELECT * FROM '..table..' WHERE '..fetch..'=@'..fetch,{['@'..fetch] = val}, function(data)
      self.SqlBusy = false
      retData = data
    end)
  else
    exports.ghmattimysql:execute('SELECT * FROM '..table,{}, function(data)
      self.SqlBusy = false
      retData = data
    end)
  end
  while self.SqlBusy do Citizen.Wait(0); end
  return retData
end

function housing:SqlUpdate(table,set,setval,where,whereval)
  while self.SqlBusy do Citizen.Wait(0); end
  self.SqlBusy = true
  exports.ghmattimysql:execute('UPDATE '..table..' SET '..set..'=@'..set..' WHERE '..where..'=@'..where,{['@'..set] = setval,['@'..where] = whereval}, function(...)
    self.SqlBusy = false
  end)
end

function housing:SqlInsert(table,vals)
  while self.SqlBusy do Citizen.Wait(0); end
  self.SqlBusy = true
  for k,v in pairs(vals) do
    while self.SqlBusy do Citizen.Wait(0); end
    self.SqlBusy = true
    exports.ghmattimysql:execute('INSERT INTO '..table..' SET '..k..'=@'..k,{['@'..k] = v}, function(...)
      self.SqlBusy = false
    end)
  end
end
--don't need that one
--[[function housing:GetLockpicks(s)
  local xPlayer = ESX.GetPlayerFromId(s)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(s); Citizen.Wait(0); end
  local r = false
  local i = xPlayer.getInventoryItem('lockpick')
  if i and i.count and i.count > 0 then r = true; end
  return r
end]]

function housing:GetKeys(s)
  local ret,res
  local cid = exports["np_handler"]:isPed("cid")
  exports.ghmattimysql:execute('SELECT * FROM playerhousing_keys WHERE owner=@owner',{['@owner'] = cid}, function(data)
    if data and data[1] then
      res = data
    else
      res = {}
    end
    ret = true
  end)
  while not ret do Citizen.Wait(0); end
  return res
end

function housing:GiveKeys(target,id)
  local cid = exports["np_handler"]:isPed("cid")
  exports.ghmattimysql:execute('INSERT INTO playerhousing_keys SET owner=@owner,house=@house',{['@owner'] = cid,['@house'] = id})
  TriggerClientEvent('playerhousing:GiveKey', target, id)
end

function housing:TakeKeys(target,id)
  local cid = exports["np_handler"]:isPed("cid")
  exports.ghmattimysql:execute('SELECT * FROM playerhousing_keys WHERE owner=@owner',{['@owner'] = cid},function(retData)
    if retData and retData[1] then
      exports.ghmattimysql:execute('DELETE FROM playerhousing_keys WHERE owner=@owner and house=@house',{['@owner'] = cid,['@house'] = id})
      TriggerClientEvent('playerhousing:TakeKey', target, id)
    end
  end)
end

--------------------
-- EVENT HANDLERS --
--------------------

AddEventHandler('playerhousing:Continue', function(...) housing:Continue(...); end)

RegisterNetEvent('playerhousing:BuyHouse')
AddEventHandler('playerhousing:BuyHouse', function(...) housing:BuyHouse(source,...); end)

RegisterNetEvent('playerhousing:SetCarState')
AddEventHandler('playerhousing:SetCarState', function(...) housing:SetCarState(...); end)

RegisterNetEvent("kashactersS:CharacterChosen")
AddEventHandler('kashactersS:CharacterChosen', function(id) housing:AddKash(source,id); end)

RegisterNetEvent('playerhousing:SetWardrobe')
AddEventHandler('playerhousing:SetWardrobe', function(...) housing:SetWardrobe(source,...); end)

RegisterNetEvent('playerhousing:GiveKeys')
AddEventHandler('playerhousing:GiveKeys', function(...) housing:GiveKeys(...); end)
RegisterNetEvent('playerhousing:TakeKeys')
AddEventHandler('playerhousing:TakeKeys', function(...) housing:TakeKeys(...); end)

RegisterServerEvent('playerhousing:RemoveOutfit')
AddEventHandler('playerhousing:RemoveOutfit', function(...) housing:RemoveOutfit(source,...); end)

AddEventHandler('playerhousing:SqlFetch', function(table,fetch,val,ply,cb) cb(housing:SqlFetch(table,fetch,val),ply); end)
AddEventHandler('playerhousing:SqlUpdate', function(...) housing:SqlUpdate(...); end)
AddEventHandler('playerhousing:SqlInsert', function(...) housing:SqlInsert(...); end)

ESX.RegisterServerCallback('playerhousing:GetVehicles', function(source, cb, identifier) cb(housing:GetVehicles(source, identifier)); end)
ESX.RegisterServerCallback('playerhousing:GetPlayerDressing', function(source, cb) cb(housing:GetPlayerDressing(source)); end)
ESX.RegisterServerCallback('playerhousing:GetPlayerOutfit', function(source, cb, num) cb(housing:GetPlayerOutfit(source,num)); end)
ESX.RegisterServerCallback('playerhousing:GetLockpicks', function(source, cb) cb(housing:GetLockpicks(source)); end)
ESX.RegisterServerCallback('playerhousing:GetKeys', function(source, cb) cb(housing:GetKeys(source)); end)

Citizen.CreateThread(function(...) housing:Awake(...); end)
