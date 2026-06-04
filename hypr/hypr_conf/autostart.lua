hl.on("hyprland.start", function()
	local home = os.getenv("HOME")
	hl.exec_cmd("waybar & hyprpaper & hyprsunset & hypridle & dunst & xdg-user-dirs-update")
	hl.exec_cmd("kbuildsycoca6")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("wl-paste --type text --watch cliphist store & wl-paste --type text --watch cliphist store")
	hl.exec_cmd(home .. "/dotfiles/hypr/scripts/hypr_power_save.sh")
end)

