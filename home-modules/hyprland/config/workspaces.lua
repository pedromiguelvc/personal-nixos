---@module 'hl'

-- Workspace-to-monitor rules, see https://wiki.hyprland.org/Configuring/Workspace-Rules/

local defs = require("definitions")

for _, workspace in ipairs(defs.mainWorkspaces) do
	hl.workspace_rule({
		workspace = workspace,
		monitor = defs.mainMonitor,
		persistent = true,
	})
end

for _, workspace in ipairs(defs.secondaryWorkspaces) do
	hl.workspace_rule({
		workspace = workspace,
		monitor = defs.secondaryMonitor,
		persistent = false,
	})
end
