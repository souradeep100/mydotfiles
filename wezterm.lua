-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'DanQing (base16)'
-- For example, changing the color scheme:
config.font = wezterm.font ('CascadiaCodeNF-SemiLight')
config.font_size = 16

config.keys = {
    -- Toggle full screen
    {key="F11", mods="NONE", action=wezterm.action.ToggleFullScreen},

    -- Increase font size
    {key="+", mods="CTRL", action=wezterm.action.IncreaseFontSize},

    -- Decrease font size
    {key="-", mods="CTRL", action=wezterm.action.DecreaseFontSize},

    -- Reset font size
    {key="0", mods="CTRL", action=wezterm.action.ResetFontSize},
  }
-- and finally, return the configuration to wezterm
return config
