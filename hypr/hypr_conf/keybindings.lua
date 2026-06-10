local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local browser = "firefox"

-- ======================================================
-- Applications
-- ======================================================

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))

-- Calculator
hl.bind("XF86Calculator", hl.dsp.exec_cmd("kalk"))

-- Logout / shutdown
--hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh"))
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)

-- ======================================================
-- Window management
-- ======================================================

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Z", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + ALT_L", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

-- ======================================================
-- Clipboard
-- ======================================================

hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")
)

-- ======================================================
-- Hyprshot & Hyprpicker
-- ======================================================

hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- ======================================================
-- Focus movement (vim style)
-- ======================================================

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

-- ======================================================
-- Workspaces
-- ======================================================

for i = 1, 10 do
	local key = i % 10
	-- Focus workspace
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	-- Move window to workspace
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ======================================================
-- Special workspace
-- ======================================================

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- ======================================================
-- Workspace scrolling & Mouse controls
-- ======================================================

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ======================================================
-- Audio & Brightness & Media controls
-- ======================================================

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
