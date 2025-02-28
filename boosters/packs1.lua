local starter_pack = {
  name = "Starter Pack",
  key = "starter_pack",
  kind = "Starter",
  atlas = "pokepack",
  pos = { x = 0, y = 0 },
  config = { extra = 3, choose = 1, c_keys = {} },
  cost = 8,
  order = 1,
  weight = 1,
  draw_hand = false,
  unlocked = true,
  discovered = true,
  create_card = function(self, card, i)
    local grass = { bulbasaur = true, chikorita = true, treecko = true, turtwig = true, snivy = true, chespin = true, rowlet = true, grookey = true, sprigatito = true }
    local fire = { charmander = true, cyndaquil = true, torchic = true, chimchar = true, tepig = true, fennekin = true, litten = true, scorbunny = true, fuecoco = true }
    local water = { squirtle = true, totodile = true, mudkip = true, piplup = true, oshawott = true, froakie = true, popplio = true, sobble = true, quaxly = true }
    local extras = { pikachu = true, eevee = true }

    local poke_key = "j_poke_pikachu"
    if i >= 1 and i <= 3 then
      local starter_pick = grass
      if i == 2 then
        starter_pick = fire
      elseif i == 3 then
        starter_pick = water
      end
      local centers = {}
      for k, v in pairs(G.P_CENTERS) do
        if v.name and starter_pick[v.name] then
          table.insert(centers, v.key)
        end
      end

      if #centers > 0 then
        poke_key = pseudorandom_element(centers, pseudoseed('starter_pack'))
      end
    else
      local centers = {}
      for k, v in pairs(G.P_CENTERS) do
        if v.name and not self.config.c_keys[v.key] and (grass[v.name] or fire[v.name] or water[v.name] or extras[v.name]) then
          table.insert(centers, v.key)
        end
      end

      if #centers <= 1 then
        self.config.c_keys = {}
        poke_key = centers[1] or poke_key
      else
        poke_key = pseudorandom_element(centers, pseudoseed('starter_pack'))
      end
    end
    self.config.c_keys[poke_key] = true
    if i == self.config.extra + (G.GAME.extra_pocket_picks or 0) then self.config.c_keys = {} end
    return SMODS.create_card({ set = "Joker", area = G.pack_cards, key = poke_key })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = {} }
  end,
  in_pool = function(self)
    return false
  end,
  group_key = "k_poke_starter_pack",
}


return {
  name = "Pocket Packs",
  list = { starter_pack }
}
