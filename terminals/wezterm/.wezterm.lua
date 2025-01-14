-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Batman'
--config.color_scheme = 'Black Metal (Dark Funeral) (base16)'

--config.color_scheme = 'Bitmute (terminal.sexy)'
--config.color_scheme = 'Belafonte Day (Gogh)'

-- and finally, return the configuration to wezterm
return config
