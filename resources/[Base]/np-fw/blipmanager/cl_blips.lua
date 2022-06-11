local blips = {
    {id = "pcenter", name = "Payments & Internet Center", scale = 0.7, sprite = 351, color = 17, x=-1081.8293457031, y=-248.12872314453, z=37.763294219971},
    {id = "burgies", name = "Burger Shot", scale = 0.7, color = 8, sprite = 106, x = -1199.61, y = -899.79, z = 14.0},
    {id = "truckjob1", name = "Delivery Garage", scale = 0.7, color = 17, sprite = 67, x =165.22, y=-28.38, z=67.94},
    {id = "beanmachine", name = "Bean Machine", scale = 0.7, color = 44, sprite = 106, x = -629.541015625, y= 233.69226074219, z= 81.881462097168},
    {id = "RecycleCenter", name = "Recycling Center", scale = 0.7, color = 2, sprite = 467, x = 892.29370117188, y= -2171.9182128906, z= 32.286254882812},
    {id = "MRPD", name = "MRPD", scale = 0.7, color = 3, sprite = 60, x = 438.70559692383, y= -981.75952148438, z= 30.689582824707},
    {id = "Pillbox", name = "Pillbox Hospital", scale = 0.7, color = 2, sprite = 61, x = 307.94036865234, y= -587.64758300781, z= 43.284049987793},
    {id = "SandyPD", name = "Sandy PD", scale = 0.7, color = 3, sprite = 60, x = 1859.7021484375, y= 3673.9252929688, z= 33.699100494385},
    {id = 'HarmonyRepairs', name = 'Harmony Repairs', scale = 0.7, color = 12, sprite = 478, x = 1183.18, y = 2651.66, z = 37.81},
    {id = 'HayesAutos', name = 'Hayes Autos Repairs', scale = 0.7, color = 12, sprite = 478, x = -1416.86, y = -447.97, z = 35.91},
    {id = "autoexotic", name = "Auto Exotics", color = 27, sprite = 147, x = 531.81506347656, y = -176.94529724121, z = 54.750310516357},
    {id = "news", name = "Weazel News", color = 75, sprite = 354, x = -598.30303955078, y = -929.34429931641, z = 23.86912727356},
    {id = "huntingsales", name = "Hunting Sales", scale = 0.7, color = 3, sprite = 442, x = 569.05285644531, y = 2796.6870117188, z = 42.018249511719},
    {id = "ttruckjob", name = "Impound Lot", color = 17, sprite = 68, x = -189.88, y = -1163.99, z = 23.68},
    {id = "townhall", name = "Town Hall", scale = 0.7, color = 25, sprite = 438, x=-547.36, y=-200.0, z=38.22},
    {id = "cardshop", name = "Comic Store", scale = 0.7, color = 3, sprite = 614, x=-143.68405151367, y=230.39543151855, z=94.94197845459},
    {id = "BestBuds", name = "Best Buds", scale = 0.6, color = 2, sprite = 140, x=378.81, y=-828.44, z= 29.29},
    {id = "unicorn", name = "Vanilla Unicorn", scale = 0.6, color = 83, sprite = 121, x=112.47842407227, y=-1306.8358154297, z= 34.643177032471},
    {id = "tunershop", name = "Tuner Shop", scale = 0.7, color = 7, sprite = 326, x = 136.17390441895, y= -3031.40625, z= 7.0421533584595},
    {id = "hunting", name = "Legal Hunting Area", scale = 0.8, color = 3, sprite = 141, x=-838.5, y=4176.4, z=192.5 },
    {id = "digitalden", name = "Digital Den", scale = 0.8, color = 26, sprite = 619, x=1136.88, y=-474.85, z=66.44},
    {id = "veh_rentals", name = "Vehicle Rental", scale = 0.5, color = 2, sprite = 326, x=108.77, y=-1088.88, z=29.3},
    {id = "casino", name = "Diamond Casino", scale = 0.8, color = 26, sprite = 679, x=931.50604248047, y=42.151905059814, z=81.095710754395},
}

local circles = {
 { id = "hunting", name = "Legal Hunting Area", opacity = 80, radius = 1000.0, color = 1, sprite = 9, x=-838.5, y=4176.4, z=192.5 },
}

AddEventHandler("np-fw:playerSessionStarted", function()
    Citizen.CreateThread(function()
        for k,v in ipairs(blips) do
            IRP.BlipManager:CreateBlip(v.id, v)
        end
        for k,v in ipairs(circles) do
            local blip = AddBlipForRadius(v.x,v.y,v.z,v.radius)
            SetBlipColour(blip,v.color)
            SetBlipAlpha(blip,v.opacity)
            SetBlipSprite(blip,9)
        end
    end)
end)