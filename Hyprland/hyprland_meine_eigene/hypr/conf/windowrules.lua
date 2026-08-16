-----------------------
---- WINDOW RULES -----
-----------------------

-- Thunar Blur
hl.window_rule({
    name = "thunar-blur",
    match = { class = "^(thunar)$" },
    opacity = "0.75 override 0.75 override",
})

-- Suppress Maximize Events
local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- ==========================================
-- FENSTERREGELN FÜR SCHWEBENDE TERMINALS
-- ==========================================

-- 1. Updates (Kompakte Standardgröße)
hl.window_rule({
    match = { class = "floating" },
    float = true,
    size = "800 500",
    center = true
})

-- 2. Wetter (Groß und breit)
hl.window_rule({
    match = { class = "weather-floating" },
    float = true,
    size = "1200 750",
    center = true
})

-- PipeWire Volume Control
hl.window_rule({
    match = { class = "com.saivert.pwvucontrol" },
    float = true,
    size = "800 600",
    center = true
})
