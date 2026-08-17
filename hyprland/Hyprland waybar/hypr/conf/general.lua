-- ==========================================
-- Standard-Anwendungen (Variablen)
-- ==========================================
terminal    = "alacritty"
fileManager = "thunar"
menu        = "fuzzel"
browser     = "brave-browser-stable"
mail        = "thunderbird"
game        = "sol"
calc        = "galculator"

-- ==========================================
-- System- und Layout-Einstellungen
-- ==========================================
hl.config({
    general = {
        gaps_in = 10,
        gaps_out = 5,
        border_size = 2,
        col = {
            -- active_border = "$color11",
            -- inactive_border = "$color0",
        },
        layout = "dwindle", -- master scrolling monocle
        resize_on_border = true,
    },
    dwindle = {
        preserve_split = true, -- Empfohlene Standardeinstellung
    },
    master = {
        new_status = "master",
        new_on_top = 1,
        mfact = 0.5,
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
})
