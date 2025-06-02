local wezterm = require 'wezterm'
local act = wezterm.action

local config = {
    window_background_opacity = 0.9,
    color_scheme = 'Catppuccin Mocha',

    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = false,
    use_fancy_tab_bar = false,

    pane_focus_follows_mouse = true,
    audible_bell = "Disabled",

    font = wezterm.font('ComicCodeLigatures Nerd Font'),
    font_size = 12,

    enable_wayland = false,  -- Currently broken on Fedora

    colors = {
        background= 'black',
    }
}

local is_darwin = function()
    return wezterm.target_triple:find("darwin") ~= nil
end

if is_darwin() then
    config.keys = {
        { key = 'LeftArrow', mods = 'OPT', action = act.SendString '\x1bb' },
        { key = 'RightArrow', mods = 'OPT', action = act.SendString '\x1bf' }
    }
end

return config
