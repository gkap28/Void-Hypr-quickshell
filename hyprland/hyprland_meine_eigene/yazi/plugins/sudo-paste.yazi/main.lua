local sudo = require(".sudo")

local yanked = ya.sync(function()
    local paths = {}

    for _, url in pairs(cx.yanked) do
        paths[#paths + 1] = tostring(url)
    end

    return paths
end)

local get_cwd = ya.sync(function()
    return tostring(cx.active.current.cwd)
end)

return {
    entry = function()
        local urls = yanked()
        local cwd = get_cwd()

        if #urls == 0 then
            ya.notify {
                title = "ROOT EINFÜGEN",
                content = "Keine kopierten Dateien vorhanden",
                level = "warn",
                timeout = 5,
            }
            return
        end

        local sources = table.concat(urls, "\n")

        local body

        if #urls == 1 then
            body = string.format(
                "Quelle:\n%s\n\nZiel:\n%s\n\nWirklich hierher kopieren?",
                sources,
                cwd
            )
        else
            body = string.format(
                "Quellen:\n%s\n\nZiel:\n%s\n\n%d Einträge wirklich hierher kopieren?",
                sources,
                cwd,
                #urls
            )
        end

        local confirmed = ya.confirm {
            pos = { "center", w = 80, h = 16 },
            title = "ROOT EINFÜGEN",
            body = ui.Text(body):wrap(ui.Wrap.YES),
        }

        if not confirmed then
            ya.notify {
                title = "ROOT EINFÜGEN",
                content = "Abgebrochen",
                timeout = 3,
            }
            return
        end

        local args = {
            "-r",
            "--",
        }

        for _, url in ipairs(urls) do
            args[#args + 1] = url
        end

        args[#args + 1] = cwd

        local output, err = sudo.run_with_sudo("cp", args)

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
                title = "CP FEHLER",
                content = output.stderr ~= ""
                    and output.stderr
                    or "Kopieren fehlgeschlagen",
                level = "error",
                timeout = 8,
            }
            return
        end

        ya.notify {
            title = "ROOT EINFÜGEN",
            content = "Erfolgreich kopiert",
            timeout = 4,
        }

        ya.emit("refresh", {})
    end,
}
