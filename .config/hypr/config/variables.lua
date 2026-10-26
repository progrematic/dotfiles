-- Hyprland default apps

TERMINAL = "kitty"
FILE_MANAGER = "dolphin"
BROWSER = "google-chrome-stable"
CALCULATOR = "gnome-calculator"

-- Detect MacBook via env var or hostname
local function detect_macbook()
	local env = os.getenv("IS_MACBOOK")
	if env ~= nil then
		return env == "1" or env == "true"
	end
	local f = io.open("/etc/hostname", "r")
	if f then
		local hostname = f:read("*l") or ""
		f:close()
		if hostname:find("MACBOOK") then
			return true
		end
	end
	return false
end

IS_MACBOOK = detect_macbook()

-- Monitors
if IS_MACBOOK then
	MONITOR1 = "eDP-1"
	MONITOR2 = ""
	MONITOR3 = ""
else
	MONITOR1 = "DP-2"
	MONITOR2 = "HDMI-A-1"
	MONITOR3 = ""
end
PRIMARY_MONITOR = MONITOR1

-- Workspaces
NUM_WPM = 3 -- Number of workspaces per monitor (Max 10)
