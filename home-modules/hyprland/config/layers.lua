---@module 'hl'

-- Layer rules (bars, launchers, overlays), see https://wiki.hyprland.org/Configuring/Window-Rules/

hl.layer_rule({
	match = {
		namespace = "vicinae",
	},
	blur = true,
	animation = "popin",
})
