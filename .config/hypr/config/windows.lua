-- 1. FIX TRANSPARENCY: Force the actual Zoom app & meeting screens to tile and stay solid
hl.window_rule({
	name = "zoom-main-windows",
	match = {
		class = "^zoom$",
		title = "^(Zoom Workplace( - .*)?|Meeting|Zoom)$",
	},
	tile = true,
	opacity = "1.0 override", -- Strips any global active/inactive transparency
})

-- 2. FIX ANNOTATION OVERLAY: Catch the dynamic screen share popups/toolbars
--[[
hl.window_rule({
	name = "zoom-popups-and-overlays",
	match = {
		class = "^zoom$",
	},
	float = true,
	no_blur = true,
	no_shadow = true,
	no_initial_focus = true, -- Prevents the annotation panel from stealing your keyboard focus
})
-- ]]
--
hl.window_rule({
	name = "waydroid-sideswipe-landscape",
	match = {
		class = "^[Ww]aydroid.*$", -- Captures both 'waydroid' and 'Waydroid'
	},
	float = true, -- Force floating layout
	size = { 1462, 675 },
	center = true, -- Lock it to the center of your display
	fullscreen_state = "0 0", -- Blocks Android from overriding and blowing up to fullscreen early
})
