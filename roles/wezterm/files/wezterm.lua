local wezterm = require 'wezterm'

local config = {
    window_background_opacity = 0.82,
    color_scheme = 'Catppuccin Mocha',

    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = false,
    use_fancy_tab_bar = false,

    pane_focus_follows_mouse = true,
    audible_bell = "Disabled",

    font = wezterm.font('ComicCodeLigatures Nerd Font'),
    font_size = 11
}

config.colors = {
    background= 'black',
}

return config
