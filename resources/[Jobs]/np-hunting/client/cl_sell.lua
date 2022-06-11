local carcasses = {
    { name = "huntingcarcass1", price = 85, illegal = false },
    { name = "huntingcarcass2", price = 150, illegal = false },
    { name = "huntingcarcass3", price = 200, illegal = false },
    { name = "huntingcarcass4", price = 275, illegal = false },
}


local function sellAnimals()
    local totalCash = 0
    local totalBMarketCash = 0

    for _, carcass in pairs(carcasses) do
        local qty = exports["np-inventory"]:getQuantity(carcass.name)

        if qty > 0 then
            if not carcass.illegal then
                totalCash = totalCash + (carcass.price * qty)
                TriggerEvent("inventory:removeItem", carcass.name, qty)
            elseif isNight() then
                totalBMarketCash = totalBMarketCash + (carcass.price * qty)
                TriggerEvent("inventory:removeItem", carcass.name, qty)
            end
        end
    end

    if totalCash == 0 and totalBMarketCash == 0 then
        TriggerEvent("DoLongHudText", "Nothing to sell, dummy.", 2)
    end
    
    if totalCash > 0 then
        TriggerServerEvent("complete:job", totalCash)
    end

    if totalBMarketCash > 0 then
        TriggerEvent("player:receiveItem", "band", totalBMarketCash)
    end
end

local listening = false
local function listenForKeypress()
    listening = true
    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                listening = false
                exports["np-doors"]:hideInteraction()
                sellAnimals()
            end
            Wait(0)
        end
    end)
end

AddEventHandler("np-polyzone:enter", function(name)
    if name ~= "huntingsales" then return end
    exports["np-doors"]:showInteraction("[E] Sell Animal Carcass")
    listenForKeypress()
end)

AddEventHandler("np-polyzone:exit", function(name)
    if name ~= "huntingsales" then return end
    exports["np-doors"]:hideInteraction()
    listening = false
end)

function isNight()
	local hour = GetClockHours()
	if hour > 21 or hour < 3 then
	  return true
	end
  end