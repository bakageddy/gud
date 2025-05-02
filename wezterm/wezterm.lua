local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.window_background_opacity = 0.7
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
-- config.color_scheme = 'kanagawabones'
-- config.color_scheme = 'Solarized Dark - Patched'
-- config.color_scheme = 'Grayscale Dark (base16)'
config.color_scheme = 'Gruvbox dark, hard (base16)'
-- config.color_scheme = 'Alduin'
-- config.color_scheme = 's3r0 modified (terminal.sexy)'

config.font_size = 16.0
-- config.font = wezterm.font {
-- 	family = "Iosevka Term",
-- 	weight = "Medium"
-- }
config.font = wezterm.font 'GitLab Mono'
config.cursor_blink_rate = 0
config.window_padding = {
	left	= 40,
	right	= 40,
	top		= 40,
	bottom	= 40,
}

return config
