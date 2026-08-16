
-- 1. Grundlegende Einstellungen (Options)
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 2. Lazy.nvim Pfade für normalen User und Root synchronisieren
local user_home = "/home/georg"
local lazypath = user_home .. "/.local/share/nvim/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git", "clone", "--filter=blob:none",
      "https://github.com", "--branch=stable", lazypath,
    })
  end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Plugins installieren
require("lazy").setup({
  root = user_home .. "/.local/share/nvim/lazy",
  spec = {
    -- Farbschema
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      lazy = false,
      config = function() vim.cmd.colorscheme("catppuccin-mocha") end
    },

    -- Floating Kommandozeile
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
      opts = {
        cmdline = { view = "cmdline_popup" },
        popupmenu = { enabled = true },
      },
    },

    -- Statuszeile
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      lazy = false,
      opts = { options = { theme = "auto" } },
    },

    -- Syntax-Highlighting
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        vim.api.nvim_command("syntax on")
        vim.api.nvim_command("filetype plugin indent on")
      end,
    },

    -- Datei-Explorer
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup()
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
      end,
    },

    -- Telescope (Suche)
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        telescope.setup({ defaults = { preview = { treesitter = false } } })
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fs", function()
          builtin.find_files({
            prompt_title = "System & Configs",
            search_dirs = { "/boot", "/etc", "/home/georg/.config" },
            hidden = true, no_ignore = true,
          })
        end, {})
      end,
    },

    -- Blitzschnelle Autovervollständigung (blink.cmp)
    {
      "saghen/blink.cmp",
      lazy = false,
      dependencies = "rafamadriz/friendly-snippets",
      version = "v0.*",
      opts = {
        keymap = { preset = "default" },
        appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = "mono" },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
      },
    },

    -- LSP Konfiguration (Modernisiert für Neovim 0.11+)
    {
      "neovim/nvim-lspconfig",
      dependencies = { "saghen/blink.cmp" },
      config = function()
        -- Nutzen des neuen nativen vim.lsp.config Frameworks ab v0.11
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- Bash Server starten (Wenn vorhanden)
        if vim.fn.executable("bash-language-server") == 1 then
          vim.lsp.config("bashls", { capabilities = capabilities })
        end

        -- Lua Server starten (Wenn vorhanden)
        if vim.fn.executable("lua-language-server") == 1 then
          vim.lsp.config("lua_ls", { capabilities = capabilities })
        end
      end,
    },
  }
})
