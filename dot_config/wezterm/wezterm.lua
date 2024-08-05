-- Pull in the wezterm API
local wezterm = require "wezterm"
-- This will hold the configuration.
local config = wezterm.config_builder()
--
-- config.default_prog = {"/usr/bin/zsh"}
--
config.initial_cols = 160
config.initial_rows = 48
config.enable_tab_bar = false
--
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14
config.color_scheme = "Tokyo Night"
-- and finally, return the configuration to wezterm
return config

