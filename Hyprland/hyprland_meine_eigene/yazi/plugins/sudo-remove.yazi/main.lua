local sudo = require(".sudo")

local selected_or_hovered = ya.sync(function()
    local tab, paths = cx.active, {}

    for _, f in pairs(tab.selected) do
        paths[#paths + 1] = tostring(f.url or f)
    end

    if #paths == 0 and tab.current.hovered then
        paths[1] = tostring(tab.current.hovered.url)
    end

    return paths
end)

return {
    entry = function()
        ya.emit("escape", { visual = true })

        local urls = selected_or_hovered()

        if #urls == 0 then
            ya.notify {
                title = "ROOT LÖSCHEN",
                content = "Kein Eintrag ausgewählt",
                level = "warn",
                timeout = 5,
            }
            return
        end

        local body

        if #urls == 1 then
            body = "Wirklich löschen?\n\n" .. urls[1]
        else
            body = string.format(
                "%d Einträge wirklich löschen?",
                #urls
            )
        end

        local confirmed = ya.confirm {
            pos = { "center", w = 70, h = 10 },
            title = "ROOT LÖSCHEN",
            body = ui.Text(body):wrap(ui.Wrap.YES),
        }

        if not confirmed then
            ya.notify {
                title = "ROOT LÖSCHEN",
                content = "Abgebrochen",
                timeout = 3,
            }
            return
        end

        local output, err = sudo.run_with_sudo("rm", {
            "-rf",
            "--",
            table.unpack(urls),
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
                title = "RM FEHLER",
                content = output.stderr ~= ""
                    and output.stderr
                    or "Löschen fehlgeschlagen",
                level = "error",
                timeout = 8,
            }
            return
        end

        ya.notify {
            title = "ROOT LÖSCHEN",
            content = "Erfolgreich gelöscht",
            timeout = 4,
        }

        ya.emit("refresh", {})
    end,
}
