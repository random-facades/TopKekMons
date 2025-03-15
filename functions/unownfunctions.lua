SMODS.Atlas {
   key = "Unown",
   path = "Unown.png",
   px = 71,
   py = 95
}

SMODS.Atlas {
   key = "Unown_hc",
   path = "Unown.png",
   px = 71,
   py = 95
}

SMODS.Atlas {
   key = "pokeui_assets",
   path = "pokeui_assets.png",
   px = 18,
   py = 18
}

SMODS.Atlas {
   key = "pokeui_assets_hc",
   path = "pokeui_assets.png",
   px = 18,
   py = 18
}


local letters = { 'Z?', 'Z!', 'Z', 'Y', 'X', 'W', 'V', 'U', 'T', 'S', 'R', 'Q', 'P', 'O', 'N', 'M', 'L', 'K', 'J', 'I',
   'H', 'G', 'F', 'E', 'D', 'C', 'B', 'A' }
local letter_ranks = {}

function force_link(rank, next)
   table.insert(SMODS.Ranks[rank].next, next)
   table.insert(SMODS.Ranks[next].prev, rank)
end

function is_punctuation(card, hand)
   local found = nil
   for i, value in ipairs(hand) do
      if value == card then
         found = i
      elseif found then
         if not hand[i].base or (hand[i].base.value ~= 'poke_UZ!' and hand[i].base.value ~= 'poke_UZ?') then
            return false
         end
      end
   end
   return found ~= nil
end

function calculate_Unown_playing_card(card, context)
   if context.main_scoring and context.full_hand then
      if #context.full_hand == 5 and card == context.full_hand[3] then
         -- check for words
         local is_word = true
         local word = ''
         for k, v in pairs(context.full_hand) do
            if not v.base or v.base.suit ~= 'poke_Unown' then
               is_word = false
               break
            end
            word = word .. string.sub(v.base.value, -1)
         end
         if is_word then
            if word == 'UNOWN' then
               G.E_MANAGER:add_event(Event({
                  func = function()
                     play_sound('timpani')
                     local _card = SMODS.create_card({ set = 'Joker', key = 'j_poke_awakened_unown' })
                     _card:add_to_deck()
                     G.jokers:emplace(_card)
                     return true
                  end
               }))
            elseif word == 'JOKER' then
               G.E_MANAGER:add_event(Event({
                  func = function()
                     play_sound('timpani')
                     local _card = create_random_poke_joker("pokeball", "Basic")
                     _card:add_to_deck()
                     G.jokers:emplace(_card)
                     return true
                  end
               }))
            end
         end
      end
      if card.base.value == 'poke_UZ!' and is_punctuation(card, context.full_hand) then
         return {
            message = localize { type = 'variable', key = 'a_mult', vars = { 20 } },
            colour = G.C.MULT,
            mult_mod = 20,
         }
      end
      if card.base.value == 'poke_UZ?' and is_punctuation(card, context.full_hand) then
         return {
            message = localize { type = 'variable', key = 'a_chips', vars = { 100 } },
            colour = G.C.CHIPS,
            chip_mod = 100
         }
      end
   end
end

SMODS.Suit {
   key = 'Unown',
   card_key = 'Unown',
   hidden = true,
   pos = { x = 0, y = 0 },
   ui_pos = { x = 0, y = 0 },
   keep_base_colours = false,
   lc_color = "374244",
   hc_color = "374244",
   lc_atlas = 'Unown',
   hc_atlas = 'Unown_hc',
   lc_ui_atlas = 'pokeui_assets',
   hc_ui_atlas = 'pokeui_assets_hc',
   in_pool = function(self, args)
      if args and (args.initial_deck or args.rank == '') then
         return false
      end
      return true
   end,
}

for i, letter in pairs(letters) do
   letter_ranks[letter] = SMODS.Rank {
      key = 'U' .. letter,
      card_key = 'U' .. letter,
      pos = { x = 28 - i },
      nominal = 20,
      next = i ~= 1 and { 'poke_U' .. letters[i - 1] } or nil,
      Unown = true,
      shorthand = '' .. string.sub(letter, -1),
      in_pool = function(self, args)
         if args and (args.initial_deck or args.suit ~= 'poke_Unown') then
            return false
         end
         if G.GAME.possible_Unown == nil then
            G.GAME.possible_Unown = letter_ranks[pseudorandom_element(letters, pseudoseed('unown_rank'))].key
         end
         return G.GAME and G.GAME.Unown or G.GAME.possible_Unown == self.key
      end,
   }
end

letter_ranks.J.id = 11
letter_ranks.Q.id = 12
letter_ranks.K.id = 13
letter_ranks.A.id = 14
letter_ranks.A.straight_edge = true
force_link('10', 'poke_UJ')    -- Mixed Straight (7 8 9 10 J)
force_link('Jack', 'poke_UQ')  -- Mixed Straight (8 9 10 Jack Q)
force_link('Queen', 'poke_UK') -- Mixed Straight (9 10 Jack Queen K)
force_link('King', 'poke_UA')  -- Mixed Straight (10 Jack Queen King A)

force_link('poke_UJ', 'Queen')
force_link('poke_UQ', 'King')
force_link('poke_UK', 'Ace')
force_link('poke_UA', '2')

force_link('poke_UJ', 'poke_UQ')
force_link('poke_UQ', 'poke_UK')
force_link('poke_UK', 'poke_UA')

local prev_inject_p_card = SMODS.inject_p_card
SMODS.inject_p_card = function(suit, rank)
   G.SETTINGS.colour_palettes.poke_Unown = 'lc'
   if suit.card_key == 'poke_Unown' or rank.Unown then
      if suit.card_key == 'poke_Unown' and rank.Unown then
         G.P_CARDS[suit.card_key .. '_' .. rank.card_key] = {
            name = rank.key .. ' of ' .. suit.key,
            value = rank.key,
            suit = suit.key,
            pos = { x = rank.pos.x % 10, y = math.floor(rank.pos.x / 10) },
            atlas = 'poke_Unown',
            lc_atlas = 'poke_Unown',
            hc_atlas = 'poke_Unown_hc',
            lc_ui_atlas = 'poke_pokeui_assets',
            hc_ui_atlas = 'poke_pokeui_assets_hc',
         }
      end
   else
      prev_inject_p_card(suit, rank)
   end
end

local prev_change_base = SMODS.change_base
function SMODS.change_base(card, suit, rank)
   local _suit = suit or card.base.suit
   local _rank = rank or card.base.value
   if (_suit == 'poke_Unown') == (SMODS.Ranks[_rank].Unown == true) then
      return prev_change_base(card, _suit, _rank)
   end
   if _rank == "King" then
      _rank = "poke_UK"
   elseif _rank == "Queen" then
      _rank = "poke_UQ"
   elseif _rank == "Jack" then
      _rank = "poke_UJ"
   elseif _rank == "Ace" then
      _rank = "poke_UA"
   end
   if not SMODS.Ranks[_rank].Unown then
      _rank = letter_ranks[pseudorandom_element(letters, pseudoseed('unown_rank'))].key
   end
   return prev_change_base(card, 'poke_Unown', _rank)
end

local prev_Card_set_base = Card.set_base
Card.set_base = function(self, card, initial)
   card = card or self.config.card
   prev_Card_set_base(self, card, initial)
end
