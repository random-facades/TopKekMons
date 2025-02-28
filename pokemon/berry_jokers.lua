local berry_basket = {
   name = "berry_basket",
   pos = { x = 0, y = 0 },
   config = { extra = { round_berry_given = 0 } },
   loc_vars = function(self, info_queue, card)
   end,
   rarity = 1,
   cost = 5,
   stage = "Other",
   atlas = "kek_others",
   perishable_compat = false,
   blueprint_compat = false,
   calculate = function(self, card, context)
      if not context.blueprint and G.GAME.round > card.ability.extra.round_berry_given then
         local card_count = #G.consumeables.cards + G.GAME.consumeable_buffer
         --SMODS.calculate_context({selling_card = true, card = card})
         if context.selling_card then
            for _, consume in pairs(G.consumeables.cards) do
               if consume == context.card then
                  card_count = card_count - 1
                  break
               end
            end
         end
         if card_count < G.consumeables.config.card_limit then
            card.ability.extra.round_berry_given = G.GAME.round
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
               trigger = 'immediate',
               func = function()
                  SMODS.add_card({ set = "Berry" })
                  card:juice_up()
                  G.GAME.consumeable_buffer = 0
                  return true
               end
            }))
         elseif not card.juice or card.juice.end_time < G.TIMERS.REAL then
            local eval = function(_card) return G.GAME.round > _card.ability.extra.round_berry_given and
               not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
         end
      end
   end,
   add_to_deck = function(self, card, from_debuff)
      if not from_debuff then
         if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            card.ability.extra.round_berry_given = G.GAME.round
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
               trigger = 'immediate',
               func = function()
                  SMODS.add_card({ set = "Berry" })
                  card:juice_up()
                  G.GAME.consumeable_buffer = 0
                  return true
               end
            }))
         elseif not card.juice or card.juice.end_time < G.TIMERS.REAL then
            local eval = function(_card) return G.GAME.round > _card.ability.extra.round_berry_given and
               not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
         end
      end
   end,
}

return {
   name = "PokermonPlus1",
   list = { berry_basket },
}
