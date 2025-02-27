local berry_basket = {
   name = "berry_basket",
   pos = { x = 0, y = 0 },
   config = { extra = { round_berry_given = 0 } },
   loc_vars = function(self, info_queue, card)
   end,
   rarity = 1,
   cost = 5,
   stage = "Other",
   atlas = "others",
   poke_custom_prefix = "kek",
   perishable_compat = false,
   blueprint_compat = false,
   calculate = function(self, card, context)
      if not context.blueprint and G.GAME.round > card.ability.extra.round_berry_given then
         if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            SMODS.add_card({ set = "Berry" })
            card.ability.extra.round_berry_given = G.GAME.round
            card:juice_up()
         elseif not card.juice or card.juice.end_time < G.TIMERS.REAL then
            local eval = function(_card) return G.GAME.round > _card.ability.extra.round_berry_given and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
         end
      end
   end,
   add_to_deck = function(self, card, from_debuff)
      if not from_debuff then
         if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            SMODS.add_card({ set = "Berry" })
            card.ability.extra.round_berry_given = G.GAME.round
            card:juice_up()
         elseif not card.juice or card.juice.end_time < G.TIMERS.REAL then
            local eval = function(_card) return G.GAME.round > _card.ability.extra.round_berry_given and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
         end
      end
   end,
}

return {
   name = "PokermonPlus1",
   list = { berry_basket },
}
