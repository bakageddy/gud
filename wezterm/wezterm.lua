local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_wayland = true
config.window_background_opacity = 1
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.color_scheme = "Noctalia"

config.font_size = 16.0

config.font_rules = {
	{
		italic = false,
		font = wezterm.font_with_fallback { family = 'JetBrains Mono' }
	}
}

-- config.font = wezterm.font 'GitLab Mono'
config.cursor_blink_rate = 0
config.window_padding = {
	left   = 40,
	right  = 40,
	top    = 40,
	bottom = 40,
}

return config
