
local berry = {
  key = "Berry",
  primary_colour = HEX("DE8294"),
  secondary_colour = HEX("DE8294"),
  loc_txt =  	{
 		name = 'Berry', -- used on card type badges
 		collection = 'Berries', -- label for the button to access the collection
 	},
  collection_row = {6, 6},
  shop_rate = 0,
  default = "c_poke_oran_berry"
}

return {name = "Additional Consumable Types",
        list = {berry}
}