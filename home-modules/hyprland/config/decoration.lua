---@module 'hl'

-- Window look: rounding, opacity, shadow, blur and group bar

hl.config({
	decoration = {
		rounding = 5,
		active_opacity = 1.0,
		inactive_opacity = 0.85,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 6,
			passes = 3,
			vibrancy = 0.1696,
			new_optimizations = true,
		},
	},

	group = {
		groupbar = {
			font_size = 15,
			gradients = false,
			text_color = "rgba(ffffffff)",
			col = {
				active = "rgba(33ccffee)",
				inactive = "rgba(595959aa)",
			},
		},
	},
})
