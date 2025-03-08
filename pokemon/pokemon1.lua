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
        local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
        G.hand:change_size(-to_decrease)
        card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_reset') })
      end
      card.ability.extra.curr_count = 0
    end
    return scaling_evo(self, card, context, "j_poke_servine", card.ability.extra.lifetime_triggers, 4)
  end,
  add_to_deck = function(self, card, from_debuff)
    local to_increase = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
    if to_increase > 0 then
      G.hand:change_size(to_increase)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
    if to_decrease > 0 then
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
  add_to_deck = function(self, card, from_debuff)
    local to_increase = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
    if to_increase > 0 then
      G.hand:change_size(to_increase)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    local to_decrease = math.floor(card.ability.extra.curr_count / card.ability.extra.triggers_needed)
    if to_decrease > 0 then
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
  add_to_deck = function(self, card, from_debuff)
    if card.ability.extra.curr_count > 0 then
      G.hand:change_size(card.ability.extra.curr_count)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.curr_count)
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
}
local swinub = {
  name = "swinub",
  pos = {x = 8, y = 6},
  config = {extra = {odds = 5, chips = 50, mult = 5, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local curr_odds = ''..(G.GAME and G.GAME.probabilities.normal or 1)
    return {vars = {curr_odds, card.ability.extra.odds, card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Water",
  atlas = "Pokedex2",
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.other_card.debuff and not context.end_of_round and context.other_card.ability.name == 'Stone Card' then
      if pseudorandom('swinub') < G.GAME.probabilities.normal / card.ability.extra.odds then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Swine!"})
        return {
          colour = G.C.PURPLE,
          chips = card.ability.extra.chips,
          mult = card.ability.extra.mult,
          card = card
        }
      else
        local ret = {
          card = card
        }
        local chance = pseudorandom('swinub2')
        if chance < 1/2 then
          ret.colour = G.C.CHIPS
          ret.chips = card.ability.extra.chips
        else
          ret.colour = G.C.MULT
          ret.mult = card.ability.extra.mult
        end
        return ret
      end
    end
    return level_evo(self, card, context, "j_poke_piloswine")
  end,
}
-- Piloswine 221
local piloswine = {
  name = "piloswine",
  pos = {x = 9, y = 6},
  config = {extra = {odds = 4, chips = 100, mult = 10, Xmult = 1.2, stones_scored = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local curr_odds = ''..(G.GAME and G.GAME.probabilities.normal or 1)
    return {vars = {curr_odds, card.ability.extra.odds, card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.Xmult, card.ability.extra.stones_scored}}
  end,
  rarity = 3,
  cost = 7,
  stage = "One",
  ptype = "Water",
  atlas = "Pokedex2",
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.other_card.debuff and not context.end_of_round and context.other_card.ability.name == 'Stone Card' then
      card.ability.extra.stones_scored = card.ability.extra.stones_scored + 1
      if pseudorandom('piloswine') < G.GAME.probabilities.normal / card.ability.extra.odds then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Swine!"})
        return {
          colour = G.C.PURPLE,
          chips = card.ability.extra.chips,
          mult = card.ability.extra.mult,
          Xmult = card.ability.extra.Xmult,
          card = card
        }
      else
        local ret = {
          card = card
        }
        local chance = pseudorandom('piloswine2')
        if chance < 1/3 then
          ret.colour = G.C.CHIPS
          ret.chips = card.ability.extra.chips
        elseif chance < 2/3 then
          ret.colour = G.C.MULT
          ret.mult = card.ability.extra.mult
        else
          ret.colour = G.C.XMULT
          ret.Xmult = card.ability.extra.Xmult
        end
        return ret
      end
    end
    return scaling_evo(self, card, context, "j_poke_mamoswine", card.ability.extra.stones_scored, 15)
  end,
}
local mamoswine = {
  name = "mamoswine",
  pos = {x = 2, y = 6},
  config = {extra = {odds = 3, chips = 100, mult = 10, Xmult = 1.2, card = G.P_CARDS.H_A, already_rerolled = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local curr_odds = ''..(G.GAME and G.GAME.probabilities.normal or 1)

    return {vars = {curr_odds, card.ability.extra.odds, card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.Xmult,
                    localize(card.ability.extra.card.value or '2', 'ranks'), localize(card.ability.extra.card.suit, 'suits_plural'), 
                    colours = {G.C.SUITS[card.ability.extra.card.suit]}}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Earth",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      G.P_CENTERS.j_poke_mamoswine.config.extra.already_rerolled = false
    end
    if context.individual and context.cardarea == G.play and not context.other_card.debuff and not context.end_of_round and context.other_card.ability.name == 'Stone Card' then
      if pseudorandom('mamoswine') < G.GAME.probabilities.normal / card.ability.extra.odds then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Swine!"})
        return {
          colour = G.C.PURPLE,
          chips = card.ability.extra.chips,
          mult = card.ability.extra.mult,
          Xmult = card.ability.extra.Xmult,
          card = card
        }
      else
        local ret = {
          card = card
        }
        local chance = pseudorandom('mamoswine2')
        if chance < 1/3 then
          ret.colour = G.C.CHIPS
          ret.chips = card.ability.extra.chips
        elseif chance < 2/3 then
          ret.colour = G.C.MULT
          ret.mult = card.ability.extra.mult
        else
          ret.colour = G.C.XMULT
          ret.Xmult = card.ability.extra.Xmult
        end
        return ret
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local mamo_center = G.P_CENTERS.j_poke_mamoswine.config.extra
      -- probably not needed, but prevent duplicate rerolls from mamoswine
      if mamo_center.already_rerolled then
        card.ability.extra.card = mamo_center.card
      else
        card.ability.extra.card = pseudorandom_element(G.P_CARDS, pseudoseed('mamoswine'..G.GAME.round))
        mamo_center.card = card.ability.extra.card
        mamo_center.already_rerolled = true
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reroll')})
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial and #find_joker('mamoswine') == 0 then
      local mamo_center = G.P_CENTERS.j_poke_mamoswine.config.extra
      card.ability.extra.card = pseudorandom_element(G.P_CARDS, pseudoseed('mamoswine'..G.GAME.round))
      mamo_center.card = card.ability.extra.card
    end
  end
}

return {
  name = "PokermonPlus1",
  list = { snivy, servine, serperior, tepig, pignite, emboar, oshawott, dewott, samurott, swinub, piloswine, mamoswine },
}
