local terminal = "kitty"
local switcher = "/home/toast/.config/dev/bash/scripts/themeSwitcher.sh"

local mainMod = "SUPER"

-- Universal keybinds
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal .. " fish"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + END", hl.dsp.exec_cmd("./.config/rofi/scripts/rofiPowerMenu.sh"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("~/.config/dev/bash/scripts/taskbarManagement.sh"))
hl.bind("ALT + TAB", hl.dsp.exec_cmd("rofi -show window -theme-str 'window {height: 30%;}' -monitor DP-1"))

hl.bind(mainMod .. "+ W", hl.dsp.exec_cmd("rofi -show drun -theme-str 'window {width: 25%;}' -monitor DP-1"))

hl.bind(mainMod .. "+ SHIFT + M", hl.dsp.exec_cmd("/home/toast/.config/rofi/scripts/audioSwitcher.sh"))

hl.bind(mainMod .. "+ SHIFT + W", hl.dsp.submap("wallpaper"))
hl.bind(mainMod .. "+ SHIFT + W", hl.dsp.exec_cmd("notify-send 'Wallpaper Submap'"))
hl.define_submap("wallpaper", function()
	hl.bind("q", hl.dsp.exec_cmd(switcher .. " 1"))
	hl.bind("w", hl.dsp.exec_cmd(switcher .. " 2"))
	hl.bind("e", hl.dsp.exec_cmd(switcher .. " 3"))
	hl.bind("r", hl.dsp.exec_cmd(switcher .. " 4"))
	hl.bind("t", hl.dsp.exec_cmd(switcher .. " 5"))
	hl.bind("escape", function()
		hl.dispatch(hl.dsp.submap("reset"))
		hl.dispatch(hl.dsp.exec_cmd("notify-send 'Exit'"))
	end)
end)

--player submap
hl.bind(mainMod .. "+ SHIFT + P", function()
	hl.dispatch(hl.dsp.exec_cmd("notify-send 'Player'"))
	hl.dispatch(hl.dsp.submap("player"))
end)
hl.define_submap("player", function()
	--player pause/play
	hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("playerctl --player=spotify play-pause"))
	--player next
	hl.bind(mainMod .. " + right", hl.dsp.exec_cmd("playerctl --player=spotify next"))
	--player previous
	hl.bind(mainMod .. " + left", hl.dsp.exec_cmd("playerctl --player=spotify previous"))

	-- Exit
	hl.bind("escape", function()
		hl.dispatch(hl.dsp.submap("reset"))
		hl.dispatch(hl.dsp.exec_cmd("notify-send 'Exit'"))
	end)
end)

--Toggle opacity
hl.window_rule({ match = { tag = "opacity1" }, opacity = "1.0 override" })
hl.bind("SUPER + P", hl.dsp.window.tag({ tag = "opacity1" }))

--Hints
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hints"))

--Move windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

----Dark Mode
--hl.bind(mainMod .. " + L", hl.dsp.dpms({ action = "toggle", monitor = "DP-1" }))
--hl.bind(mainMod .. " + SHIFT + L", hl.dsp.dpms({ action = "toggle", monitor = "DP-2" }))

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
hl.bind(mainMod .. "+ SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. "+ SHIFT + k", hl.dsp.window.move({ direction = "up" }))

--Window navigation
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))

--Resize windows
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + j", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + k", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

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
	-- Does not exist, so launch it
	hl.dispatch(hl.dsp.exec_cmd("steam"))
end)

-- Discord
hl.bind(mainMod .. " + SHIFT + D", function()
	local ws = hl.get_workspaces()
	for _, w in ipairs(ws) do
		if w.name == "special:discord" then
			hl.dispatch(hl.dsp.workspace.toggle_special("discord"))
			return
		end
	end
	-- Does not exist, so launch it
	hl.dispatch(hl.dsp.exec_cmd("discord"))
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
	-- Does not exist, so launch it
	hl.dispatch(hl.dsp.exec_cmd("spotify"))
end)

--hyprshot
hl.bind("print", hl.dsp.exec_cmd("hyprshot -o /home/toast/Pictures/HyprShot/ -m region"), { submap_universal = true })
hl.bind(
	mainMod .. " + print",
	hl.dsp.exec_cmd("hyprshot -o /home/toast/Pictures/HyprShot/ -m output -m active"),
	{ submap_universal = true }
)

--Swithing between workspaces
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { submap_universal = true })
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { submap_universal = true })
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
