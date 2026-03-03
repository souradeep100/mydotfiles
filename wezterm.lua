local wezterm = require 'wezterm'

local config = {
  font = wezterm.font("Cascadia Code"),
  font_size = 12,
  color_scheme = "Catppuccin Mocha", -- Optional
  term = "wezterm",
}
config.default_prog = { 'powershell.exe', '-NoLogo' }
config.keys = {
  -- Split horizontal
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split vertical
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Toggle Fullscreen
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.ToggleFullScreen,
  },
  -- Disable default CMD-m (Hide)
  {
    key = 'm',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
}
config.scrollback_lines = 999999

-- Define a Leader Key
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.ssh_domains = {
  {
    -- This name identifies the domain
    name = 'dev_arm64',
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = '52.156.216.25',
    -- The username to use on the remote host
    username = 'schakrabarti',
    local_echo_threshold_ms = 10000, 
  },
}

return config
