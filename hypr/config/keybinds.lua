local terminal = "kitty"
local switcher = "/home/toast/.config/dev/bash/scripts/themeSwitcher.sh"

local mainMod = "SUPER"

-- Universal keybinds
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal .. " fish"), { submap_universal = true })
hl.bind(mainMod .. " + C", hl.dsp.window.close(), { submap_universal = true })
hl.bind(mainMod .. " + END", hl.dsp.exec_cmd("./.config/rofi/scripts/rofiPowerMenu.sh"), { submap_universal = true })
hl.bind(
	"ALT + TAB",
	hl.dsp.exec_cmd("rofi -show window -theme-str 'window {height: 30%;}' -monitor DP-1"),
	{ submap_universal = true }
)

--NOTE: Colemak Submap
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.submap("colemak"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("echo '' | notify 'Mode set to Colemak' "))
hl.define_submap("colemak", function()
	--basic Keybinds
	hl.bind(mainMod .. "+ W", hl.dsp.exec_cmd("rofi -show drun -theme-str 'window {width: 25%;}' -monitor DP-1"))

	--Toggle opacity
	hl.window_rule({ match = { tag = "opacity1" }, opacity = "1.0 override" })
	hl.bind("SUPER + Y", hl.dsp.window.tag({ tag = "opacity1" }))

	-- Switch to regular
	hl.bind(mainMod .. " + B", hl.dsp.submap("regular"))
	hl.bind(mainMod .. " + B", function()
		hl.config({
			input = {
				kb_layout = "gb",
				kb_variant = "",
				kb_model = "",
				kb_options = "",
				kb_rules = "",

				follow_mouse = 1,

				sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

				touchpad = {
					natural_scroll = false,
				},
			},
		})
	end)

	--Hints
	hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("hints"))

	--Move windows with mouse
	hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

	--Dark Mode
	hl.bind(mainMod .. " + L", hl.dsp.dpms({ action = "toggle", monitor = "DP-1" }))
	hl.bind(mainMod .. " + SHIFT + L", hl.dsp.dpms({ action = "toggle", monitor = "DP-2" }))

	--Toggle Private
	hl.bind(mainMod .. " + U", function()
		local w = hl.get_active_window()
		if not w then
			return
		end
		local wt = w.tags
		local function hasPrivate(tags)
			for _, t in ipairs(tags) do
				if t == "private" then
					return true
				end
			end
			return false
		end

		if hasPrivate(wt) then
			hl.dispatch(hl.dsp.window.tag({ tag = "-private" }))
			hl.dispatch(hl.dsp.window.set_prop({ prop = "no_screen_share", value = "off" }))
		else
			hl.dispatch(hl.dsp.window.tag({ tag = "+private" }))
			hl.dispatch(hl.dsp.window.set_prop({ prop = "no_screen_share", value = "on" }))
		end
	end)

	--Window moving
	hl.bind(mainMod .. "+ SHIFT + i", hl.dsp.window.move({ direction = "right" }))
	hl.bind(mainMod .. "+ SHIFT + h", hl.dsp.window.move({ direction = "left" }))
	hl.bind(mainMod .. "+ SHIFT + n", hl.dsp.window.move({ direction = "down" }))
	hl.bind(mainMod .. "+ SHIFT + e", hl.dsp.window.move({ direction = "up" }))

	--Window navigation
	hl.bind(mainMod .. " + i", hl.dsp.focus({ direction = "right" }))
	hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
	hl.bind(mainMod .. " + n", hl.dsp.focus({ direction = "down" }))
	hl.bind(mainMod .. " + e", hl.dsp.focus({ direction = "up" }))

	--Resize windows
	hl.bind(
		mainMod .. " + CONTROL + H",
		hl.dsp.window.resize({ x = -20, y = 0, relative = true }),
		{ repeating = true }
	)
	hl.bind(mainMod .. " + CONTROL + i", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
	hl.bind(
		mainMod .. " + CONTROL + N",
		hl.dsp.window.resize({ x = 0, y = -20, relative = true }),
		{ repeating = true }
	)
	hl.bind(mainMod .. " + CONTROL + E", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

	-- Special Workspaces
	hl.bind(mainMod .. " + SHIFT + X", function()
		local ws = hl.get_workspaces()
		for _, w in ipairs(ws) do
			if w.name == "special:shell" then
				hl.dispatch(hl.dsp.workspace.toggle_special("shell"))
				return
			end
		end
		-- Does not exist, so launch it
		hl.dispatch(hl.dsp.exec_cmd(terminal .. "  --class unique_kitty" .. " fish"))
	end)

	-- Steam
	hl.bind(mainMod .. " + SHIFT + A", function()
		local ws = hl.get_workspaces()
		for _, w in ipairs(ws) do
			if w.name == "special:steam" then
				hl.dispatch(hl.dsp.workspace.toggle_special("steam"))
				return
			end
		end
	end)

	-- Spotify
	hl.bind(mainMod .. " + SHIFT + C", function()
		local ws = hl.get_workspaces()
		for _, w in ipairs(ws) do
			if w.name == "special:music" then
				hl.dispatch(hl.dsp.workspace.toggle_special("music"))
				return
			end
		end
	end)

	-- colemak submap end
end)

--NOTE: Escape submap
hl.bind(mainMod .. " + escape", hl.dsp.submap("escape"), { submap_universal = true })
hl.bind(
	mainMod .. " + escape",
	hl.dsp.exec_cmd("echo '' | notify 'WARNING: Emergancy mode active.' "),
	{ submap_universal = true }
)
hl.define_submap("escape", function()
	hl.bind(mainMod .. " + SHIFT + R", hl.dsp.submap("regular"))
	hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("echo '' | notify 'Mode set to Regular.'"))
	hl.bind(mainMod .. " + SHIFT + C", hl.dsp.submap("colemak"))
	hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("echo '' | notify 'Mode set to Colemak.'"))
	hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
	hl.bind(mainMod .. "+ W", hl.dsp.exec_cmd("rofi -show drun -theme-str 'window {width: 25%;}' -monitor DP-1"))
	hl.bind(mainMod .. "+ M", hl.dsp.exec_cmd("/home/toast/.config/rofi/scripts/modeSelect.sh"))
end)

--NOTE: Regular submap
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.submap("regular"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("echo '' | notify 'Mode set to Regular' "))
hl.define_submap("regular", function()
	-- Switch to Colemak
	hl.bind(mainMod .. " + B", hl.dsp.submap("colemak"))
	hl.bind(mainMod .. " + B", function()
		hl.config({
			input = {
				kb_layout = "gb",
				kb_variant = "colemak",
				kb_model = "",
				kb_options = "caps:swap:backspace",
				kb_rules = "",

				follow_mouse = 1,

				sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

				touchpad = {
					natural_scroll = false,
				},
			},
		})
	end)
	hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
	hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun -theme-str 'window {width: 25%;}' -monitor DP-1"))
	hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
	hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
	hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
	hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
	hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hints"))
	hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/Apps/cool-retro-term-2.0.0-beta2.AppImage"))
	--Shifting windows
	hl.bind(mainMod .. " + SHIFT + H ", hl.dsp.window.move({ direction = "left" }))
	hl.bind(mainMod .. " + SHIFT + L ", hl.dsp.window.move({ direction = "right" }))
	hl.bind(mainMod .. " + SHIFT + J ", hl.dsp.window.move({ direction = "down" }))
	hl.bind(mainMod .. " + SHIFT + K ", hl.dsp.window.move({ direction = "up" }))

	--Resize windows
	hl.bind(
		mainMod .. " + CONTROL + H",
		hl.dsp.window.resize({ x = -20, y = 0, relative = true }),
		{ repeating = true }
	)
	hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
	hl.bind(
		mainMod .. " + CONTROL + J",
		hl.dsp.window.resize({ x = 0, y = -20, relative = true }),
		{ repeating = true }
	)
	hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

	--Move mouse cursor with keyboard
	hl.bind(mainMod .. " + left", hl.dsp.exec_cmd("wlrctl pointer move -20 0"), { repeating = true })
	hl.bind(mainMod .. " + right", hl.dsp.exec_cmd("wlrctl pointer move 20 0"), { repeating = true })
	hl.bind(mainMod .. " + up", hl.dsp.exec_cmd("wlrctl pointer move 0 -20"), { repeating = true })
	hl.bind(mainMod .. " + down", hl.dsp.exec_cmd("wlrctl pointer move 0 20"), { repeating = true })
	--Larger Jumps
	hl.bind(mainMod .. " + SHIFT + left", hl.dsp.exec_cmd("wlrctl pointer move -100 0"), { repeating = true })
	hl.bind(mainMod .. " + SHIFT + right", hl.dsp.exec_cmd("wlrctl pointer move 100 0"), { repeating = true })
	hl.bind(mainMod .. " + SHIFT + up", hl.dsp.exec_cmd("wlrctl pointer move 0 -100"), { repeating = true })
	hl.bind(mainMod .. " + SHIFT + down", hl.dsp.exec_cmd("wlrctl pointer move 0 100"), { repeating = true })

	--Toggle opacity
	hl.window_rule({ match = { tag = "opacity1" }, opacity = "1.0 override" })
	hl.bind("SUPER + I", hl.dsp.window.tag({ tag = "opacity1" }))

	--Open floating terminal
	hl.bind(mainMod .. " + T", function()
		hl.dispatch(hl.dsp.exec_cmd(terminal .. " --class floating_terminal" .. " fish"))
	end)

	--Toggle Private
	hl.bind(mainMod .. " + N", function()
		local w = hl.get_active_window()
		if not w then
			return
		end
		local wt = w.tags
		local function hasPrivate(tags)
			for _, t in ipairs(tags) do
				if t == "private" then
					return true
				end
			end
			return false
		end

		if hasPrivate(wt) then
			hl.dispatch(hl.dsp.window.tag({ tag = "-private" }))
			hl.dispatch(hl.dsp.window.set_prop({ prop = "no_screen_share", value = "off" }))
		else
			hl.dispatch(hl.dsp.window.tag({ tag = "+private" }))
			hl.dispatch(hl.dsp.window.set_prop({ prop = "no_screen_share", value = "on" }))
		end
	end)

	-- Special Workspaces
	hl.bind(mainMod .. " + SHIFT + X", function()
		local ws = hl.get_workspaces()
		for _, w in ipairs(ws) do
			if w.name == "special:shell" then
				hl.dispatch(hl.dsp.workspace.toggle_special("shell"))
				return
			end
		end
		-- Does not exist, so launch it
		hl.dispatch(hl.dsp.exec_cmd(terminal .. "  --class unique_kitty" .. " fish"))
	end)
	-- Steam
	hl.bind(mainMod .. " + SHIFT + S", function()
		local ws = hl.get_workspaces()
		for _, w in ipairs(ws) do
			if w.name == "special:steam" then
				hl.dispatch(hl.dsp.workspace.toggle_special("steam"))
				return
			end
		end
	end)
	-- Spotify
	hl.bind(mainMod .. " + SHIFT + C", function()
		local ws = hl.get_workspaces()
		for _, w in ipairs(ws) do
			if w.name == "special:music" then
				hl.dispatch(hl.dsp.workspace.toggle_special("music"))
				return
			end
		end
	end)

	--reload waybar
	hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("/home/toast/.config/dev/bash/scripts/taskbarManagement.sh"))

	--Regular submap end
end)

--Wallpaper Switch
hl.bind(
	mainMod .. " + F1",
	hl.dsp.exec_cmd("~/.config/dev/bash/scripts/minecraftThemes.sh"),
	{ submap_universal = true }
)
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(switcher .. " 1"), { submap_universal = true })
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd(switcher .. " 2"), { submap_universal = true })
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd(switcher .. " 3"), { submap_universal = true })
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd(switcher .. " 4"), { submap_universal = true })
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd(switcher .. " 5"), { submap_universal = true })
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd(switcher .. " 7"), { submap_universal = true })
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd(switcher .. " 8"), { submap_universal = true })
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd(switcher .. " 9"), { submap_universal = true })
--Kill Waypaper
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("pkill mpvpaper"), { submap_universal = true })

--hyprshot
hl.bind("print", hl.dsp.exec_cmd("hyprshot -m region"), { submap_universal = true })
hl.bind(mainMod .. " + print", hl.dsp.exec_cmd("hyprshot -m output -m active"), { submap_universal = true })

--Swithing between workspaces
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { submap_universal = true })
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { submap_universal = true })
end

for i = 11, 20 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.focus({ workspace = i }), { submap_universal = true })
	hl.bind(mainMod .. " + SHIFT + ALT + " .. key, hl.dsp.window.move({ workspace = i }), { submap_universal = true })
end

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true, submap_universal = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true, submap_universal = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true, submap_universal = true }
)
