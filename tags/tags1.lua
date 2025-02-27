local mult_tag = {
	object_type = "Tag",
	atlas = "tags",
	name = "mult_tag",
	order = 27,
	pos = { x = 0, y = 0 },
	config = { type = "nil", mult = 10 },
	key = "mult_tag",
	min_ante = 999,
	discovered = true,
	loc_vars = function(self, info_queue)
		return { vars = { self.config.mult } }
	end,
	apply = function(self, tag, context)
		create_calculations_voucher()
	end,
	in_pool = function(self)
		return false
	end,
}

local chips_tag = {
	object_type = "Tag",
	atlas = "tags",
	name = "chips_tag",
	order = 27,
	pos = { x = 1, y = 0 },
	config = { type = "nil", chips = 50 },
	key = "chips_tag",
	min_ante = 999,
	discovered = true,
	loc_vars = function(self, info_queue)
		return { vars = { self.config.chips } }
	end,
	apply = function(self, tag, context)
		create_calculations_voucher()
	end,
	in_pool = function(self)
		return false
	end,
}

local xmult_tag = {
	object_type = "Tag",
	atlas = "tags",
	name = "xmult_tag",
	order = 27,
	pos = { x = 2, y = 0 },
	config = { type = "nil", Xmult = 1.5 },
	key = "xmult_tag",
	min_ante = 999,
	discovered = true,
	loc_vars = function(self, info_queue)
		return { vars = { self.config.Xmult } }
	end,
	apply = function(self, tag, context)
		create_calculations_voucher()
	end,
	in_pool = function(self)
		return false
	end,
}

local xchips_tag = {
	object_type = "Tag",
	atlas = "tags",
	name = "xchips_tag",
	order = 27,
	pos = { x = 3, y = 0 },
	config = { type = "nil", Xchips = 1.5 },
	key = "xchips_tag",
	min_ante = 999,
	discovered = true,
	loc_vars = function(self, info_queue)
		return { vars = { self.config.Xchips } }
	end,
	apply = function(self, tag, context)
		create_calculations_voucher()
	end,
	in_pool = function(self)
		return false
	end,
}

return {
	name = "Tags",
	list = { mult_tag, chips_tag, xmult_tag, xchips_tag }
}
