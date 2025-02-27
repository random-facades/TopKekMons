-- Various util functions

is_flavor_type = function(card, flavor)
   if flavor == 'Bland' then
      return is_type(card, 'Colorless') or is_type(card, 'Grass')
   elseif flavor == 'Spicy' then
      return is_type(card, 'Fire') or is_type(card, 'Dragon')
   elseif flavor == 'Dry' then
      return is_type(card, 'Earth') or is_type(card, 'Psychic')
   elseif flavor == 'Sweet' then
      return is_type(card, 'Fairy') or is_type(card, 'Fighting')
   elseif flavor == 'Bitter' then
      return is_type(card, 'Dark') or is_type(card, 'Water')
   elseif flavor == 'Sour' then
      return is_type(card, 'Lightning') or is_type(card, 'Metal')
   end
end

create_calculations_voucher = function()
   if not G.vouchers or not G.vouchers.cards then return nil end
   for _, voucher in pairs(G.vouchers.cards) do
      if voucher.config.center == G.P_CENTERS['v_kek_calculations'] then
         print("ALREADY EXISTS")
         return voucher
      end
   end
   print("CREATING NEW CALC VOUCHER")
   local voucher = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['v_kek_calculations'])
   G.vouchers:emplace(voucher)
   return voucher
end