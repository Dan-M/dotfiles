return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "clojure-lsp",
        "css-lsp",
        "dockerfile-language-server",
        "eslint_d",
        "html-lsp",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "jq",
        "js-debug-adapter",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "luacheck",
        "prettierd",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "taplo",
        "typescript-language-server",
        "vim-language-server",
        "yaml-language-server",
        "yamlfmt",
        "yamllint",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")

      local function is_file(path)
        local uv = vim.loop
        local cwd = vim.fn.getcwd()
        local stat = uv.fs_stat(cwd .. path)
        return stat and stat.type == "file" or false
      end
      local function is_eslint_configured()
        return is_file("/.eslintrc")
      end
      local function is_prettier_configured()
        return is_file("/.prettierrc")
      end

      return {
        sources = {
          -- js / ts
          nls.builtins.formatting.prettierd, -- .with({ condition = is_prettier_configured }),
          nls.builtins.diagnostics.eslint_d, -- .with({ condition = is_eslint_configured }),
          -- Lua
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.luacheck,
          -- shell
          nls.builtins.formatting.shfmt,
          nls.builtins.diagnostics.shellcheck,
          -- yaml
          nls.builtins.formatting.yamlfmt,
          nls.builtins.diagnostics.yamllint,
        },
      }
    end,
  },

  { import = "plugins.extra.lang.java" },
  { import = "plugins.extra.lang.typescript" },
}
