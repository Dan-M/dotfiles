return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "awk",
        "bash",
        "clojure",
        "css",
        "comment",
        "diff",
        "dockerfile",
        "dot",
        "fish",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "graphql",
        "help",
        "html",
        "http",
        "ini",
        "java",
        "javascript",
        "jq",
        "json",
        "json5",
        "jsonc",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "regex",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
    },
  },
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    event = "BufRead package.json",
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#98c379",
          outdated = "#F05F4E",
        },
        package_manager = "pnpm",
        autostart = true,
      })
    end,
  },
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function() end,
  },
  -- update whichkey bindings
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>tn"] = { name = "Test nearest" },
      })
    end,
  },
  {
    "unisonweb/unison",
    branch = "trunk",
    rtp = "/editor-support/vim",
    config = function()
      --  require("unisonweb/unison").setup({})
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      navbuddy.setup({
        lsp = {
          auto_attach = true,
          preference = nil,
        },
      })
    end,
  },
  -- update whichkey bindings
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>cO"] = { name = "Navbuddy", cmd = "<cmd>Navbuddy<cr>" },
      })
    end,
  },
}
