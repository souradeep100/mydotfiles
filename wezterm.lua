-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'DanQing (base16)'
-- For example, changing the color scheme:
config.font = wezterm.font ('CascadiaCodeNF-SemiLight')
config.font_size = 14

config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
        -- Toggle full screen
        {key="F11", mods="NONE", action=wezterm.action.ToggleFullScreen},

        -- Increase font size
        {key="+", mods="CTRL", action=wezterm.action.IncreaseFontSize},

        -- Decrease font size
        {key="-", mods="CTRL", action=wezterm.action.DecreaseFontSize},

        -- Reset font size
        {
                key = '|',
                mods = 'LEADER|SHIFT',
                action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
                key = '-',
                mods = 'LEADER',
                action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {key="0", mods="CTRL", action=wezterm.action.ResetFontSize},
        {key="q", mods="CTRL", action=wezterm.action.CloseCurrentPane { confirm = true }},
        {key="w", mods="CTRL", action=wezterm.action.CloseCurrentTab { confirm = true }},
        {
                key = 'LeftArrow',
                mods = 'LEADER',
                action = wezterm.action.AdjustPaneSize { 'Left', 5 },
        },
        {
                key = 'DownArrow',
                mods = 'LEADER',
                action = wezterm.action.AdjustPaneSize { 'Down', 5 },
        },
        { key = 'UpArrow', mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
        {
                key = 'RightArrow',
                mods = 'LEADER',
                action = wezterm.action.AdjustPaneSize { 'Right', 5 },
        },
        {
                key = 'z',
                mods = 'LEADER',
                action = wezterm.action.TogglePaneZoomState,
        }
}
return config
