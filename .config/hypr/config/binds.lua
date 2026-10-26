local mainMod = "SUPER"
local noctCall = "noctalia msg "
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

-- AZERTY fix: the number-row keys emit symbols (& é " ' ...) without Shift, so
-- binding to the digit characters fails. Bind by physical keycode instead.
-- Digit d -> evdev keycode: 1..9 => 10..18, 0 => 19
local function digitCode(d)
	return "code:" .. (d == 0 and 19 or (9 + d))
end

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

-- Window manipulation
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + I", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))

-- Change focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(noctCall .. "window-switcher"))

-- Move active window around workspaces & monitors
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

for i = 1, NUM_WPM do
	local key = i % 10
	hl.bind(mainMod .. " + SHIFT + " .. digitCode(key), hl.dsp.window.move({ workspace = "m~" .. i }))
end
for i = 1, NUM_WPM do
	local key = i % 10
	hl.bind(mainMod .. " + CONTROL + " .. digitCode(key), hl.dsp.window.move({ workspace = "m~" .. i, follow = false }))
end

-- Move & Resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Zoom
local function zoomfunction(value)
	local zoomvalue = hl.get_config("cursor:zoom_factor")
	if (zoomvalue + value) > 3.0 then
		hl.config({ cursor = { zoom_factor = 3.0 } })
	elseif (zoomvalue + value) < 1.0 then
		hl.config({ cursor = { zoom_factor = 1.0 } })
	else
		hl.config({ cursor = { zoom_factor = zoomvalue + value } })
	end
end
hl.bind(mainMod .. " + Minus", function()
	zoomfunction(-0.3)
end, { repeating = true })
hl.bind(mainMod .. " + Plus", function()
	zoomfunction(0.3)
end, { repeating = true })

--# Zoom with keypad
hl.bind(mainMod .. " + code:82", function()
	zoomfunction(-0.3)
end, { repeating = true })
hl.bind(mainMod .. " + code:86", function()
	zoomfunction(0.3)
end, { repeating = true })

------------------
---- LAUNCHER ----
------------------

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(launchPrefix .. CALCULATOR))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(launchPrefix .. BROWSER))
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e btop"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(noctCall .. "settings-toggle"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center"))
hl.bind(mainMod .. " + SEMICOLON", hl.dsp.exec_cmd(noctCall .. "session lock"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(noctCall .. "panel-toggle session"))

---------------------------
---- HARDWARE CONTROLS ----
---------------------------

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(noctCall .. "volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(noctCall .. "mic-mute"), { locked = true })

-- Media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(noctCall .. "media toggle"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noctCall .. "media toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(noctCall .. "media next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(noctCall .. "media previous"), { locked = true })

-- Brightness
if IS_MACBOOK then
	-- Display / Screen Brightness
	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd("brightnessctl set +10%"),
		{ device = "apple-inc.-touch-bar-display", repeat_key = true, locked = true }
	)
	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd("brightnessctl set 10%-"),
		{ device = "apple-inc.-touch-bar-display", repeat_key = true, locked = true }
	)

	-- Keyboard Backlight Brightness
	hl.bind(
		"XF86KbdBrightnessUp",
		hl.dsp.exec_cmd("brightnessctl -d '*kbd_backlight' set +10%"),
		{ device = "apple-inc.-touch-bar-display", repeat_key = true, locked = true }
	)
	hl.bind(
		"XF86KbdBrightnessDown",
		hl.dsp.exec_cmd("brightnessctl -d '*kbd_backlight' set 10%-"),
		{ device = "apple-inc.-touch-bar-display", repeat_key = true, locked = true }
	)
else
	hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(noctCall .. "brightness-up"), { locked = true, repeating = true })
	hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctCall .. "brightness-down"), { locked = true, repeating = true })
end

-------------------
---- UTILITIES ----
-------------------

-- Windows Snipping Tool behavior (Win + Shift + S)
--[[
hl.bind(
	"SUPER + SHIFT + S",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date +%Y%m%d-%H%M%S).png'
	)
)
-- ]]
--
-- Screen Capture
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a -n"))
hl.bind("Print", hl.dsp.exec_cmd(noctCall .. "screenshot-region"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(noctCall .. "screenshot-fullscreen"))

-- Theming and Wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(noctCall .. "panel-toggle wallpaper"))

-- Clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(noctCall .. "panel-toggle clipboard"))

-- Notifications
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center notifications"))

-------------------------------
---- WORKSPACES & MONITORS ----
-------------------------------

-- Focus on workspace number
for i = 1, NUM_WPM do
	local key = i % 10
	hl.bind(mainMod .. " + " .. digitCode(key), hl.dsp.focus({ workspace = "m~" .. i }))
end

-- Move to adjacent workspaces and next empty on a given monitor
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.focus({ workspace = "emptym" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special", follow = false }))
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special())
