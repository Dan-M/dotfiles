-- general
lvim.log.level = 'info'
lvim.format_on_save = false
lvim.colorscheme = 'onedarker'

-- Feature flags
lvim.builtin.fancy_statusline = { active = false } -- enable/disable fancy statusline
-- lvim.builtin.alpha = { active = false }

lvim.builtin.project.manual_mode = true

-- key maps
require('user.keys').config()

-- lvim builtin config
require('user.lvimconfig').config()

-- LSP
-- excluded servers:
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
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
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('user.colorizer').config()
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
  { 'mfussenegger/nvim-jdtls' },
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require('user.gitlinker').config()
    end,
  },
  {
    'MunifTanjim/nui.nvim',
  },
  {
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    event = "BufRead package.json",
    config = function()
      require("package-info").setup({
        colors = {
            up_to_date = "#98c379",
            outdated = "#F05F4E",
        },
      })
    end
  },
  {
    'ThePrimeagen/harpoon'
  },
  {
    -- telescope extension
    'zane-/howdoi.nvim',
  },
}
