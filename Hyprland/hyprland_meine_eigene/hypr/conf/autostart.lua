-------------------
---- AUTOSTART ----
-------------------

-- Lokale Variablen für Cursor-Zuweisung innerhalb des Scopes verfügbar machen
local cursor_theme = "Bibata-Modern-Amber"
local cursor_size = 24

hl.on("hyprland.start", function () 
    -- 1. D-Bus Umgebung aktivieren (Essenziell für Portale)
    hl.exec_cmd("dbus-update-activation-environment --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &")
    
    -- Sound-Server aktivieren
    hl.exec_cmd("pipewire &")
    hl.exec_cmd("sleep 1 && pipewire-pulse &")
    hl.exec_cmd("sleep 2 && wireplumber &")
    
    -- Void Linux Polkit Agent für Admin-Rechte
    hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1 &")

    -- 3. Benachrichtigungen (Dunst) wieder aktivieren
    hl.exec_cmd("dunst &")

    -- 4. Deine gewohnte Statusleiste (Waybar) starten
    --hl.exec_cmd("waybar &")
    hl.exec_cmd("sleep 2 && quickshell &")

    -- 5. Waypaper Hintergrundbild beim Starten wiederherstellen
    hl.exec_cmd("/home/georg/.local/bin/waypaper --restore &")

    -- 6. Cursor setzen (Findet die Variablen nun, da sie oben stehen)
    hl.exec_cmd("hyprctl setcursor " .. cursor_theme .. " " .. cursor_size)
end)
