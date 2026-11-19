---@module 'hl'

-- Display setup

local defs = require("definitions")

hl.monitor({
	output = defs.mainMonitor,
	mode = "1920x1080@60.00",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = defs.secondaryMonitor,
	mode = "preferred",
	position = "auto-center-up",
	scale = 1,
})
