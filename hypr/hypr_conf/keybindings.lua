local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local browser = "firefox"

-- ======================================================
-- System & Applications
-- ======================================================

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("kalk"))

-- Logout / shutdown
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh"))
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)

-- ======================================================
-- Utilities
-- ======================================================

-- Clipboard
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")
)

-- Hyprshot
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region"))

-- Hyprpicker
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- ======================================================
-- Window States & Layout
-- ======================================================

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Z", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Y", hl.dsp.window.pin({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + ALT_L", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.fullscreen())

-- ======================================================
-- Window Focus & Cycling
-- ======================================================

-- Vim style focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

-- Cycle windows
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.cycle_next({ tiled = true }))
hl.bind(mainMod .. " + A", hl.dsp.window.cycle_next({ floating = true }))

-- ======================================================
-- Window Moving & Resizing
-- ======================================================

-- Move windows
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.move({ direction = "right" }))

-- Resize windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

-- Mouse controls
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ======================================================
-- Workspaces
-- ======================================================

-- Toggle previous workspace
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Workspace 1-10
for i = 1, 10 do
	local key = i % 10
	-- Focus workspace
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	-- Move window to workspace
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Workspace scrolling
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- ======================================================
-- Hardware Controls (Audio, Brightness & Media)
-- ======================================================

-- Volume
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

-- Mute
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

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Aura
hl.bind("XF86Launch4", hl.dsp.exec_cmd("asusctl aura effect --next-mode"))

-- Media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
