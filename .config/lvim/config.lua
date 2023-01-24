-- general
lvim.log.level = 'warn'
lvim.format_on_save = false
lvim.colorscheme = 'tokyonight'
-- Feature flags
lvim.builtin.fancy_statusline = { active = false } -- enable/disable fancy statusline
lvim.builtin.copilot = { active = false } -- enable/disable github copilot
lvim.builtin.alpha.active = true
lvim.builtin.project.manual_mode = true

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { 'jdtls' })

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
    --    cmd = 'TroubleToggle',
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
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('user.colorizer').config()
    end,
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
    build = './install.sh',
    dependencies = 'hrsh7th/nvim-cmp',
  },
  { 'f-person/git-blame.nvim' },
  {
    'p00f/nvim-ts-rainbow',
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'ellisonleao/glow.nvim' },
  { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },
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
  -- Doesn't seem to work atm...
  -- https://github.com/vuki656/package-info.nvim/issues/127
  {
    'vuki656/package-info.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    event = 'BufRead package.json',
    config = function()
      require('package-info').setup {
        colors = {
          up_to_date = '#98c379',
          outdated = '#F05F4E',
        },
        -- hide_up_to_date = false,
        -- package_manager = 'pnpm',
      }
    end,
  },
  {
    -- telescope extension
    'zane-/howdoi.nvim',
  },
  {
    'booperlv/nvim-gomove',
    config = function()
      require('gomove').setup {
        -- whether or not to map default key bindings, (true/false)
        map_defaults = true,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      }
    end,
  },
  {
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
    config = function()
      require('neoscroll').setup {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      }
    end,
  },
}
