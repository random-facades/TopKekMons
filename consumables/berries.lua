local cheri_berry = {
   name = 'cheri_berry',
   key = 'cheri_berry',
   set = 'Berry',
   pos = { x = 0, y = 0 },
   config = { max_highlighted = 2, suit_conv = 'Clubs', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = { G.C.SUITS[self.config.suit_conv] } } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end,
}

local chesto_berry = {
   name = 'chesto_berry',
   key = 'chesto_berry',
   set = 'Berry',
   pos = { x = 1, y = 0 },
   config = { max_highlighted = 2, suit_conv = 'Diamonds', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = { G.C.SUITS[self.config.suit_conv] } } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end,
}

local pecha_berry = {
   name = 'pecha_berry',
   key = 'pecha_berry',
   set = 'Berry',
   pos = { x = 2, y = 0 },
   config = { max_highlighted = 2, suit_conv = 'Hearts', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = { G.C.SUITS[self.config.suit_conv] } } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end,
}

local rawst_berry = {
   name = 'rawst_berry',
   key = 'rawst_berry',
   set = 'Berry',
   pos = { x = 3, y = 0 },
   config = { max_highlighted = 2, suit_conv = 'Spades', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = { G.C.SUITS[self.config.suit_conv] } } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end,
}

local aspear_berry = {
   name = 'aspear_berry',
   key = 'aspear_berry',
   set = 'Berry',
   pos = { x = 4, y = 0 },
   config = { max_highlighted = 3, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.max_highlighted } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      local suit_list = {}
      for name, _ in pairs(SMODS.Suits) do
         table.insert(suit_list, name)
      end
      local new_suit = pseudorandom_element(suit_list, pseudoseed('aspear'))
      convert_cards_to({ suit_conv = new_suit })
   end,
}

local leppa_berry = {
   name = 'leppa_berry',
   key = 'leppa_berry',
   set = 'Berry',
   pos = { x = 5, y = 0 },
   config = { money_mod = 5, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.money_mod } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local target = G.jokers.highlighted[1]
      target.ability.extra_value = target.ability.extra_value + self.config.money_mod
      target:set_cost()
      G.E_MANAGER:add_event(Event({
         func = function()
            card_eval_status_text(target, 'extra', nil, nil, nil, { message = localize('k_val_up') }); return true
         end
      }))
   end
}

local oran_berry = {
   name = 'oran_berry',
   key = 'oran_berry',
   set = 'Berry',
   pos = { x = 6, y = 0 },
   config = { energy_gain = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_gain } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      for _, joker in pairs(G.jokers.cards) do
         energy_increase(joker, "Trans")
      end
   end
}

local persim_berry = {
   name = 'persim_berry',
   key = 'persim_berry',
   set = 'Berry',
   pos = { x = 0, y = 1 },
   config = { energy_ratio = 2, flavor_filter = 'Bland', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      local nrg_limit = (energy_max or 3) + (G.GAME.energy_plus or 0)
      return { vars = { self.config.flavor_filter, self.config.energy_ratio, math.max(1, math.floor(nrg_limit / self.config.energy_ratio)) } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local energy_gain = math.max(1,
         math.floor(((energy_max or 3) + (G.GAME.energy_plus or 0)) / self.config.energy_ratio))
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            for i = 1, energy_gain do
               energy_increase(joker, "Trans")
            end
         end
      end
   end
}

local lum_berry = {
   name = 'lum_berry',
   key = 'lum_berry',
   set = 'Berry',
   pos = { x = 1, y = 1 },
   config = { max_highlighted = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.hand.highlighted and #G.hand.highlighted == 1 and G.hand.highlighted[1].debuff
   end,
   use = function(self, card, area, copier)
      G.hand.highlighted[1].debuff_prevent_this_round = G.GAME.round
      G.hand.highlighted[1]:set_debuff(false)
   end
}

local sitrus_berry = {
   name = 'sitrus_berry',
   key = 'sitrus_berry',
   set = 'Berry',
   pos = { x = 2, y = 1 },
   config = { energy_ratio = 4, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      local nrg_limit = (energy_max or 3) + (G.GAME.energy_plus or 0)
      return { vars = { 'all', self.config.energy_ratio, math.max(1, math.floor(nrg_limit / self.config.energy_ratio)) } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local energy_gain = math.max(1,
         math.floor(((energy_max or 3) + (G.GAME.energy_plus or 0)) / self.config.energy_ratio))
      for _, joker in pairs(G.jokers.cards) do
         for i = 1, energy_gain do
            energy_increase(joker, "Trans")
         end
      end
   end
}

local figy_berry = {
   name = 'figy_berry',
   key = 'figy_berry',
   set = 'Berry',
   pos = { x = 3, y = 1 },
   config = { energy_ratio = 2, flavor_filter = 'Spicy', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      local nrg_limit = (energy_max or 3) + (G.GAME.energy_plus or 0)
      return { vars = { self.config.flavor_filter, self.config.energy_ratio, math.max(1, math.floor(nrg_limit / self.config.energy_ratio)) } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local energy_gain = math.max(1,
         math.floor(((energy_max or 3) + (G.GAME.energy_plus or 0)) / self.config.energy_ratio))
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            for i = 1, energy_gain do
               energy_increase(joker, "Trans")
            end
         end
      end
   end
}

local wiki_berry = {
   name = 'wiki_berry',
   key = 'wiki_berry',
   set = 'Berry',
   pos = { x = 4, y = 1 },
   config = { energy_ratio = 2, flavor_filter = 'Dry', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      local nrg_limit = (energy_max or 3) + (G.GAME.energy_plus or 0)
      return { vars = { self.config.flavor_filter, self.config.energy_ratio, math.max(1, math.floor(nrg_limit / self.config.energy_ratio)) } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local energy_gain = math.max(1,
         math.floor(((energy_max or 3) + (G.GAME.energy_plus or 0)) / self.config.energy_ratio))
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            for i = 1, energy_gain do
               energy_increase(joker, "Trans")
            end
         end
      end
   end
}

local mago_berry = {
   name = 'mago_berry',
   key = 'mago_berry',
   set = 'Berry',
   pos = { x = 5, y = 1 },
   config = { energy_ratio = 2, flavor_filter = 'Sweet', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      local nrg_limit = (energy_max or 3) + (G.GAME.energy_plus or 0)
      return { vars = { self.config.flavor_filter, self.config.energy_ratio, math.max(1, math.floor(nrg_limit / self.config.energy_ratio)) } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local energy_gain = math.max(1,
         math.floor(((energy_max or 3) + (G.GAME.energy_plus or 0)) / self.config.energy_ratio))
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            for i = 1, energy_gain do
               energy_increase(joker, "Trans")
            end
         end
      end
   end
}

local aguav_berry = {
   name = 'aguav_berry',
   key = 'aguav_berry',
   set = 'Berry',
   pos = { x = 6, y = 1 },
   config = { energy_ratio = 2, flavor_filter = 'Bitter', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      local nrg_limit = (energy_max or 3) + (G.GAME.energy_plus or 0)
      return { vars = { self.config.flavor_filter, self.config.energy_ratio, math.max(1, math.floor(nrg_limit / self.config.energy_ratio)) } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local energy_gain = math.max(1,
         math.floor(((energy_max or 3) + (G.GAME.energy_plus or 0)) / self.config.energy_ratio))
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            for i = 1, energy_gain do
               energy_increase(joker, "Trans")
            end
         end
      end
   end
}

local iapapa_berry = {
   name = 'iapapa_berry',
   key = 'iapapa_berry',
   set = 'Berry',
   pos = { x = 0, y = 2 },
   config = { energy_ratio = 2, flavor_filter = 'Sour', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      local nrg_limit = (energy_max or 3) + (G.GAME.energy_plus or 0)
      return { vars = { self.config.flavor_filter, self.config.energy_ratio, math.max(1, math.floor(nrg_limit / self.config.energy_ratio)) } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and can_increase_energy(joker) then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local energy_gain = math.max(1,
         math.floor(((energy_max or 3) + (G.GAME.energy_plus or 0)) / self.config.energy_ratio))
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            for i = 1, energy_gain do
               energy_increase(joker, "Trans")
            end
         end
      end
   end
}

local razz_berry = {
   name = 'razz_berry',
   key = 'razz_berry',
   set = 'Berry',
   pos = { x = 1, y = 2 },
   config = { drain_amt = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'poke_drain' }
      return { vars = { self.config.drain_amt } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if joker.sell_cost > 1 then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local earn_amount = 0
      for _, joker in pairs(G.jokers.cards) do
         earn_amount = earn_amount + joker.sell_cost
         poke_drain(nil, joker, self.config.drain_amt, true)
         earn_amount = earn_amount - joker.sell_cost
      end
      ease_dollars(earn_amount)
   end
}

local bluk_berry = {
   name = 'bluk_berry',
   key = 'bluk_berry',
   set = 'Berry',
   pos = { x = 2, y = 2 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'baby' }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
         return true
      else
         return false
      end
   end,
   use = function(self, card, area, copier)
      G.E_MANAGER:add_event(Event({
         trigger = 'after',
         delay = 0.4,
         func = function()
            play_sound('timpani')
            local _card = create_random_poke_joker("bluk", "Baby")
            _card:add_to_deck()
            G.jokers:emplace(_card)
            return true
         end
      }))
      delay(0.6)
   end
}

local nanab_berry = {
   name = 'nanab_berry',
   key = 'nanab_berry',
   set = 'Berry',
   pos = { x = 3, y = 2 },
   config = { max_highlighted = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      poke_remove_card(G.hand.highlighted[1], card)
   end
}

local wepear_berry = {
   name = 'wepear_berry',
   key = 'wepear_berry',
   set = 'Berry',
   pos = { x = 4, y = 2 },
   config = { max_highlighted = 1, money_mod = 5, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.money_mod } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      if not G.hand.highlighted or #G.hand.highlighted ~= 1 then
         return false
      end
      local target = G.hand.highlighted[1]
      return target.config.center ~= G.P_CENTERS.c_base and not target.vampired
   end,
   use = function(self, card, area, copier)
      local target = G.hand.highlighted[1]
      target:set_ability(G.P_CENTERS.c_base, nil, true)
      G.E_MANAGER:add_event(Event({
         func = function()
            target:juice_up()
            return true
         end
      }))
      ease_dollars(self.config.money_mod)
   end
}

local pinap_berry = {
   name = 'pinap_berry',
   key = 'pinap_berry',
   set = 'Berry',
   pos = { x = 5, y = 2 },
   config = { max_highlighted = 1, extra_value = 14 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 1,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return false
   end,
}

local pomeg_berry = {
   name = 'pomeg_berry',
   key = 'pomeg_berry',
   set = 'Berry',
   pos = { x = 6, y = 2 },
   config = { drain_amt = 1, earn_mult = 2, flavor_filter = 'Bland', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'poke_drain' }
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      return { vars = { self.config.drain_amt, self.config.flavor_filter, self.config.earn_mult } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and joker.sell_cost > 1 then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local earn_amount = 0
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            earn_amount = earn_amount + joker.sell_cost
            poke_drain(nil, joker, self.config.drain_amt, true)
            earn_amount = earn_amount - joker.sell_cost
         end
      end
      ease_dollars(earn_amount * self.config.earn_mult)
   end
}

local kelpsy_berry = {
   name = 'kelpsy_berry',
   key = 'kelpsy_berry',
   set = 'Berry',
   pos = { x = 0, y = 3 },
   config = { drain_amt = 1, earn_mult = 2, flavor_filter = 'Spicy', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'poke_drain' }
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      return { vars = { self.config.drain_amt, self.config.flavor_filter, self.config.earn_mult } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and joker.sell_cost > 1 then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local earn_amount = 0
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            earn_amount = earn_amount + joker.sell_cost
            poke_drain(nil, joker, self.config.drain_amt, true)
            earn_amount = earn_amount - joker.sell_cost
         end
      end
      ease_dollars(earn_amount * self.config.earn_mult)
   end
}

local qualot_berry = {
   name = 'qualot_berry',
   key = 'qualot_berry',
   set = 'Berry',
   pos = { x = 1, y = 3 },
   config = { drain_amt = 1, earn_mult = 2, flavor_filter = 'Dry', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'poke_drain' }
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      return { vars = { self.config.drain_amt, self.config.flavor_filter, self.config.earn_mult } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and joker.sell_cost > 1 then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local earn_amount = 0
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            earn_amount = earn_amount + joker.sell_cost
            poke_drain(nil, joker, self.config.drain_amt, true)
            earn_amount = earn_amount - joker.sell_cost
         end
      end
      ease_dollars(earn_amount * self.config.earn_mult)
   end
}

local hondew_berry = {
   name = 'hondew_berry',
   key = 'hondew_berry',
   set = 'Berry',
   pos = { x = 2, y = 3 },
   config = { drain_amt = 1, earn_mult = 2, flavor_filter = 'Sweet', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'poke_drain' }
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      return { vars = { self.config.drain_amt, self.config.flavor_filter, self.config.earn_mult } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and joker.sell_cost > 1 then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local earn_amount = 0
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            earn_amount = earn_amount + joker.sell_cost
            poke_drain(nil, joker, self.config.drain_amt, true)
            earn_amount = earn_amount - joker.sell_cost
         end
      end
      ease_dollars(earn_amount * self.config.earn_mult)
   end
}

local grepa_berry = {
   name = 'grepa_berry',
   key = 'grepa_berry',
   set = 'Berry',
   pos = { x = 3, y = 3 },
   config = { drain_amt = 1, earn_mult = 2, flavor_filter = 'Bitter', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'poke_drain' }
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      return { vars = { self.config.drain_amt, self.config.flavor_filter, self.config.earn_mult } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and joker.sell_cost > 1 then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local earn_amount = 0
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            earn_amount = earn_amount + joker.sell_cost
            poke_drain(nil, joker, self.config.drain_amt, true)
            earn_amount = earn_amount - joker.sell_cost
         end
      end
      ease_dollars(earn_amount * self.config.earn_mult)
   end
}

local tamato_berry = {
   name = 'tamato_berry',
   key = 'tamato_berry',
   set = 'Berry',
   pos = { x = 4, y = 3 },
   config = { drain_amt = 1, earn_mult = 2, flavor_filter = 'Sour', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = 'Other', key = 'poke_drain' }
      info_queue[#info_queue + 1] = { set = 'Other', key = self.config.flavor_filter:lower() }
      return { vars = { self.config.drain_amt, self.config.flavor_filter, self.config.earn_mult } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) and joker.sell_cost > 1 then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      local earn_amount = 0
      for _, joker in pairs(G.jokers.cards) do
         if is_flavor_type(joker, self.config.flavor_filter) then
            earn_amount = earn_amount + joker.sell_cost
            poke_drain(nil, joker, self.config.drain_amt, true)
            earn_amount = earn_amount - joker.sell_cost
         end
      end
      ease_dollars(earn_amount * self.config.earn_mult)
   end
}

local cornn_berry = {
   name = 'cornn_berry',
   key = 'cornn_berry',
   set = 'Berry',
   pos = { x = 5, y = 3 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return true
   end,
   use = function(self, card, area, copier)
      local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'cornn')
      _card:add_to_deck()
      G.consumeables:emplace(_card)
   end
}

local magost_berry = {
   name = 'magost_berry',
   key = 'magost_berry',
   set = 'Berry',
   pos = { x = 6, y = 3 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return true
   end,
   use = function(self, card, area, copier)
      local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'magost')
      _card:add_to_deck()
      G.consumeables:emplace(_card)
   end
}

local rabuta_berry = {
   name = 'rabuta_berry',
   key = 'rabuta_berry',
   set = 'Berry',
   pos = { x = 0, y = 4 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return true
   end,
   use = function(self, card, area, copier)
      local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, nil, 'rabuta')
      _card:add_to_deck()
      G.consumeables:emplace(_card)
   end
}

local nomel_berry = {
   name = 'nomel_berry',
   key = 'nomel_berry',
   set = 'Berry',
   pos = { x = 1, y = 4 },
   config = { max_highlighted = 1, chances = 4, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
      info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
      info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
      return { vars = { G.GAME.probabilities.normal, self.config.chances } }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      if pseudorandom('nomel') < G.GAME.probabilities.normal / self.config.chances then
         local target = G.jokers.highlighted[1]
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
               local edition = poll_edition('wheel_of_fortune', nil, true, true)
               target:set_edition(edition, true)
               return true
            end
         }))
      else
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
               attention_text({
                  text = localize('k_nope_ex'),
                  scale = 1.3,
                  hold = 1.4,
                  major = card,
                  backdrop_colour = G.C.SECONDARY_SET.Tarot,
                  align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                      'tm' or 'cm',
                  offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                  silent = true
               })
               G.E_MANAGER:add_event(Event({
                  trigger = 'after',
                  delay = 0.06 * G.SETTINGS.GAMESPEED,
                  blockable = false,
                  blocking = false,
                  func = function()
                     play_sound('tarot2', 0.76, 0.4); return true
                  end
               }))
               play_sound('tarot2', 1, 0.4)
               card:juice_up(0.3, 0.5)
               return true
            end
         }))
      end
   end
}

local spelon_berry = {
   name = 'spelon_berry',
   key = 'spelon_berry',
   set = 'Berry',
   pos = { x = 2, y = 4 },
   config = { max_highlighted = 1, chances = 4, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
      info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
      info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
      return { vars = { G.GAME.probabilities.normal, self.config.chances } }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      if pseudorandom('spelon') < G.GAME.probabilities.normal / self.config.chances then
         local target = G.hand.highlighted[1]
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
               local edition = poll_edition('wheel_of_fortune', nil, true, true)
               target:set_edition(edition, true)
               return true
            end
         }))
      else
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
               attention_text({
                  text = localize('k_nope_ex'),
                  scale = 1.3,
                  hold = 1.4,
                  major = card,
                  backdrop_colour = G.C.SECONDARY_SET.Tarot,
                  align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                      'tm' or 'cm',
                  offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                  silent = true
               })
               G.E_MANAGER:add_event(Event({
                  trigger = 'after',
                  delay = 0.06 * G.SETTINGS.GAMESPEED,
                  blockable = false,
                  blocking = false,
                  func = function()
                     play_sound('tarot2', 0.76, 0.4); return true
                  end
               }))
               play_sound('tarot2', 1, 0.4)
               card:juice_up(0.3, 0.5)
               return true
            end
         }))
      end
   end
}

local pamtre_berry = {
   name = 'pamtre_berry',
   key = 'pamtre_berry',
   set = 'Berry',
   pos = { x = 3, y = 4 },
   config = { max_highlighted = 1, chances = 4, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
      info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
      info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
      return { vars = { G.GAME.probabilities.normal, self.config.chances } }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      for _, consume in pairs(G.consumeables.cards) do
         if not consume.edition and consume ~= card then
            return true
         end
      end
      return false
   end,
   use = function(self, card, area, copier)
      if pseudorandom('spelon') < G.GAME.probabilities.normal / self.config.chances then
         local options = {}
         for _, consume in pairs(G.consumeables.cards) do
            if not consume.edition and consume ~= card then
               table.insert(options, consume)
            end
         end
         local target = pseudorandom_element(options, pseudoseed('pamtre'))
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
               local edition = poll_edition('wheel_of_fortune', nil, true, true)
               target:set_edition(edition, true)
               return true
            end
         }))
      else
         G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
               attention_text({
                  text = localize('k_nope_ex'),
                  scale = 1.3,
                  hold = 1.4,
                  major = card,
                  backdrop_colour = G.C.SECONDARY_SET.Tarot,
                  align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                      'tm' or 'cm',
                  offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                  silent = true
               })
               G.E_MANAGER:add_event(Event({
                  trigger = 'after',
                  delay = 0.06 * G.SETTINGS.GAMESPEED,
                  blockable = false,
                  blocking = false,
                  func = function()
                     play_sound('tarot2', 0.76, 0.4); return true
                  end
               }))
               play_sound('tarot2', 1, 0.4)
               card:juice_up(0.3, 0.5)
               return true
            end
         }))
      end
   end
}

local watmel_berry = {
   name = 'watmel_berry',
   key = 'watmel_berry',
   set = 'Berry',
   pos = { x = 4, y = 4 },
   config = { max_highlighted = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to({ random = true, seed = 'watmel' })
   end
}

local durin_berry = {
   name = 'durin_berry',
   key = 'durin_berry',
   set = 'Berry',
   pos = { x = 5, y = 4 },
   config = { max_highlighted = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to({ down = true, seed = 'durin' })
   end
}

local belue_berry = {
   name = 'belue_berry',
   key = 'belue_berry',
   set = 'Berry',
   pos = { x = 6, y = 4 },
   config = { max_highlighted = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to({ up = true, seed = 'belue' })
   end
}

local occa_berry = {
   name = 'occa_berry',
   key = 'occa_berry',
   set = 'Berry',
   pos = { x = 0, y = 5 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Fire', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local passho_berry = {
   name = 'passho_berry',
   key = 'passho_berry',
   set = 'Berry',
   pos = { x = 1, y = 5 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Water', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local wacan_berry = {
   name = 'wacan_berry',
   key = 'wacan_berry',
   set = 'Berry',
   pos = { x = 2, y = 5 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Lightning', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local rindo_berry = {
   name = 'rindo_berry',
   key = 'rindo_berry',
   set = 'Berry',
   pos = { x = 3, y = 5 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Grass', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local yache_berry = {
   name = 'yache_berry',
   key = 'yache_berry',
   set = 'Berry',
   pos = { x = 4, y = 5 },
   config = { max_highlighted = 1, seal = 'Blue', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_SEALS['blue_seal'] or G.P_SEALS[SMODS.Seal.badge_to_key['blue_seal'] or '']
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local chople_berry = {
   name = 'chople_berry',
   key = 'chople_berry',
   set = 'Berry',
   pos = { x = 5, y = 5 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Fighting', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local kebia_berry = {
   name = 'kebia_berry',
   key = 'kebia_berry',
   set = 'Berry',
   pos = { x = 6, y = 5 },
   config = { max_highlighted = 1, seal = 'Red', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_SEALS['red_seal'] or G.P_SEALS[SMODS.Seal.badge_to_key['red_seal'] or '']
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local shuca_berry = {
   name = 'shuca_berry',
   key = 'shuca_berry',
   set = 'Berry',
   pos = { x = 0, y = 6 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Earth', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local coba_berry = {
   name = 'coba_berry',
   key = 'coba_berry',
   set = 'Berry',
   pos = { x = 1, y = 6 },
   config = { max_highlighted = 1, seal = 'poke_silver', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { key = 'poke_silver_seal', set = 'Other' }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local payapa_berry = {
   name = 'payapa_berry',
   key = 'payapa_berry',
   set = 'Berry',
   pos = { x = 2, y = 6 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Psychic', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local tanga_berry = {
   name = 'tanga_berry',
   key = 'tanga_berry',
   set = 'Berry',
   pos = { x = 3, y = 6 },
   config = { max_highlighted = 1, seal = 'poke_pink_seal', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { key = 'poke_pink_seal_seal', set = 'Other' }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local charti_berry = {
   name = 'charti_berry',
   key = 'charti_berry',
   set = 'Berry',
   pos = { x = 4, y = 6 },
   config = { max_highlighted = 1, seal = 'Gold', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_SEALS['gold_seal'] or G.P_SEALS[SMODS.Seal.badge_to_key['gold_seal'] or '']
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local kasib_berry = {
   name = 'kasib_berry',
   key = 'kasib_berry',
   set = 'Berry',
   pos = { x = 5, y = 6 },
   config = { max_highlighted = 1, seal = 'Purple', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_SEALS['purple_seal'] or G.P_SEALS[SMODS.Seal.badge_to_key['purple_seal'] or '']
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local haban_berry = {
   name = 'haban_berry',
   key = 'haban_berry',
   set = 'Berry',
   pos = { x = 6, y = 6 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Dragon', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local colbur_berry = {
   name = 'colbur_berry',
   key = 'colbur_berry',
   set = 'Berry',
   pos = { x = 0, y = 7 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Dark', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local babiri_berry = {
   name = 'babiri_berry',
   key = 'babiri_berry',
   set = 'Berry',
   pos = { x = 1, y = 7 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Metal', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local chilan_berry = {
   name = 'chilan_berry',
   key = 'chilan_berry',
   set = 'Berry',
   pos = { x = 2, y = 7 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Colorless', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local liechi_berry = {
   name = 'liechi_berry',
   key = 'liechi_berry',
   set = 'Berry',
   pos = { x = 3, y = 7 },
   config = { max_highlighted = 1, mod_conv = 'm_mult', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local ganlon_berry = {
   name = 'ganlon_berry',
   key = 'ganlon_berry',
   set = 'Berry',
   pos = { x = 4, y = 7 },
   config = { max_highlighted = 1, mod_conv = 'm_stone', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local salac_berry = {
   name = 'salac_berry',
   key = 'salac_berry',
   set = 'Berry',
   pos = { x = 5, y = 7 },
   config = { max_highlighted = 1, mod_conv = 'm_steel', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local petaya_berry = {
   name = 'petaya_berry',
   key = 'petaya_berry',
   set = 'Berry',
   pos = { x = 6, y = 7 },
   config = { max_highlighted = 1, mod_conv = 'm_bonus', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local apicot_berry = {
   name = 'apicot_berry',
   key = 'apicot_berry',
   set = 'Berry',
   pos = { x = 0, y = 8 },
   config = { max_highlighted = 1, mod_conv = 'm_gold', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local lansat_berry = {
   name = 'lansat_berry',
   key = 'lansat_berry',
   set = 'Berry',
   pos = { x = 1, y = 8 },
   config = { max_highlighted = 1, mod_conv = 'm_lucky', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local starf_berry = {
   name = 'starf_berry',
   key = 'starf_berry',
   set = 'Berry',
   pos = { x = 2, y = 8 },
   config = { max_highlighted = 1, mod_conv = 'm_wild', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local enigma_berry = {
   name = 'enigma_berry',
   key = 'enigma_berry',
   set = 'Berry',
   pos = { x = 3, y = 8 },
   config = { max_highlighted = 1, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      local types = {}
      local count = 0
      if G.jokers and G.jokers.cards then
         for _, joker in pairs(G.jokers.cards) do
            local type = get_type(joker)
            if type and not types[type] then
               types[type] = true
               count = count + 1
            end
         end
      end
      return { vars = { count } }
   end,
   atlas = 'berries',
   cost = 8,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local types = {}
      local to_gain = 0
      for _, joker in pairs(G.jokers.cards) do
         local type = get_type(joker)
         if type and not types[type] then
            types[type] = true
            to_gain = to_gain + 1
         end
      end
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1])
   end
}

local micle_berry = {
   name = 'micle_berry',
   key = 'micle_berry',
   set = 'Berry',
   pos = { x = 4, y = 8 },
   config = { max_highlighted = 1, mod_conv = 'm_glass', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   use = function(self, card, area, copier)
      convert_cards_to(self.config)
   end
}

local custap_berry = {
   name = 'custap_berry',
   key = 'custap_berry',
   set = 'Berry',
   pos = { x = 5, y = 8 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { G.P_TAGS['tag_poke_xmult_tag'].config.Xmult } }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return true
   end,
   use = function(self, card, area, copier)
      add_tag(Tag('tag_poke_xmult_tag'))
      create_calculations_voucher()
   end
}

local jaboca_berry = {
   name = 'jaboca_berry',
   key = 'jaboca_berry',
   set = 'Berry',
   pos = { x = 6, y = 8 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.GAME.blind
   end,
   use = function(self, card, area, copier)
      if G.GAME.blind then
         G.GAME.blind.chips = G.GAME.blind.chips * 0.9
         G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
      end
   end
}

local rowap_berry = {
   name = 'rowap_berry',
   key = 'rowap_berry',
   set = 'Berry',
   pos = { x = 0, y = 9 },
   config = { money_mod = 2, extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.money_mod } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return #G.jokers.cards > 0
   end,
   use = function(self, card, area, copier)
      for _, joker in pairs(G.jokers.cards) do
         local target = joker
         target.ability.extra_value = target.ability.extra_value + self.config.money_mod
         target:set_cost()
         G.E_MANAGER:add_event(Event({
            func = function()
               card_eval_status_text(target, 'extra', nil, nil, nil, { message = localize('k_val_up') }); return true
            end
         }))
      end
   end
}

local roseli_berry = {
   name = 'roseli_berry',
   key = 'roseli_berry',
   set = 'Berry',
   pos = { x = 1, y = 9 },
   config = { max_highlighted = 1, energy_ratio = 3, type_filter = 'Fairy', extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { self.config.energy_ratio, math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio), self.config.type_filter } }
   end,
   atlas = 'berries',
   cost = 4,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return G.jokers.highlighted and #G.jokers.highlighted == 1
   end,
   use = function(self, card, area, copier)
      local to_gain = math.floor(#find_pokemon_type(self.config.type_filter) / self.config.energy_ratio)
      for i = 1, to_gain do
         energy_increase(G.jokers.highlighted[1], "Trans")
      end
      apply_type_sticker(G.jokers.highlighted[1], self.config.type_filter)
   end
}

local kee_berry = {
   name = 'kee_berry',
   key = 'kee_berry',
   set = 'Berry',
   pos = { x = 2, y = 9 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { G.P_TAGS['tag_poke_chips_tag'].config.chips } }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return true
   end,
   use = function(self, card, area, copier)
      add_tag(Tag('tag_poke_chips_tag'))
      create_calculations_voucher()
   end
}

local maranga_berry = {
   name = 'maranga_berry',
   key = 'maranga_berry',
   set = 'Berry',
   pos = { x = 3, y = 9 },
   config = { extra_value = 1 },
   loc_vars = function(self, info_queue, card)
      return { vars = { G.P_TAGS['tag_poke_mult_tag'].config.mult } }
   end,
   atlas = 'berries',
   cost = 6,
   unlocked = true,
   discovered = true,
   can_use = function(self, card)
      return true
   end,
   use = function(self, card, area, copier)
      add_tag(Tag('tag_poke_mult_tag'))
      create_calculations_voucher()
   end
}






return {
   name = "Berries",
   list = { cheri_berry, chesto_berry, pecha_berry, rawst_berry, aspear_berry, watmel_berry, durin_berry, belue_berry,
      nanab_berry, wepear_berry, liechi_berry, ganlon_berry, salac_berry, petaya_berry, apicot_berry, lansat_berry,
      starf_berry, micle_berry, nomel_berry, spelon_berry, pamtre_berry, yache_berry, kebia_berry, coba_berry,
      tanga_berry, charti_berry, kasib_berry, oran_berry, persim_berry, sitrus_berry, figy_berry, wiki_berry, mago_berry,
      aguav_berry, iapapa_berry, occa_berry, passho_berry, wacan_berry, rindo_berry, chople_berry, shuca_berry,
      payapa_berry, haban_berry, colbur_berry, babiri_berry, roseli_berry, chilan_berry, enigma_berry, razz_berry,
      pomeg_berry, kelpsy_berry, qualot_berry, hondew_berry, grepa_berry, tamato_berry, leppa_berry, rowap_berry,
      bluk_berry, cornn_berry, magost_berry, rabuta_berry, jaboca_berry, kee_berry, maranga_berry, custap_berry,
      lum_berry, pinap_berry }
}
