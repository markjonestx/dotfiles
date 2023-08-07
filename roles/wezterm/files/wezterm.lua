local wezterm = require 'wezterm'

local config = {
    window_background_opacity = 0.86,
    color_scheme = 'Catppuccin Mocha',

    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = false,
    use_fancy_tab_bar = false,
    font = wezterm.font('ComicCodeLigatures Nerd Font'),
    font_size = 11
}

config.colors = {
    background= 'black',
}

return config
