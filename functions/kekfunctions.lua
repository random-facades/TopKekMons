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
      if voucher.config.center == G.P_CENTERS['v_poke_calculations'] then
         print("ALREADY EXISTS")
         return voucher
      end
   end
   print("CREATING NEW CALC VOUCHER")
   local voucher = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['v_poke_calculations'])
   G.vouchers:emplace(voucher)
   return voucher
end

convert_cards_to = function(t)
   if not t.seal then
      for i = 1, #G.hand.highlighted do
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
               G.hand.highlighted[i]:flip()
               G.hand.highlighted[i]:juice_up(0.3, 0.3)
               return true
            end
         }))
      end
      delay(0.2)
   end
   for i = 1, #G.hand.highlighted do
      if t.mod_conv then
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
               G.hand.highlighted[i]:set_ability(G.P_CENTERS[t.mod_conv])
               return true
            end
         }))
      elseif t.suit_conv then
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
               G.hand.highlighted[i]:change_suit(t.suit_conv)
               return true
            end
         }))
      elseif t.seal then
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
               G.hand.highlighted[i]:set_seal(t.seal, nil, true)
               return true
            end
         }))
      elseif t.random then
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
               local card = G.hand.highlighted[i]
               local suit_prefix = string.sub(card.base.suit, 1, 1) .. '_'
               local rank_suffix = math.floor(pseudorandom(t.seed) * 13) + 2
               if rank_suffix < 10 then
                  rank_suffix = tostring(rank_suffix)
               elseif rank_suffix == 10 then
                  rank_suffix = 'T'
               elseif rank_suffix == 11 then
                  rank_suffix = 'J'
               elseif rank_suffix == 12 then
                  rank_suffix = 'Q'
               elseif rank_suffix == 13 then
                  rank_suffix = 'K'
               elseif rank_suffix == 14 then
                  rank_suffix = 'A'
               end
               card:set_base(G.P_CARDS[suit_prefix .. rank_suffix])
               return true
            end
         }))
      elseif t.up or t.down then
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
               local card = G.hand.highlighted[i]
               local suit_prefix = string.sub(card.base.suit, 1, 1) .. '_'
               local rank_suffix = (card.base.id + (t.up and 1 or -1))
               if rank_suffix == 1 then rank_suffix = 14 end
               if rank_suffix == 15 then rank_suffix = 2 end
               if rank_suffix < 10 then
                  rank_suffix = tostring(rank_suffix)
               elseif rank_suffix == 10 then
                  rank_suffix = 'T'
               elseif rank_suffix == 11 then
                  rank_suffix = 'J'
               elseif rank_suffix == 12 then
                  rank_suffix = 'Q'
               elseif rank_suffix == 13 then
                  rank_suffix = 'K'
               elseif rank_suffix == 14 then
                  rank_suffix = 'A'
               end
               card:set_base(G.P_CARDS[suit_prefix .. rank_suffix])
               return true
            end
         }))
      end
   end
   if not t.seal then
      for i = 1, #G.hand.highlighted do
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
               G.hand.highlighted[i]:flip()
               G.hand.highlighted[i]:juice_up(0.3, 0.3)
               return true
            end
         }))
      end
   end
   delay(0.5)
   G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
         G.hand:unhighlight_all()
         return true
      end
   }))
end


get_energy_count = function(card)
   local curr_energy_count = nil
   local curr_c_energy_count = nil
   if card.ability.extra and type(card.ability.extra) == "table" then
      curr_energy_count = card.ability.extra.energy_count or 0
      curr_c_energy_count = card.ability.extra.c_energy_count or 0
   else
      curr_energy_count = card.ability.energy_count or 0
      curr_c_energy_count = card.ability.c_energy_count or 0
   end
   return curr_energy_count + curr_c_energy_count
end



increase_hand_size_without_draw = function(cardArea, delta, to_juice)
   if delta ~= 0 then
      G.E_MANAGER:add_event(Event({
         func = function()
            cardArea.config.real_card_limit = (cardArea.config.real_card_limit or cardArea.config.card_limit) + delta
            cardArea.config.card_limit = math.max(0, cardArea.config.real_card_limit)
            if cardArea == G.hand then check_for_unlock({ type = 'min_hand_size' }) end
            if to_juice then
               to_juice:juice_up(0.1)
            end
            return true
         end
      }))
   end
end

_prev_straight_func = get_straight
poke_get_straight = function(hand)
  local prev_values = {}
  local mamoswines = find_joker('mamoswine')
  for i,card in ipairs(hand) do
    prev_values[i] = card.base.value
    if #mamoswines > 0 and card.ability.effect == 'Stone Card' then
        card.base.value = mamoswines[1].ability.extra.card.value
    end
  end
  local ret = {_prev_straight_func(hand)}
  for i,card in ipairs(hand) do
    card.base.value = prev_values[i]
  end
  return unpack(ret)
end
get_straight = poke_get_straight