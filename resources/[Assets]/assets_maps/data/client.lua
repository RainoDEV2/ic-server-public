local emitters = {
  "se_walk_radio_d_picked",
}

Citizen.CreateThread(function()
  RequestIpl("gabz_mrpd_milo_")
  interiorID = GetInteriorAtCoords(451.0129, -993.3741, 29.1718)
    if IsValidInterior(interiorID) then      
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm1")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm2")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm3")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm4")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm5")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm6")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm7")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm8")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm9")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm10")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm11")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm12")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm13")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm14")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm15")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm16")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm17")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm18")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm19")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm20")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm21")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm22")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm23")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm24")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm25")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm26")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm27")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm28")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm29")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm30")
        EnableInteriorProp(interiorID, "v_gabz_mrpd_rm31")    
        RefreshInterior(interiorID)
    end
end)
  
Citizen.CreateThread(function()
  for i = 1, #emitters do
      SetStaticEmitterEnabled(emitters[i], false)
    end
end)

local autoexbbmin, autoexbbmax = vec3(517.3389, -226.6246, 49.33173), vec3(553.9767, -164.4719, 60.05186)
if not DoesScenarioBlockingAreaExist(autoexbbmin, autoexbbmax) then
  AddScenarioBlockingArea(autoexbbmin, autoexbbmax, 0, 1, 1, 1)
end

Citizen.CreateThread(function()
  RequestIpl("gabz_pillbox_milo_")
  RequestIpl("gabz_pillbox_2_milo_")

  local interiorID = GetInteriorAtCoords(311.2546, -592.4204, 42.32737)

  if IsValidInterior(interiorID) then
    RemoveIpl("rc12b_fixed")
    RemoveIpl("rc12b_destroyed")
    RemoveIpl("rc12b_default")
    RemoveIpl("rc12b_hospitalinterior_lod")
    RemoveIpl("rc12b_hospitalinterior")
    RefreshInterior(interiorID)
  end
end)

Citizen.CreateThread(function()
  RequestIpl("gabz_biker_milo_")

	interiorID = GetInteriorAtCoords(994.47870000, -122.99490000, 73.11467000)
	
	if IsValidInterior(interiorID) then
      EnableInteriorProp(interiorID, "walls_02")
      SetInteriorPropColor(interiorID, "walls_02", 8)
      EnableInteriorProp(interiorID, "Furnishings_02")
      SetInteriorPropColor(interiorID, "Furnishings_02", 8)
      EnableInteriorProp(interiorID, "decorative_02")
      EnableInteriorProp(interiorID, "mural_03")
      EnableInteriorProp(interiorID, "lower_walls_default")
      SetInteriorPropColor(interiorID, "lower_walls_default", 8)
      EnableInteriorProp(interiorID, "mod_booth")
      EnableInteriorProp(interiorID, "gun_locker")
      EnableInteriorProp(interiorID, "cash_small")
      EnableInteriorProp(interiorID, "id_small")
      EnableInteriorProp(interiorID, "weed_small")
      RefreshInterior(interiorID)
	end
end)

Citizen.CreateThread(function()
  RequestIpl("prologue06_int_np")
  local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
  ActivateInteriorEntitySet(interiorid, "np_prolog_clean")
  RefreshInterior(interiorid)
end)