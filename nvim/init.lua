-- 1. WICHTIG: Leertaste als Haupttaste (Leader) GANZ AM ANFANG definieren
vim.g.mapleader = " "

-- ==========================================
-- BOOTSTRAP LAZY.NVIM
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Sichere Zusammensetzung der URL
  local lazyrepo = "https://github.com/" .. "folke/" .. "lazy.nvim.git"
  
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- PLUGINS LADEN
-- ==========================================
require("lazy").setup({
  -- Material Theme
  { "marko-cerovac/material.nvim", lazy = false, priority = 1000 },
  
  -- Schicke Statuszeile unten
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Popup-Befehlszeile in der Mitte (Noice)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        cmdline = { view = "cmdline_popup" },
        presets = { command_palette = true },
      })
    end,
  },

  -- Dateisuche (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup()
      -- Hotkeys für die Suche
      vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, {})
      vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, {})
    end,
  },

  -- Datei-Browser Seitenleiste (Neo-tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
      -- Neo-tree konfigurieren, um versteckte Dateien anzuzeigen
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,          -- Macht gefilterte Elemente standardmäßig sichtbar
            hide_dotfiles = false,   -- Versteckt Dateien mit Punkt (.) am Anfang NICHT
            hide_gitignored = false, -- Versteckt von Git ignorierte Dateien NICHT
          }
        }
      })
      -- Hotkey: Leertaste + e öffnet/schließt die Seitenleiste
      vim.keymap.set('n', '<leader>e', ':Neotree toggle left<CR>', { silent = true })
    end,
  },

  -- Autovervollständigung (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({ { name = 'buffer' }, { name = 'path' } })
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } })
      })
    end,
  },
})

-- ==========================================
-- ALLGEMEINE EINSTELLUNGEN
-- ==========================================
vim.g.material_style = "darker"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Eigene Hotkeys (Zusatzfunktionen)
-- Strg + a im Normal-Modus markiert den gesamten Text (entspricht ggVG)
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = "Alles markieren" })

-- Theme aktivieren
vim.cmd 'colorscheme material'
require('lualine').setup({ options = { theme = 'material' } })

-- ==========================================
-- JAKE COLORSCHEME (CUSTOM THEME)
-- ==========================================

local term_colors = {
  [0] = "#000000", [1] = "#800000", [2] = "#c23d36", [3] = "#808000",
  [4] = "#000080", [5] = "#800080", [6] = "#008080", [7] = "#c0c0c0",
  [8] = "#808080", [9] = "#ff0000", [10] = "#00ff00", [11] = "#ffff00",
  [12] = "#0000ff", [13] = "#ff00ff", [14] = "#008080", [15] = "#ffffff",
  [66] = "#417070", [95] = "#553f31", [102] = "#878787", [138] = "#af8787",
  [232] = "#080808", [235] = "#262626", [236] = "#303030", [239] = "#4e4e4e",
  [243] = "#767676", [251] = "#c6c6c6",
}

-- Clear existing highlighting
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "jake"
vim.opt.background = "dark"

local highlights = {
  Normal = { ctermfg = 66, fg = term_colors[66] },
  Constant = { ctermfg = 66, fg = term_colors[66] },
  Boolean = { link = "Constant" }, Character = { link = "Constant" },
  Number = { link = "Constant" }, Float = { link = "Constant" }, String = { link = "Constant" },
  Statement = { ctermfg = 243, fg = term_colors[243] },
  Conditional = { link = "Statement" }, Repeat = { link = "Statement" },
  Label = { link = "Statement" }, Keyword = { link = "Statement" },
  Exception = { link = "Statement" }, PreProc = { link = "Statement" },
  Include = { link = "PreProc" }, Define = { link = "PreProc" },
  Macro = { link = "PreProc" }, PreCondit = { link = "PreProc" },
  Comment = { ctermfg = 102, fg = term_colors[102], italic = true },
  Type = { ctermfg = 251, fg = term_colors[251] },
  StorageClass = { link = "Type" }, Structure = { link = "Type" },
  Typedef = { link = "Type" }, Identifier = { link = "Type" }, Function = { link = "Type" },
  Operator = { ctermfg = 251, fg = term_colors[251], bold = true },
  Special = { ctermfg = 66, fg = term_colors[66], italic = true },
  SpecialChar = { link = "Special" }, Tag = { link = "Special" },
  Delimiter = { link = "Special" }, SpecialComment = { link = "Special" }, Debug = { link = "Special" },
  Error = { ctermfg = 1, fg = term_colors[1], ctermbg = 0, bg = term_colors[0] },
  ErrorMsg = { ctermfg = 1, fg = term_colors[1], ctermbg = 0, bg = term_colors[0] },
  MatchParen = { ctermfg = 1, fg = term_colors[1], ctermbg = 0, bg = term_colors[0] },
  Cursor = { ctermbg = 66, bg = term_colors[66] },
  CursorLine = { ctermbg = 236, bg = term_colors[236], bold = true },
  CursorLineNr = { ctermfg = 66, fg = term_colors[66], ctermbg = 236, bg = term_colors[236], bold = true },
  ColorColumn = { ctermbg = 232, bg = term_colors[232] }, CursorColumn = { ctermbg = 0, bg = term_colors[0] },
  SpecialKey = { ctermfg = 10, fg = term_colors[10] },
  SpellBad = { ctermfg = 95, fg = term_colors[95], underline = true },
  SpellCap = { ctermfg = 66, fg = term_colors[66], underline = true },
  SpellLocal = { ctermfg = 2, fg = term_colors[2], underline = true },
  SpellRare = { ctermfg = 9, fg = term_colors[9], underline = true },
  Search = { ctermfg = 66, fg = term_colors[66], ctermbg = 235, bg = term_colors[235] },
  IncSearch = { ctermfg = 235, fg = term_colors[235], ctermbg = 6, bg = term_colors[6] },
  Directory = { ctermfg = 66, fg = term_colors[66] }, Title = { ctermfg = 66, fg = term_colors[66] },
  Pmenu = { ctermfg = 251, fg = term_colors[251], ctermbg = 239, bg = term_colors[239] },
  PmenuSbar = { ctermfg = 251, fg = term_colors[251], ctermbg = 239, bg = term_colors[239] },
  PmenuSel = { ctermfg = 251, fg = term_colors[251], ctermbg = 66, bg = term_colors[66] },
  PmenuThumb = { ctermfg = 251, fg = term_colors[251], ctermbg = 239, bg = term_colors[239] },
  DiffAdd = { ctermfg = 10, fg = term_colors[10] }, DiffChange = { ctermfg = 3, fg = term_colors[3] },
  DiffDelete = { ctermfg = 1, fg = term_colors[1] }, DiffText = { ctermfg = 66, fg = term_colors[66] },
  StatusLine = { ctermbg = 236, bg = term_colors[236] },
  StatusLineNC = { ctermfg = 243, fg = term_colors[243], ctermbg = 236, bg = term_colors[236] },
  Visual = { ctermfg = 1, fg = term_colors[1], ctermbg = 232, bg = term_colors[232] },
  VisualNOS = { ctermbg = 239, bg = term_colors[239] },
  FoldColumn = { ctermfg = 239, fg = term_colors[239] }, Folded = { ctermfg = 243, fg = term_colors[243] },
  TabLine = { ctermfg = 251, fg = term_colors[251], ctermbg = 236, bg = term_colors[236] },
  TabLineSel = { ctermfg = 66, fg = term_colors[66], ctermbg = 239, bg = term_colors[239], bold = true },
  TabLineFill = { ctermfg = 66, fg = term_colors[66], ctermbg = 236, bg = term_colors[236] },
  WarningMsg = { ctermfg = 138, fg = term_colors[138] }, LineNr = { ctermfg = 243, fg = term_colors[243] },
  ModeMsg = { ctermfg = 243, fg = term_colors[243], bold = true },
  MoreMsg = { ctermfg = 243, fg = term_colors[243], bold = true },
  NonText = { ctermfg = 243, fg = term_colors[243] }, Question = { ctermfg = 1, fg = term_colors[1] },
}

-- Highlights anwenden
for group, settings in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, settings)
end
