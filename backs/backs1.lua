local symboldeck = {
   name = "symboldeck",
   key = "symboldeck",
   atlas = "deckskins",
   pos = { x = 0, y = 0 },
   config = {},
   loc_vars = function(self, info_queue, center)
      return { vars = {} }
   end,
   apply = function(self)
      G.GAME.Unown = true
      G.GAME.starting_params.unown_cards = true
      G.GAME.starting_params.extra_cards = G.GAME.starting_params.extra_cards or {}
      table.insert(G.GAME.starting_params.extra_cards, { s = 'poke_Unown', r = 'poke_UZ!' })
      table.insert(G.GAME.starting_params.extra_cards, { s = 'poke_Unown', r = 'poke_UZ!' })
      table.insert(G.GAME.starting_params.extra_cards, { s = 'poke_Unown', r = 'poke_UZ?' })
      table.insert(G.GAME.starting_params.extra_cards, { s = 'poke_Unown', r = 'poke_UZ?' })

      G.E_MANAGER:add_event(Event({
         func = function()
            for k, v in pairs(G.playing_cards) do
               if v.base.suit == 'poke_Unown' and G.GAME.starting_params.erratic_suits_and_ranks then
                  local new_rank = pseudorandom_element(poke_unown_rank_names, pseudoseed('erratic'), {starting_deck = true})
                  SMODS.change_base(v, 'poke_Unown', new_rank)
               end
            end
            return true
         end
      }))
   end
}




return {
   name = "Back",
   list = { symboldeck }
}
