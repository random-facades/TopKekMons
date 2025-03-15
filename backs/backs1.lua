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
      G.E_MANAGER:add_event(Event({
         func = function()
            local count = 0
            for k, v in pairs(G.playing_cards) do
               SMODS.change_base(v, 'poke_Unown', poke_unown_rank_names[1 + (count % #poke_unown_rank_names)])
               count = count+1
            end
            create_playing_card({ front = G.P_CARDS['poke_Unown_poke_UZ!'] }, G.deck, nil, nil, { G.C.PURPLE })
            create_playing_card({ front = G.P_CARDS['poke_Unown_poke_UZ!'] }, G.deck, nil, nil, { G.C.PURPLE })
            create_playing_card({ front = G.P_CARDS['poke_Unown_poke_UZ?'] }, G.deck, nil, nil, { G.C.PURPLE })
            create_playing_card({ front = G.P_CARDS['poke_Unown_poke_UZ?'] }, G.deck, nil, nil, { G.C.PURPLE })
            return true
         end
      }))
   end
}




return {
   name = "Back",
   list = { symboldeck }
}
