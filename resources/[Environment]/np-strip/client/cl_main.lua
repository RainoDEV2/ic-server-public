RegisterNetEvent("vanilla:register")
AddEventHandler("vanilla:register", function(registerID)
    local myJob = exports["np_handler"]:isPed("myJob")
    if myJob == "vanilla_unicorn" then
        local order = exports["np-keyboard"]:KeyboardInput({
            header = "Create Receipt",
            rows = {
                {
                    id = 0,
                    txt = "Amount"
                },
                {
                    id = 1,
                    txt = "Comment"
                }
            }
        })
        if order then
            TriggerServerEvent("vanilla:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)



RegisterNetEvent("vanilla:make:drink")
AddEventHandler("vanilla:make:drink", function()
    local myJob = exports["np_handler"]:isPed("myJob")
    if myJob == "vanilla_unicorn" then
        TriggerEvent("server-inventory-open", "1313", "Shop");
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)



RegisterNetEvent("vanilla:get:receipt")
AddEventHandler("vanilla:get:receipt", function(registerid)
    TriggerServerEvent('vanilla:retreive:receipt', registerid)
end)

RegisterNetEvent('vanilla:cash:in')
AddEventHandler('vanilla:cash:in', function()
    local cid = exports["np_handler"]:isPed("cid")
    TriggerServerEvent("vanilla:update:pay", cid)
end)

RegisterNetEvent("vanilla-vip")
AddEventHandler("vanilla-vip", function()
	TriggerEvent("player:receiveItem",'vanillavip', 1)
	Wait(1000)
end)