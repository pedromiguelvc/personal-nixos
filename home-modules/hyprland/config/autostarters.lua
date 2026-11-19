---@module 'hl'

local defs = require("definitions")

hl.on("hyprland.start", function()
	hl.exec_cmd("[workspace " .. defs.browserWorkspace .. " silent] " .. defs.browser)
	hl.exec_cmd("[workspace " .. defs.terminalWorkspace .. " silent] " .. defs.terminal)
end)
