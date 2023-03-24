return {
  {
    "folke/neodev.nvim",
    opts = {
      debug = true,
      experimental = {
        pathStrict = true,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ansible-language-server",
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
        "typescript-language-server",
        "vim-language-server",
        "yaml-language-server",
        "yamlfmt",
        "yamllint",
      })
    end,
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "",
        package_uninstalled = "✗",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = true,
              },
              keyOrdering = false,
              format = {
                enable = false,
                printWidth = 120,
                bracketSpacing = true,
              },
              -- use yamllint to lint
              validate = false,
              schemas = {
                {
                  description = "Docker Compose",
                  fileMatch = {
                    "docker-compose.yml",
                  },
                  url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
                },
              },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemaStore = {
                enable = true,
              },
              format = {
                keepLines = false,
              },
              schemas = {
                {
                  description = "NPM packages",
                  fileMatch = {
                    "package.json",
                  },
                  url = "https://json.schemastore.org/package.json",
                },
                {
                  description = "Prettier",
                  fileMatch = {
                    ".prettierrc.json",
                    ".prettierrc",
                  },
                  url = "https://json.schemastore.org/prettierrc.json",
                },
                {
                  description = "ts config",
                  fileMatch = {
                    "tsconfig.json",
                  },
                  url = "https://json.schemastore.org/tsconfig.json",
                },
                {
                  description = "eslint rc",
                  fileMatch = {
                    ".eslintrc.json",
                    ".eslintrc",
                  },
                  url = "https://json.schemastore.org/eslintrc.json",
                },
              },
              validate = {
                enable = true,
              },
            },
          },
        },
        docker_compose_language_service = {},
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      local function is_file(path)
        local cwd = vim.fn.getcwd()
        local stat = vim.loop.fs_stat(cwd .. path)
        return stat and stat.type == "file" or false
      end
      local function is_eslint_configured()
        return is_file("/.eslintrc.json")
      end
      local function is_prettier_configured()
        return is_file("/.prettierrc") or is_file("/.prettierrc.json")
      end

      return {
        sources = {
          -- js / ts
          nls.builtins.formatting.prettierd.with({ condition = is_prettier_configured }),
          nls.builtins.diagnostics.eslint_d.with({ condition = is_eslint_configured }),
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
  --  { import = "plugins.extra.lang.unison" },
}
