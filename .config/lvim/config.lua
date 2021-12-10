-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"

-- keys
require "user.keys"
-- lvim builtin config
require "user.lvimconfig"
-- LSP config
require "user.lsp"

require "user.treesitter"

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
      require("user.hop").config()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
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
  {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  },
  {
    "oberblastmeister/neuron.nvim",
    branch = "unstable",
    config = function()
      require('user.neuron').config()
    end,
  },
  -- markdown preview in nvim
  {"ellisonleao/glow.nvim"},
  {'nvim-orgmode/orgmode',
    config = function()
      require('user.orgmode').config()
    end,
  }
}

