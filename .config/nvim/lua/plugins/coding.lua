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
}
