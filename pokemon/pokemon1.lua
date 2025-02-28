local snivy = {
  name = "snivy",
  pos = { x = 1, y = 0 },
  config = { extra = { h_size = 1, triggers_needed = 2, curr_count = 0, lifetime_triggers = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.h_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.lifetime_triggers } }
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Grass",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.blueprint and context.pre_discard and not context.hook then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % 2 == 0 then
        increase_hand_size_without_draw(G.hand, card.ability.extra.h_size, card)
        card.ability.extra.lifetime_triggers = card.ability.extra.lifetime_triggers + 1
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.curr_count >= card.ability.extra.triggers_needed then
        local to_decrease = math.floor(card.ability.extra.curr_count / 2)
        G.hand:change_size(-to_decrease)
        card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_reset') })
      end
      card.ability.extra.curr_count = 0
    end
    return scaling_evo(self, card, context, "j_poke_servine", card.ability.extra.lifetime_triggers, 4)
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / 2)
      G.hand:change_size(-to_decrease)
    end
  end,
}
-- Servine 496
local servine = {
  name = "servine",
  pos = { x = 2, y = 0 },
  config = { extra = { h_size = 1, triggers_needed = 2, curr_count = 0, lifetime_triggers = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.h_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.lifetime_triggers } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Grass",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if not blueprint and discard or the "before" hand is scored
    if not context.blueprint and ((context.pre_discard and not context.hook) or (context.cardarea == G.jokers and context.scoring_hand and context.before)) then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % card.ability.extra.triggers_needed == 0 then
        increase_hand_size_without_draw(G.hand, card.ability.extra.h_size, card)
        card.ability.extra.lifetime_triggers = card.ability.extra.lifetime_triggers + 1
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.curr_count >= card.ability.extra.triggers_needed then
        local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
        G.hand:change_size(-to_decrease)
        card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_reset') })
      end
      card.ability.extra.curr_count = 0
    end
    return scaling_evo(self, card, context, "j_poke_serperior", card.ability.extra.lifetime_triggers, 10)
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / 2)
      G.hand:change_size(-to_decrease)
    end
  end,
}
-- Serperior 497
local serperior = {
  name = "serperior",
  pos = { x = 3, y = 0 },
  config = { extra = { h_size = 1, curr_count = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.h_size } }
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Grass",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.blueprint and ((context.pre_discard and not context.hook) or (context.cardarea == G.jokers and context.scoring_hand and context.before)) then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      increase_hand_size_without_draw(G.hand, card.ability.extra.h_size, card)
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.curr_count > 0 then
        G.hand:change_size(-card.ability.extra.curr_count)
        card.ability.extra.curr_count = 0
        card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_reset') })
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      G.hand:change_size(-card.ability.extra.curr_count)
    end
  end,
}
-- Tepig 498
local tepig = {
  name = "tepig",
  pos = { x = 4, y = 0 },
  config = { extra = { d_size = 1, triggers_needed = 3, curr_count = 0, lifetime_triggers = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.d_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.lifetime_triggers } }
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Fire",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if not blueprint and discard or the "before" hand is scored
    if not context.blueprint and context.pre_discard and not context.hook then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % card.ability.extra.triggers_needed == 0 then
        ease_discard(card.ability.extra.d_size)
        card:juice_up(0.1)
        card.ability.extra.lifetime_triggers = card.ability.extra.lifetime_triggers + 1
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.curr_count = 0
    end
    return scaling_evo(self, card, context, "j_poke_pignite", card.ability.extra.lifetime_triggers, 4)
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
      ease_discard(-to_decrease)
    end
  end,
}
-- Pignite 499
local pignite = {
  name = "pignite",
  pos = { x = 5, y = 0 },
  config = { extra = { d_size = 1, triggers_needed = 3, curr_count = 0, lifetime_triggers = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.d_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.lifetime_triggers } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fire",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if not blueprint and discard or the "before" hand is scored
    if not context.blueprint and ((context.pre_discard and not context.hook) or (context.cardarea == G.jokers and context.scoring_hand and context.before)) then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % card.ability.extra.triggers_needed == 0 then
        ease_discard(card.ability.extra.d_size)
        card:juice_up(0.1)
        card.ability.extra.lifetime_triggers = card.ability.extra.lifetime_triggers + 1
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.curr_count = 0
    end
    return scaling_evo(self, card, context, "j_poke_emboar", card.ability.extra.lifetime_triggers, 10)
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
      ease_discard(-to_decrease)
    end
  end,
}
-- Emboar 500
local emboar = {
  name = "emboar",
  pos = { x = 6, y = 0 },
  config = { extra = { d_size = 1, Xmult_mod = 0.5, triggers_needed = 3, curr_count = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local xmult = 1 + card.ability.extra.Xmult_mod * (G.GAME.current_round.discards_left or 0)
    return { vars = { card.ability.extra.d_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.Xmult_mod, xmult } }
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fire",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if not blueprint and discard or the "before" hand is scored
    if not context.blueprint and ((context.pre_discard and not context.hook) or (context.cardarea == G.jokers and context.scoring_hand and context.before)) then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % card.ability.extra.triggers_needed == 0 then
        ease_discard(card.ability.extra.d_size)
        card:juice_up(0.1)
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xmult = 1 + card.ability.extra.Xmult_mod * (G.GAME.current_round.discards_left or 0)
        return {
          message = localize { type = 'variable', key = 'a_xmult', vars = { xmult } },
          colour = G.C.XMULT,
          Xmult_mod = xmult
        }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.curr_count = 0
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
      ease_discard(-to_decrease)
    end
  end,
}
-- Oshawott 501
local oshawott = {
  name = "oshawott",
  pos = { x = 7, y = 0 },
  config = { extra = { d_size = 1, triggers_needed = 2, curr_count = 0, lifetime_triggers = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.d_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.lifetime_triggers } }
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Water",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if not blueprint and discard or the "before" hand is scored
    if not context.blueprint and context.pre_discard and not context.hook then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % card.ability.extra.triggers_needed == 0 then
        ease_hands_played(card.ability.extra.d_size)
        card:juice_up(0.1)
        card.ability.extra.lifetime_triggers = card.ability.extra.lifetime_triggers + 1
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.curr_count = 0
    end
    return scaling_evo(self, card, context, "j_poke_dewott", card.ability.extra.lifetime_triggers, 4)
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
      ease_hands_played(-to_decrease)
    end
  end,
}
-- Dewott 502
local dewott = {
  name = "dewott",
  pos = { x = 8, y = 0 },
  config = { extra = { d_size = 1, triggers_needed = 3, curr_count = 0, lifetime_triggers = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.d_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.lifetime_triggers } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Water",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if not blueprint and discard or the "before" hand is scored
    if not context.blueprint and ((context.pre_discard and not context.hook) or (context.cardarea == G.jokers and context.scoring_hand and context.before)) then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % card.ability.extra.triggers_needed == 0 then
        ease_hands_played(card.ability.extra.d_size)
        card:juice_up(0.1)
        card.ability.extra.lifetime_triggers = card.ability.extra.lifetime_triggers + 1
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.curr_count = 0
    end
    return scaling_evo(self, card, context, "j_poke_samurott", card.ability.extra.lifetime_triggers, 10)
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
      ease_hands_played(-to_decrease)
    end
  end,
}
-- Samurott 503
local samurott = {
  name = "samurott",
  pos = { x = 9, y = 0 },
  config = { extra = { d_size = 1, Xmult_mod = 0.5, triggers_needed = 3, curr_count = 0 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local xmult = 1 + card.ability.extra.Xmult_mod * (G.GAME.current_round.hands_left or 0)
    return { vars = { card.ability.extra.d_size, card.ability.extra.triggers_needed, card.ability.extra.curr_count, card.ability.extra.Xmult_mod, xmult } }
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Water",
  atlas = "poke_Pokedex5",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if not blueprint and discard or the "before" hand is scored
    if not context.blueprint and ((context.pre_discard and not context.hook) or (context.cardarea == G.jokers and context.scoring_hand and context.before)) then
      card.ability.extra.curr_count = card.ability.extra.curr_count + 1
      if card.ability.extra.curr_count % card.ability.extra.triggers_needed == 0 then
        ease_hands_played(card.ability.extra.d_size)
        card:juice_up(0.1)
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xchips = 1 + card.ability.extra.Xmult_mod * (G.GAME.current_round.hands_left or 0)
        local chips = nil
        local msg = localize { type = 'variable', key = 'a_xchips', vars = { xchips } }
        -- if steammodded isn't updated
        if msg == "ERROR" then
          msg = "X" .. tostring(xchips) .. " Chips"
          chips = (xchips - 1) * hand_chips
          xchips = nil
        end
        return {
          message = msg,
          colour = G.C.CHIPS,
          Xchip_mod = xchips,
          chip_mod = chips
        }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.curr_count = 0
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
      ease_hands_played(-to_decrease)
    end
  end,
}

return {
  name = "PokermonPlus1",
  list = { snivy, servine, serperior, tepig, pignite, emboar, oshawott, dewott, samurott },
}
