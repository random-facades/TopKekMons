local calculations = {
   key = "calculations",
   atlas = "vouchers",
   order = 35,
   set = "Voucher",
   pos = { x = 0, y = 0 },
   config = {},
   discovered = true,
   unlocked = true,
   available = true,
   cost = 999,
   loc_vars = function(self, info_queue)
      return { vars = {} }
   end,
   calculate = function(self, card, context)
      if context.final_scoring_step then
         local ret = {}
         for _, tag in pairs(G.GAME.tags) do
            if tag.key == "tag_kek_xmult_tag" then
               tag:yep("X", G.C.MULT, function() return true end)
               ret.Xmult_mod = tag.config.Xmult
            elseif tag.key == "tag_kek_mult_tag" then
               tag:yep("+", G.C.MULT, function() return true end)
               ret.mult_mod = tag.config.mult
            elseif tag.key == "tag_kek_xchips_tag" then
               tag:yep("X", G.C.CHIPS, function() return true end)
               ret.Xchip_mod = tag.config.xchips
            elseif tag.key == "tag_kek_chips_tag" then
               tag:yep("+", G.C.CHIPS, function() return true end)
               ret.chip_mod = tag.config.chips
            end
         end
         return ret
      end
   end,
   in_pool = function(self)
      return false
   end
}

return {
   name = "Vouchers",
   list = { calculations }
}
