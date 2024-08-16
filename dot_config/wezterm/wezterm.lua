-- Pull in the wezterm API
local wezterm = require "wezterm"
-- This will hold the configuration.
local config = wezterm.config_builder()
--
-- config.default_prog = {"/usr/bin/zsh"}
--
config.initial_cols = 150
config.initial_rows = 40
config.enable_tab_bar = false
--
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14
config.color_scheme = "Tokyo Night"

-- config.window_frame = {
--   border_left_width = '0.2cell',
--   border_right_width = '0.2cell',
--   border_bottom_height = '0.1cell',
--   border_top_height = '0.1cell',
--   border_left_color = 'silver',
--   border_right_color = 'silver',
--   border_bottom_color = 'silver',
--   border_top_color = 'silver',
-- }

-- and fnally, return the configuration to wezterm
return config

