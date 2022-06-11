Config = Config or {}

Config.Zones = {
	garages = {
		-- Garage A --

		BoxZone:Create(vector3(466.49, -71.76, 77.49), 8.4, 13.8, {
			name="A",
			heading=337,
			--debugPoly=true
		}),

		BoxZone:Create(vector3(472.67, -61.76, 77.46), 8.4, 13.8, {
			name="A",
			heading=330,
			--debugPoly=true
		}),

		BoxZone:Create(vector3(487.94, -32.5, 77.72), 10.0, 24.4, {
			name="A",
			heading=60,
			--debugPoly=true
		}),
		
		-- Garage B --
  

		BoxZone:Create(vector3(-356.31, -753.56, 33.97), 53.25, 10.4, {
			name="B",
			heading=1,
		}),



  		BoxZone:Create(vector3(-341.99, -758.46, 33.97), 23.35, 8.6, {
			name="B",
			heading=0,
		}),
  
  		BoxZone:Create(vector3(-326.87, -751.89, 33.97), 31.2, 11.6, {
			name="B",
			heading=262,
		}),
  
		-- Garage C --

		BoxZone:Create(vector3(-321.95, -980.58, 31.08), 59.0, 9.0, {
			name="C",
			heading=70,
			--debugPoly=true
		}),
  
  		BoxZone:Create(vector3(-321.51, -941.79, 31.08), 37.6, 7.6, {
			name="C",
			heading=340,
		}),

  		BoxZone:Create(vector3(-307.8, -949.2, 31.08), 40.8, 7.8, {
			name="C",
			heading=340,
			--debugPoly=truew
		}),

		-- Garage D --

		BoxZone:Create(vector3(385.34, -1331.04, 33.22), 44.0, 7.6, {
			name="D",
			heading=50,
		}),
  
  		BoxZone:Create(vector3(427.39, -1366.02, 33.17), 44.0, 7.6, {
			name="D",
			heading=49,
		}),
  
		-- Garage E --

		BoxZone:Create(vector3(614.2, 112.74, 92.2), 46.85, 34.6, {
			name="E",
			heading=339,
		}),

		-- Garage F --

		BoxZone:Create(vector3(636.49, 176.47, 96.6), 60.2, 36.2, {
  			name="F",
  			heading=340,
		}),

		-- Garage G --

		BoxZone:Create(vector3(67.26, 6376.98, 31.24), 60.0, 64.8, {
  			name="G",
  			heading=41,
		}),

		-- Garage H --

		BoxZone:Create(vector3(-759.44, -2026.07, 8.93), 72.6, 50, {
  			name="H",
  			heading=335,
		}),

		-- Garage I --

		BoxZone:Create(vector3(-675.98, -2056.88, 8.87), 70.4, 33.8, {
  			name="I",
  			heading=85,
		}),

		-- Garage J --

		BoxZone:Create(vector3(-629.4, -2196.03, 5.99), 82.400000000001, 23.0, {
  			name="J",
  			heading=50,
		}),

		-- Garage K --

		BoxZone:Create(vector3(-125.32, -2133.55, 16.7), 61.2, 32.0, {
  			name="K",
  			heading=290,
		}),

		-- Garage L --

		BoxZone:Create(vector3(-51.6, -2101.08, 16.7), 27.8, 16.6, {
  			name="L",
  			heading=290,
		}),

		-- Garage M --

		BoxZone:Create(vector3(-83.62, -2006.09, 18.02), 51.0, 19.8, {
  			name="M",
  			heading=260,
		}),

		-- Garage O --

		BoxZone:Create(vector3(375.1, 281.46, 103.43), 41.0, 35.0, {
  			name="O",
  			heading=253,
		}),

		-- Garage P --

		BoxZone:Create(vector3(-339.36, 288.01, 85.83), 35.6, 30.2, {
  			name="P",
  			heading=0,
		}),

		-- Garage Q --

		PolyZone:Create({
			vector2(295.66567993164, -356.21514892578),
			vector2(305.9580078125, -327.55197143555),
			vector2(266.70874023438, -314.34658813477),
			vector2(258.60485839844, -339.76541137695)
		}, {
			name="Q",
		}),

		-- Garage R --

		BoxZone:Create(vector3(59.43, 17.81, 69.78), 14.8, 7.0, {
  			name="R",
  			heading=70,
		}),

		-- Garage S --

		BoxZone:Create(vector3(305.14, 71.33, 94.37), 30.4, 6.0, {
  			name="S",
  			heading=70,
		}),

		-- Garage T --

		PolyZone:Create({
			vector2(239.68876647949, -820.34033203125),
			vector2(258.72216796875, -768.09613037109),
			vector2(218.64688110352, -754.83935546875),
			vector2(200.06071472168, -805.73034667969)
		}, {
			name="T",
		}),


		-- Garage Richman --

		BoxZone:Create(vector3(-1308.41, 254.07, 64.49), 73.2, 62.8, {
			name="Richman",
			heading=254,
  		}),

		  		  
		-- Garage Casino --

		PolyZone:Create({
			vector2(870.51776123047, 20.484987258911),
			vector2(876.04241943359, 17.465185165405),
			vector2(956.79577636719, -30.344190597534),
			vector2(947.38110351562, -63.22282409668),
			vector2(954.59088134766, -88.86612701416),
			vector2(926.10278320312, -116.17047119141),
			vector2(884.08178710938, -92.043014526367),
			vector2(827.90643310547, -56.764553070068),
			vector2(816.08416748047, -46.162780761719)
		}, {
			name="casino",
		}),

		-- Garage Impound --

		BoxZone:Create(vector3(-143.32, -1171.19, 23.77), 24.0, 30, {
			name="Impound Lot",
			heading=0,
			--debugPoly=true,
			minZ=22.77,
			maxZ=25.37
		}),


		
		BoxZone:Create(vector3(-192.83, -1173.6, 23.04), 26.0, 20, {
			name="Repo",
			heading=0,
			minZ=21.84,
			maxZ=25.24
		}),

		-- Perro
		BoxZone:Create(vector3(-1479.69, -504.41, 32.83), 22.0, 30, {
			name="Perro",
			heading=35,
			--debugPoly=true,
			minZ=31.63,
			maxZ=33.83
		}),
		  
		BoxZone:Create(vector3(445.87, -993.32, 25.7), 9.6, 10, {
			name="Police Department",
			heading=270,
			--debugPoly=true,
			minZ=24.7,
			maxZ=28.7
		}),

		BoxZone:Create(vector3(326.29, -588.71, 28.8), 14.6, 5, {
			name="Pillbox",
			heading=250,
			--debugPoly=true,
			minZ=27.8,
			maxZ=31.8
		}),	
		
		BoxZone:Create(vector3(-1921.57, 2046.88, 140.74), 25.0, 7, {
			name="Winery",
			heading=350,
			--debugPoly=true,
			minZ=138.94,
			maxZ=142.94
		}),

		BoxZone:Create(vector3(571.98, 2729.23, 42.06), 25, 25, {
			name="Harmony",
			heading=185,
			--debugPoly=true,
			minZ=41.06,
			maxZ=45.06
			})		  	  
		}
}