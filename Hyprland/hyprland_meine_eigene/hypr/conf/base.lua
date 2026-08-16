---------------------
---- MY PROGRAMS ----
---------------------
-- Set programs that you use
local terminal    = "alacritty"
local fileManager = "thunar"
local mail        = "thunderbird"
local web         = "brave"
local menu        = "hyprlauncher"

---------------------
----- BASE CONF -----
---------------------
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,
        border_size = 0,
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    }
})
