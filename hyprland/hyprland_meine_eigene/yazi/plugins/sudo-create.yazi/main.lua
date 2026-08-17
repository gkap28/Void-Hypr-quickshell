local sudo = require(".sudo")

local get_cwd = ya.sync(function()
    return tostring(cx.active.current.cwd)
end)

return {
    entry = function()
        local value, event = ya.input {
            pos = { "center", w = 50 },
            title = "ROOT DATEI ERSTELLEN",
            value = "",
        }

        if event ~= 1 or value == "" then
            return
        end

        local cwd = get_cwd()
        local path = cwd .. "/" .. value

        local output, err = sudo.run_with_sudo("touch", {
            "--",
            path,
        })

        if not output then
            ya.notify {
                title = "SUDO FEHLER",
                content = tostring(err),
                level = "error",
                timeout = 8,
            }
            return
        end

        if not output.status.success then
            ya.notify {
                title = "TOUCH FEHLER",
                content = output.stderr ~= "" and output.stderr or "Datei konnte nicht erstellt werden",
                level = "error",
                timeout = 8,
            }
            return
        end

        ya.notify {
            title = "ROOT DATEI",
            content = "Erstellt: " .. value,
            timeout = 3,
        }

        ya.emit("refresh", {})
    end,
}
