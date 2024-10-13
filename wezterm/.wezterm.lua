local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Utiliza una de las fuentes de tu sistema
config.font = wezterm.font('MesloLGM Nerd Font Mono', { weight = 'Bold', italic = true })

config.font_size = 18

config.background = {
    {
        -- AÃ±ade una imagen con tu path completo
        source = { File = {path = 'C:/Users/admod/OneDrive/Pictures/Wallpapers/99825.jpg'}},
        opacity = 1,
        width = "100%",
        hsb = {brightness = 0.1},
    }
}

-- AÃ±ade un tema
config.color_scheme = 'AdventureTime'

-- AÃ±ade la versiÃ³n de WSL2
config.default_domain = 'WSL:Ubuntu'

return config
