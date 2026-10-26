-- Input configuration

local input_cfg = {
	-- sensitivity = -0.25,
	accel_profile = "adaptive",
	numlock_by_default = true,
	follow_mouse = 2,
}

if IS_MACBOOK then
	input_cfg.sensitivity = 0.25
	input_cfg.touchpad = {
		natural_scroll = true,
		scroll_factor = 0.3,
		disable_while_typing = true,
		tap_to_click = false,
		clickfinger_behavior = true,
	}
end

hl.config({
	input = input_cfg,
	-- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
	-- cursor = {
	--     no_hardware_cursors = 1,
	-- },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left", action = "float" })
