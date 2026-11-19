---@module 'hl'

-- Layout, gaps, tiling behaviour and cursor

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 0,
		resize_on_border = true,
		layout = "master",
		allow_tearing = false,
	},

	master = {
		new_status = "slave",
		smart_resizing = false,
		mfact = 0.5,
	},

	dwindle = {
		preserve_split = true,
	},

	cursor = {
		no_warps = true,
	},

	misc = {
		mouse_move_focuses_monitor = false,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},

	debug = {
		vfr = true,
		disable_logs = false,
	},
})
