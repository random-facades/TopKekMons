local cyndaquil = {
   name = "cyndaquil",
   pos = { x = 3, y = 0 },
   config = { extra = { mult = 0, mult_mod = 2, d_size = 1, hands = 1, evo_rqmt = 16 } },
   loc_vars = function(self, info_queue, card)
      type_tooltip(self, info_queue, card)
      return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.d_size, card.ability.extra.hands } }
   end,
   rarity = 2,
   cost = 5,
   stage = "Basic",
   ptype = "Fire",
   atlas = "Pokedex2",
   poke_custom_prefix = "kek",
   perishable_compat = false,
   blueprint_compat = true,
   calculate = function(self, card, context)
      if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
         if G.GAME.current_round.discards_left > 0 then
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.current_round.discards_left * card.ability.extra.mult_mod
            if card.ability.extra.mult >= self.config.extra.evo_rqmt then
               local eval = function(_card) return not _card.REMOVED end
               juice_card_until(card, eval, true)
            end
            local ret = scaling_evo(self, card, context, "j_kek_quilava", card.ability.extra.mult, self.config.extra.evo_rqmt)
            if ret then return ret end
            return {
               message = localize('k_upgrade_ex'),
               colour = G.C.MULT
            }
         end
      end
      if context.cardarea == G.jokers and context.scoring_hand and context.joker_main and card.ability.extra.mult > 0 then
         return {
            message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
         }
      end
      return scaling_evo(self, card, context, "j_kek_quilava", card.ability.extra.mult, self.config.extra.evo_rqmt)
   end,
   add_to_deck = function(self, card, from_debuff)
      if not from_debuff then
         G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
         ease_discard(card.ability.extra.d_size)
         G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
         ease_hands_played(-card.ability.extra.hands)
      end
   end,
   remove_from_deck = function(self, card, from_debuff)
      if not from_debuff then
         G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
         ease_discard(-card.ability.extra.d_size)
         G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
         ease_hands_played(card.ability.extra.hands)
      end
   end,
}

local quilava = {
   name = "quilava",
   pos = { x = 4, y = 0 },
   config = { extra = { mult = 0, mult_mod = 3, d_size = 1, hands = 1, evo_rqmt = 32 } },
   loc_vars = function(self, info_queue, card)
      type_tooltip(self, info_queue, card)
      return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.d_size, card.ability.extra.hands } }
   end,
   rarity = "poke_safari",
   cost = 7,
   stage = "One",
   ptype = "Fire",
   atlas = "Pokedex2",
   poke_custom_prefix = "kek",
   perishable_compat = false,
   blueprint_compat = true,
   calculate = function(self, card, context)
      if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
         if G.GAME.current_round.discards_left > 0 then
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.current_round.discards_left * card.ability.extra.mult_mod
            if card.ability.extra.mult >= self.config.extra.evo_rqmt then
               local eval = function(_card) return not _card.REMOVED end
               juice_card_until(card, eval, true)
            end
            local ret = scaling_evo(self, card, context, "j_kek_typhlosion", card.ability.extra.mult, self.config.extra.evo_rqmt)
            if ret then return ret end
            return {
               message = localize('k_upgrade_ex'),
               colour = G.C.MULT
            }
         end
      end
      if context.cardarea == G.jokers and context.scoring_hand and context.joker_main and card.ability.extra.mult > 0 then
         return {
            message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
         }
      end
      return scaling_evo(self, card, context, "j_kek_typhlosion", card.ability.extra.mult, self.config.extra.evo_rqmt)
   end,
   add_to_deck = function(self, card, from_debuff)
      if not from_debuff then
         G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
         ease_discard(card.ability.extra.d_size)
         G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
         ease_hands_played(-card.ability.extra.hands)
      end
   end,
   remove_from_deck = function(self, card, from_debuff)
      if not from_debuff then
         G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
         ease_discard(-card.ability.extra.d_size)
         G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
         ease_hands_played(card.ability.extra.hands)
      end
   end,
}

local typhlosion = {
   name = "typhlosion",
   pos = { x = 5, y = 0 },
   config = { extra = { mult = 0, mult_mod = 4, d_size = 1, hands = 1 } },
   loc_vars = function(self, info_queue, card)
      type_tooltip(self, info_queue, card)
      return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.d_size, card.ability.extra.hands } }
   end,
   rarity = "poke_safari",
   cost = 10,
   stage = "Two",
   ptype = "Fire",
   atlas = "Pokedex2",
   poke_custom_prefix = "kek",
   perishable_compat = false,
   blueprint_compat = true,
   calculate = function(self, card, context)
      if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
         if G.GAME.current_round.discards_left > 0 then
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.current_round.discards_left * card.ability.extra.mult_mod
            return {
               message = localize('k_upgrade_ex'),
               colour = G.C.MULT
            }
         end
      end
      if context.cardarea == G.jokers and context.scoring_hand and context.joker_main and card.ability.extra.mult > 0 then
         return {
            message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
         }
      end
   end,
   add_to_deck = function(self, card, from_debuff)
      if not from_debuff then
         G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
         ease_discard(card.ability.extra.d_size)
         G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
         ease_hands_played(-card.ability.extra.hands)
      end
   end,
   remove_from_deck = function(self, card, from_debuff)
      if not from_debuff then
         G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
         ease_discard(-card.ability.extra.d_size)
         G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
         ease_hands_played(card.ability.extra.hands)
      end
   end,
}

return {
   name = "PokermonPlus1",
   list = { cyndaquil, quilava, typhlosion },
}
