-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local cursor_theme = "Bibata-Modern-Amber"
local cursor_size = 24

-- Umgebungsvariablen für den Cursor
hl.env("XCURSOR_THEME", cursor_theme)
hl.env("XCURSOR_SIZE", tostring(cursor_size))

hl.env("HYPRCURSOR_THEME", cursor_theme)
hl.env("HYPRCURSOR_SIZE", tostring(cursor_size))
