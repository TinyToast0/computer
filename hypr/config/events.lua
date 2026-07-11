--autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("waypaper --restore")
	hl.exec_cmd("wal -R ")
	hl.exec_cmd("/home/toast/.config/rofi/scripts/modeSelect.sh")
	hl.exec_cmd("rfkill unblock all")
	hl.exec_cmd("/home/toast/.cache/wal/noctalia.json /home/toast/.config/noctalia/colors.json")
end)
