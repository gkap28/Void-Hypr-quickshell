------------------
---- MONITORE ----
------------------

-- 1. Linker Monitor: LG Ultrawide (Startet ganz links bei Pixel 0)
hl.monitor({ 
    output   = "HDMI-A-1", 
    mode     = "2560x1080@60", 
    position = "0x0", 
    scale    = 1 
})

-- 2. Rechter Monitor: LG 22" (Startet genau nach dem Ultrawide bei Pixel 2560)
hl.monitor({ 
    output   = "DP-3", 
    mode     = "1920x1080@60", 
    position = "2560x0", 
    scale    = 1 
})

---------------------------
---- WORKSPACE RULES ------
---------------------------

-- LINKER MONITOR (HDMI-A-1): Nur 1-5 zulassen, Workspace 1 startet standardmäßig
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1", persistent = true })


-- RECHTER MONITOR (DP-3): Nur 6-10 zulassen, Workspace 6 startet standardmäßig
hl.workspace_rule({ workspace = "10", monitor = "DP-3", default = true, persistent = true })
hl.workspace_rule({ workspace = "11", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "12", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "13", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "14", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "15", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "16", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "17", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "18", monitor = "DP-3", persistent = true })
