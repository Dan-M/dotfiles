--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<A-j>"] = ":m .+1<CR>=="
lvim.keys.normal_mode["<A-k>"] = ":m .-2<CR>=="
lvim.keys.normal_mode["bd"] = ":BufferDelete<CR>"
lvim.keys.normal_mode["bo"] = ":BufferCloseAllButCurrent<CR>"
lvim.keys.normal_mode["tf"] = ":TestFile<CR>"

lvim.builtin.dashboard.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.project.detection_methods = { "pattern", "lsp" }
lvim.builtin.project.patterns = { "package.json", ".git" }
lvim.lang.typescript.linters = { { exe = "eslint" } }
lvim.lang.javascript.linters = lvim.lang.typescript.linters

lvim.builtin.fancy_statusline = { active = true } -- enable/disable fancy statusline
if lvim.builtin.fancy_statusline.active then
  require("user.lualine").config()
end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    exe = "eslint",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

-- THIS DOESNT WORK FOR SOME UNKNOWN REASON
-- vim.list_extend(lvim.lsp.override, { "java" })
-- local opts = {
--   -- use only .git as root to have the whole mvn hierarchy in on LSP server
--   root_dir = require('jdtls.setup').find_root({ ".git" })
-- }
-- require("lvim.lsp.manager").setup("java", opts)

lvim.plugins = {
  { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' },
  { 'vim-test/vim-test'},
  { 'morhetz/gruvbox' },
  { 'scalameta/nvim-metals' },
  { 'mfussenegger/nvim-jdtls' },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
    local status_ok, hop = pcall(require, "hop")
    if not status_ok then
      return
    end
    hop.setup()
    vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
    vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      local status_ok, colorizer = pcall(require, "colorizer")
      if not status_ok then
        return
      end

      colorizer.setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
--  {
--    "projekt0n/github-nvim-theme",
--  },
  {'f-person/git-blame.nvim'},
  { "ChristianChiarulli/nvim-ts-rainbow" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "pwntester/octo.nvim",
    event = "BufRead",
    config = function()
      require("user.octo").config()
    end,
  },
}

-- require("github-theme").setup({
--  functionStyle = "italic",
--  sidebars = {"qf", "vista_kind", "terminal", "packer"},
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--  colors = {hint = "orange", error = "#ff0000"}
-- })

-- Additional Leader bindings for WhichKey
lvim.builtin.which_key.mappings.l.d = { "<cmd>TroubleToggle<cr>", "Diagnostics" }
lvim.builtin.which_key.mappings.l.R = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
lvim.builtin.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
lvim.builtin.which_key.mappings.g.n = { "<cmd>Neogit<cr>", "Neogit" }
lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  f = { "<cmd>TestFile<cr>", "Test File" },
  n = { "<cmd>TestNearest<cr>", "Test Nearest" },
}
