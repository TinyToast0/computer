--Floating terminal command
hl.window_rule({
	name = "floating_terminal",
	match = {
		class = "floating_terminal",
	},
	float = true,
	size = { 1000, 600 },
})

--Move workspaces
hl.window_rule({
	name = "steam-move",
	match = {
		class = "steam",
	},
	workspace = "special:steam",
})

hl.window_rule({
	name = "music-move",
	match = {
		class = "Spotify",
	},
	workspace = "special:music",
})

--Toggle opacity
hl.window_rule({ match = { tag = "opacity1" }, opacity = "1.0 override" })
hl.bind("SUPER + I", hl.dsp.window.tag({ tag = "opacity1" }))

hl.window_rule({
	name = "hide-private-tagged",
	match = {
		class = "wofi",
		title = "I CAN'T HEAR RIGHT!",
	},
	opaque = true,
	border_size = 0,
	monitor = "DP-2",
	move = "1630 900",
	animation = "slide",
})

hl.window_rule({
	name = "shell-move",
	match = {
		class = "unique_kitty",
	},
	workspace = "special:shell",
})

--Toggle opacity
hl.window_rule({ match = { tag = "opacity1" }, opacity = "1.0 override" })
hl.bind("SUPER + I", hl.dsp.window.tag({ tag = "opacity1" }))

--window opacity

hl.window_rule({
	name = "Steam Opacity",
	match = {
		class = "steam",
	},
	opacity = "0.8 override 0.8 override 0.8 override",
})

hl.window_rule({
	name = "Spotify Opacity",
	match = {
		class = "Spotify",
	},
	opacity = "0.6 override 0.6 override 0.6 override",
})

--layer Rule

hl.layer_rule({
	match = { namespace = "notifications" },
	animation = "slide",
	no_screen_share = true,
})
