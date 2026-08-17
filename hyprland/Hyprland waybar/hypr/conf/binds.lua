local mainMod = "SUPER"

-- ==========================================
-- Apps und Skripte (hl.dsp.exec_cmd)
-- ==========================================
hl.bind(mainMod .. " + S",              hl.dsp.exec_cmd("min_window.sh"), { description = "Hide to special workspace" })
hl.bind(mainMod .. " + RETURN",         hl.dsp.exec_cmd(terminal), { description = "Terminal" })
hl.bind(mainMod .. " + SHIFT + M",      hl.dsp.exec_cmd(mail), { description = "Mail" })
hl.bind(mainMod .. " + W",              hl.dsp.exec_cmd(browser), { description = "Browser" })
hl.bind(mainMod .. " + SHIFT + A",      hl.dsp.exec_cmd(browser .. " --new-tab https://chatgpt.com"), { description = "ChatGPT" })
hl.bind(mainMod .. " + A",              hl.dsp.exec_cmd(game), { description = "Game" })
hl.bind(mainMod .. " + C",              hl.dsp.exec_cmd(calc), { description = "Calculator" })
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd(terminal .. " --class floating -e top"), { description = "Top App" })
hl.bind(mainMod .. " + PRINT",          hl.dsp.exec_cmd("screenshot.sh"), { description = "ScreenShoter" })
hl.bind(mainMod .. " + ESCAPE",         hl.dsp.exec_cmd("wlogout"), { description = "Logout Window" })
hl.bind(mainMod .. " + R",              hl.dsp.exec_cmd("hyprctl reload"), { description = "Hyprland Reload" })
hl.bind(mainMod .. " + CTRL + W",       hl.dsp.exec_cmd("waypaper"), { description = "Waypaper" })
hl.bind(mainMod .. " + CTRL + RETURN",  hl.dsp.exec_cmd(menu), { description = "Menu" })
hl.bind(mainMod .. " + CTRL + H",       hl.dsp.exec_cmd("keybindings.sh"), { description = "Keybindings" })
hl.bind(mainMod .. " + CTRL + R",       hl.dsp.exec_cmd("~/.config/waybar/launch.sh"), { description = "Waybar Reload" })
hl.bind(mainMod .. " + SHIFT + RETURN",  hl.dsp.exec_cmd(fileManager), { description = "Filemanager" })
hl.bind(mainMod .. " + CTRL + C",       hl.dsp.exec_cmd("cliphist.sh"), { description = "Clipboard" })
hl.bind(mainMod .. " + CTRL + T",       hl.dsp.exec_cmd("themeswitcher.sh"), { description = "Waybar Theme" })

-- ==========================================
-- Fenster-Management
-- ==========================================
hl.bind(mainMod .. " + Q",              hl.dsp.window.close(), { description = "Kill active window" })
hl.bind(mainMod .. " + F",              hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle Fullscreen" })
hl.bind(mainMod .. " + T",              hl.dsp.window.float({ action = "toggle" }), { description = "Toggle Floating" })
-- hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit"), { description = "Toggle split" }) -- Auskommentiert
hl.bind(mainMod .. " + G",              hl.dsp.group.toggle(), { description = "Toggle window group" })

-- Fokus bewegen
hl.bind(mainMod .. " + left",           hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right",          hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up",             hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down",           hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })

-- Fenstergröße ändern (Keyboard)
hl.bind(mainMod .. " + SHIFT + right",  hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true }, { description = "Increase window width" })
hl.bind(mainMod .. " + SHIFT + left",   hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true }, { description = "Reduce window width" })
hl.bind(mainMod .. " + SHIFT + up",     hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true }, { description = "Reduce window height" })
hl.bind(mainMod .. " + SHIFT + down",   hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true }, { description = "Increase window height" })

-- ==========================================
-- Workspaces (1-9) Schleife
-- ==========================================
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end

-- Workspaces per Mausrad wechseln
hl.bind(mainMod .. " + mouse_down",     hl.dsp.focus({ workspace = "r+1" }), { description = "Switch to next workspace" })
hl.bind(mainMod .. " + mouse_up",       hl.dsp.focus({ workspace = "r-1" }), { description = "Switch to previous workspace" })

-- ==========================================
-- Maus-Konfiguration & Maus-Bindings
-- ==========================================
hl.config({
    binds = {
        drag_threshold = 10
    }
})

-- Drag / Resize / Click Aktionen (bindm / bindc)
hl.bind(mainMod .. " + mouse:272",      hl.dsp.window.drag(), { mouse = true, description = "Move window with mouse" })
hl.bind(mainMod .. " + mouse:272",      hl.dsp.window.float({ action = "toggle" }), { mouse = true, click = true, description = "Toggle Floating" })
hl.bind(mainMod .. " + mouse:273",      hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })
hl.bind(mainMod .. " + mouse:273",      hl.dsp.exec_cmd("min_window.sh"), { mouse = true, click = true, description = "Min window with click" })
