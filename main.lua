SMODS.Atlas({
  key = "modicon",
  path = "icon.png",
  px = 32,
  py = 32
}):register()

SMODS.Atlas({
  key = "berries",
  px = 71,
  py = 95,
  path = "berries.png"
}):register()

SMODS.Atlas({
  key = "tags",
  path = "tags.png",
  px = 34,
  py = 34,
}):register()

SMODS.Atlas({
  key = "vouchers",
  path = "vouchers.png",
  px = 71,
  py = 95,
}):register()


mod_dir = '' .. SMODS.current_mod.path
pokermon_config = SMODS.Mods["Pokermon"].config


local helper, load_error = SMODS.load_file("functions/kekfunctions.lua")
if load_error then
  sendDebugMessage("The error is: " .. load_error)
else
  helper()
end

--Load consumable types
local pconsumable_types = NFS.getDirectoryItems(mod_dir .. "consumable types")

for _, file in ipairs(pconsumable_types) do
  sendDebugMessage("The file is: " .. file)
  local con_type, load_error = SMODS.load_file("consumable types/" .. file)
  if load_error then
    sendDebugMessage("The error is: " .. load_error)
  else
    local curr_type = con_type()
    if curr_type.init then curr_type:init() end

    for i, item in ipairs(curr_type.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.ConsumableType(item)
    end
  end
end

--Load consumables
local pconsumables = NFS.getDirectoryItems(mod_dir .. "consumables")

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pconsumables) do
    sendDebugMessage("The file is: " .. file)
    local consumable, load_error = SMODS.load_file("consumables/" .. file)
    if load_error then
      sendDebugMessage("The error is: " .. load_error)
    else
      local curr_consumable = consumable()
      if curr_consumable.init then curr_consumable:init() end

      for i, item in ipairs(curr_consumable.list) do
        SMODS.Consumable(item)
      end
    end
  end
end

--Load tags
local tags = NFS.getDirectoryItems(mod_dir .. "tags")

for _, file in ipairs(tags) do
  sendDebugMessage("The file is: " .. file)
  local tag, load_error = SMODS.load_file("tags/" .. file)
  if load_error then
    sendDebugMessage("The error is: " .. load_error)
  else
    local curr_tag = tag()
    if curr_tag.init then curr_tag:init() end

    for i, item in ipairs(curr_tag.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Tag(item)
    end
  end
end

--Load vouchers
local vouchers = NFS.getDirectoryItems(mod_dir .. "vouchers")

for _, file in ipairs(vouchers) do
  sendDebugMessage("The file is: " .. file)
  local voucher, load_error = SMODS.load_file("vouchers/" .. file)
  if load_error then
    sendDebugMessage("The error is: " .. load_error)
  else
    local curr_voucher = voucher()
    if curr_voucher.init then curr_voucher:init() end

    for i, item in ipairs(curr_voucher.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Voucher(item)
    end
  end
end

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir .. "pokemon")

for _, file in ipairs(pfiles) do
  sendDebugMessage("The file is: " .. file)
  local pokemon, load_error = SMODS.load_file("pokemon/" .. file)
  if load_error then
    sendDebugMessage("The error is: " .. load_error)
  else
    local curr_pokemon = pokemon()
    if curr_pokemon.init then curr_pokemon:init() end

    if curr_pokemon.list and #curr_pokemon.list > 0 then
      for i, item in ipairs(curr_pokemon.list) do
        item.discovered = true
        if not item.key then
          item.key = item.name
        end
        if not pokermon_config.no_evos and not item.custom_pool_func then
          item.in_pool = function(self)
            return pokemon_in_pool(self)
          end
        end
        if not item.config then
          item.config = {}
        end
        if item.ptype then
          if item.config and item.config.extra then
            item.config.extra.ptype = item.ptype
          elseif item.config then
            item.config.extra = { ptype = item.ptype }
          end
        end
        if item.item_req then
          if item.config and item.config.extra then
            item.config.extra.item_req = item.item_req
          elseif item.config then
            item.config.extra = { item_req = item.item_req }
          end
        end
        if item.evo_list then
          if item.config and item.config.extra then
            item.config.extra.evo_list = item.evo_list
          elseif item.config then
            item.config.extra = { item_req = item.evo_list }
          end
        end
        item.discovered = not pokermon_config.pokemon_discovery
        SMODS.Joker(item)
      end
    end
  end
end
