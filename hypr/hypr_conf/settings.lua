hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	scrolling = {
		fullscreen_on_one_column = true,
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		vrr = 2,
	},
})

----------------
---- INPUT -----
----------------

hl.config({
	input = {
		kb_layout = "br",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:escape",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		repeat_delay = 300,
		repeat_rate = 50,
		numlock_by_default = true,
		touchpad = {
			natural_scroll = false,
		},
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
