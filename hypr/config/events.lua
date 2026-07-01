--autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("waypaper --restore")
	hl.exec_cmd("wal -R ")
end)
