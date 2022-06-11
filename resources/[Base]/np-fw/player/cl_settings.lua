IRP.SettingsData = IRP.SettingsData or {}
IRP.Settings = IRP.Settings or {}

IRP.Settings.Current = {}
-- Current bind name and keys
IRP.Settings.Default = {
  ["tokovoip"] = {
    ["stereoAudio"] = true,
    ["localClickOn"] = true,
    ["localClickOff"] = true,
    ["remoteClickOn"] = true,
    ["remoteClickOff"] = true,
    ["clickVolume"] = 0.8,
    ["radioVolume"] = 0.8,
    ["phoneVolume"] = 0.8,
    ["releaseDelay"] = 200
  },
  ["hud"] = {

  }

}


function IRP.SettingsData.setSettingsTable(settingsTable, shouldSend)
  if settingsTable == nil then
    IRP.Settings.Current = IRP.Settings.Default
    TriggerServerEvent('np-fw:sv:player_settings_set',IRP.Settings.Current)
    IRP.SettingsData.checkForMissing()
  else
    if shouldSend then
      IRP.Settings.Current = settingsTable
      TriggerServerEvent('np-fw:sv:player_settings_set',IRP.Settings.Current)
      IRP.SettingsData.checkForMissing()
    else
       IRP.Settings.Current = settingsTable
       IRP.SettingsData.checkForMissing()
    end
  end

  TriggerEvent("event:settings:update",IRP.Settings.Current)

end

function IRP.SettingsData.setSettingsTableGlobal(self, settingsTable)
  IRP.SettingsData.setSettingsTable(settingsTable,true);
end

function IRP.SettingsData.getSettingsTable()
    return IRP.Settings.Current
end

function IRP.SettingsData.setVarible(self,tablename,atrr,val)
  IRP.Settings.Current[tablename][atrr] = val
  TriggerServerEvent('np-fw:sv:player_settings_set',IRP.Settings.Current)
end

function IRP.SettingsData.getVarible(self,tablename,atrr)
  return IRP.Settings.Current[tablename][atrr]
end

function IRP.SettingsData.checkForMissing()
  local isMissing = false

  for j,h in pairs(IRP.Settings.Default) do
    if IRP.Settings.Current[j] == nil then
      isMissing = true
      IRP.Settings.Current[j] = h
    else
      for k,v in pairs(h) do
        if  IRP.Settings.Current[j][k] == nil then
           IRP.Settings.Current[j][k] = v
           isMissing = true
        end
      end
    end
  end
  

  if isMissing then
    TriggerServerEvent('np-fw:sv:player_settings_set',IRP.Settings.Current)
  end


end

RegisterNetEvent("np-fw:cl:player_settings")
AddEventHandler("np-fw:cl:player_settings", function(settingsTable)
  IRP.SettingsData.setSettingsTable(settingsTable,false)
end)


RegisterNetEvent("np-fw:cl:player_reset")
AddEventHandler("np-fw:cl:player_reset", function(tableName)
  if IRP.Settings.Default[tableName] then
      if IRP.Settings.Current[tableName] then
        IRP.Settings.Current[tableName] = IRP.Settings.Default[tableName]
        IRP.SettingsData.setSettingsTable(IRP.Settings.Current,true)
      end
  end
end)