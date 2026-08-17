-- ==========================================
-- Monitor-Konfiguration
-- ==========================================

-- Standard-Beispiele (Auskommentiert)
--[[
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })
hl.monitor({ output = "", mode = "1920x1080", position = "auto", scale = "1" })
hl.monitor({ output = "", mode = "2560x1440@120", position = "auto", scale = "1" })
--]]

-- Aktives Monitor-Setup

-- Hauptmonitor: UltraWide HDMI (Links positioniert bei X=0)
hl.monitor({
    output = "HDMI-A-1",
    mode = "2560x1080@60",
    position = "0x0",
    scale = "1",
})

-- Zweitmonitor: FullHD DisplayPort (Rechts daneben positioniert bei X=2560)
hl.monitor({
    output = "DP-3",
    mode = "1920x1080@60",
    position = "2560x0",
    scale = "1",
})
