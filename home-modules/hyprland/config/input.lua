---@module 'hl'

-- Keyboard, mouse and touchpad input

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "intl",
		kb_options = "",
		kb_model = "",
		kb_rules = "",
		repeat_delay = 200,
		repeat_rate = 50,
		follow_mouse = 2,
		float_switch_override_focus = 0,
		sensitivity = 0,
		swallow_focus_click = true,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
		},
	},
})
