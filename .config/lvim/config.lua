-- general
lvim.log.level = 'warn'
lvim.format_on_save = false
lvim.colorscheme = 'onedarker'
-- Feature flags
lvim.builtin.fancy_statusline = { active = false } -- enable/disable fancy statusline
lvim.builtin.copilot = { active = true } -- enable/disable github copilot
lvim.builtin.alpha.active = true
-- key maps
require('user.keys').config()

-- lvim builtin config
require('user.lvimconfig').config()

-- LSP
require('user.lsp').config()

-- Neovim options
require('user.opts').config()

lvim.plugins = {
  {
    'folke/trouble.nvim',
    cmd = 'TroubleToggle',
  },
  {
    'phaazon/hop.nvim',
    event = 'BufRead',
    config = function()
      require('user.hop').config()
    end,
  },
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
  },
  {
    'pwntester/octo.nvim',
    event = 'BufRead',
    config = function()
      require('user.octo').config()
    end,
  },
  {
    'tzachar/cmp-tabnine',
    config = function()
      local tabnine = require 'cmp_tabnine.config'
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp',
  },
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ''
      vim.g.copilot_filetypes = {
        ['*'] = true,
        markdown = false,
        dart = false,
        gitcommit = false,
        NeogitCommitMessage = false,
      }
    end,
  },
  { 'f-person/git-blame.nvim' },
  { 'ChristianChiarulli/nvim-ts-rainbow' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'ellisonleao/glow.nvim' },
  { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' },
  {
    'vim-test/vim-test',
    cmd = { 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' },
    config = function()
      require('user.vim-test').config()
    end,
  },
  { 'morhetz/gruvbox' },
  {
    'scalameta/nvim-metals',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('user.metals').config()
    end,
  },
  { 'mfussenegger/nvim-jdtls' },
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require('user.gitlinker').config()
    end,
  },
}

lvim.autocommands.custom_groups = {
  { "FileType", "scala,sbt", "lua require('user.metals').config()" }
}
