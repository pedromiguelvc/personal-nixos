---@module 'hl'

-- Window rules, see https://wiki.hyprland.org/Configuring/Window-Rules/

-- Core behavior
hl.window_rule({
	name = "suppressevent_maximi",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

-- Optional XWayland fix (only if needed)
hl.window_rule({
	name = "nofocus",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Dialogs and portals
hl.window_rule({
	name = "float_dialogs",
	match = {
		title = "^(Open|Save|Save As|Choose File|File Upload)$",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "float_portal",
	match = {
		class = "^(xdg-desktop-portal-gtk)$",
	},
	float = true,
	size = "800 600",
	center = true,
})

-- System apps
hl.window_rule({
	name = "float_system",
	match = {
		class = "^(pavucontrol|blueman-manager|nm-connection-editor|atril)$",
	},
	float = true,
	size = "800 600",
})

hl.window_rule({
	name = "center_sytem",
	match = {
		class = "^(pavucontrol|blueman-manager|nm-connection-editor)$",
	},
	center = true,
})
