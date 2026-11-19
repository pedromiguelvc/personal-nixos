---@module 'hl'

-- Shared variables for the whole Hyprland config.
-- Every other module reads its values from here via require("definitions").

local M = {}

---------------
-- Apps
---------------

M.terminal = "kitty"
M.fileManager = "thunar"
M.browser = "flatpak run com.brave.Browser"
M.powerManager = "wlogout"
M.menu = "vicinae toggle"

---------------
-- Monitors
---------------

M.mainMonitor = "eDP-1"
M.secondaryMonitor = "HDMI-A-1"

---------------
-- Workspaces
---------------

-- Workspaces 1-5 live on the main monitor, 6-10 on the secondary one
M.mainWorkspaces = { 1, 2, 3, 4, 5 }
M.secondaryWorkspaces = { 6, 7, 8, 9, 10 }

-- Workspaces that autostarted apps are sent to
M.browserWorkspace = 1
M.terminalWorkspace = 2

---------------
-- Keybinding helpers
---------------

M.mainMod = "SUPER"
M.mainModShift = "SUPER + SHIFT"

-- Build "SUPER + key" and "SUPER + SHIFT + key"
function M.mod(key)
	return M.mainMod .. " + " .. key
end

function M.modShift(key)
	return M.mainModShift .. " + " .. key
end

-- Launch apps
M.apps = {
	{ key = "T", cmd = M.terminal },
	{ key = "B", cmd = M.browser },
	{ key = "Return", cmd = M.menu },
	{ key = "M", cmd = M.powerManager },
}

-- Move focus with mainMod + H/J/K/L
M.focusDirections = {
	{ key = "H", direction = "left" },
	{ key = "L", direction = "right" },
	{ key = "K", direction = "up" },
	{ key = "J", direction = "down" },
}

-- Laptop multimedia keys for volume, LCD brightness and playback.
-- All of these work while locked, hence { locked = true } in binds.lua.
M.mediaBinds = {
	{ key = "XF86AudioRaiseVolume", cmd = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+" },
	{ key = "XF86AudioLowerVolume", cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" },
	{ key = "XF86AudioMute", cmd = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" },
	{ key = "XF86AudioMicMute", cmd = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" },
	{ key = "XF86MonBrightnessUp", cmd = "brightnessctl s 5%+" },
	-- Brightness down never goes below 5% of the maximum
	{
		key = "XF86MonBrightnessDown",
		cmd = [[bash -c 'val=$(brightnessctl g); max=$(brightnessctl m); step=$((max/20)); min=$step; new=$((val-step)); [ $new -lt $min ] && new=$min; brightnessctl s $new']],
	},
	-- Requires playerctl
	{ key = "XF86AudioNext", cmd = "playerctl next" },
	{ key = "XF86AudioPause", cmd = "playerctl play-pause" },
	{ key = "XF86AudioPlay", cmd = "playerctl play-pause" },
	{ key = "XF86AudioPrev", cmd = "playerctl previous" },
}

return M
