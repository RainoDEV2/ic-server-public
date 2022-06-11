furnicatalogue.ItemLookup = {}
furnicatalogue.ShopItems = {
  [1] = {
    [1] = 'Office Chair',                         -- label
    [2] = 500,                                    -- price
    [3] = 'hei_prop_heist_off_chair',             -- model
  },

  [2] = {
    [1] = "Computer",
    [2] = 1500,
    [3] = "hei_prop_heist_pc_01",
  },

  [3] = {
    [1] = "Fan",
    [2] = 250,
    [3] = "bkr_prop_weed_fan_floor_01a",
  },

  [4] = {
    [1] = "Gaming Chair",
    [2] = 500,
    [3] = "gr_prop_highendchair_gr_01a",
  },

  [5] = {
    [1] = "Ammo Stash",
    [2] = 1500,
    [3] = "gr_prop_gunlocker_ammo_01a",

  },

  [6] = {
    [1] = "Prop Crate",
    [2] = 3000,
    [3] = "ex_prop_adv_case_sm",
  },

  [7] = {
    [1] = 'Weed Scales',
    [2] = 150,
    [3] = 'bkr_prop_weed_scales_01a',
  },

  [8] = {
    [1] = "Plant Pot",
    [2] = 50,
    [3] = "prop_pot_plant_05b",
  },

  [9] = {
    [1] = "Radio",
    [2] = 250,
    [3] = "prop_radio_01",
  },

  [10] = {
    [1] = "Neon Sign",
    [2] = 200,
    [3] = "prop_ragganeon",
  },

  [11] = {
    [1] = "Head Bust",
    [2] = 1500,
    [3] = "hei_prop_hei_bust_01",

  },

  [12] = {
    [1] = "Computer Monitor",
    [2] = 500,
    [3] = "hei_prop_hei_bank_mon",
  },

  [13] = {
    [1] = "Double Bed",
    [2] = 1300,
    [3] = "apa_mp_h_bed_double_08",
  },

  [14] = {
    [1] = "Drawers",
    [2] = 300,
    [3] = "apa_mp_h_bed_chestdrawer_02",
  },

  [15] = {
    [1] = "Floor Lamp",
    [2] = 50,
    [3] = "apa_mp_h_floorlamp_b",
  },

  [16] = {
    [1] = "Table",
    [2] = 800,
    [3] = "prop_yacht_table_03",
  },

  [17] = {
    [1] = "Mini Fridge",
    [2] = 900,
    [3] = "prop_bar_fridge_03",
  },

  [18] = {
    [1] = "TV Set",
    [2] = 5000,
    [3] = "apa_mp_h_str_avunitm_01",
  },

  [19] = {
    [1] = "Flatscreen TV",
    [2] = 2400,
    [3] = "ex_prop_ex_tv_flat_01",
  },
}

for k,v in pairs(furnicatalogue.ShopItems) do
  local model = v[3]
  local label = v[1]
  furnicatalogue.ItemLookup[label] = model
end
