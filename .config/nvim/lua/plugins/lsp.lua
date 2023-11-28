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
      inlay_hints = { enabled = false },
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
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  "--log-level=trace",
                },
              },
              diagnostics = {
                globals = { "vim" },
                disable = { "incomplete-signature-doc" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        ---@type lspconfig.options.tsserver
        tsserver = {
          settings = {
            typescript = {
              format = {
                enable = false,
              },
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            javascript = {
              format = {
                enable = false,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        jdtls = {
          root_dir = require("jdtls.setup").find_root({ ".git" }),
        },
      },
    },
    setup = {
      tsserver = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          if client.name == "tsserver" then
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
          -- stylua: ignore
          vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
          end
        end)
        require("typescript").setup({ server = opts })
        return true
      end,
    },
    dependencies = { "folke/neodev.nvim" },
  },

  {
    "mfussenegger/nvim-jdtls",
    opts = function()
      return {
        -- root dir only .git to work with maven hierarchical project
        root_dir = function()
          return vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
        end,
        -- How to find the project name for a given root dir.
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,

        -- How to run jdtls. This can be overridden to a full java command-line
        -- if the Python wrapper script doesn't suffice.
        -- cmd = { "jdtls" },
        cmd = {
          "jdtls",
          "--jvm-arg=-javaagent:/home/dan/.local/share/nvim/mason/packages/jdtls/lombok.jar",
          "--jvm-arg=-XX:+UseParallelGC",
          "--jvm-arg=-XX:GCTimeRatio=4",
          "--jvm-arg=-XX:AdaptiveSizePolicyWeight=90",
          "--jvm-arg=-Dsun.zip.disableMemoryMapping=true",
          "--jvm-arg=-Xmx3G",
          "--jvm-arg=-Xms512m",
          "--jvm-arg=-Dlog.protocol=true",
          "--jvm-arg=-Dlog.level=ALL",
          "--jvm-arg=--add-modules=ALL-SYSTEM",
          "--jvm-arg=-Xlog:disable",
        },

        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,

        -- These depend on nvim-dap, but can additionally be disabled by setting false here.
        dap = { hotcodereplace = "auto", config_overrides = {} },
        test = true,

        settings = {
          java = {
            configuration = {
              updateBuildConfiguration = "automatic",
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
            completion = {
              favoriteStaticMembers = {
                "org.assertj.core.api.Assertions.*",
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.Answers.*",
              },
              importOrder = {
                "#",
                "java",
                "javax",
                "org",
                "com",
              },
            },
            contentProvider = { preferred = "fernflower" },
            eclipse = {
              downloadSources = true,
            },
            flags = {
              allow_incremental_sync = true,
              server_side_fuzzy_completion = true,
            },
            implementationsCodeLens = {
              enabled = false, --Don"t automatically show implementations
            },
            inlayHints = {
              parameterNames = { enabled = "literals" },
            },
            maven = {
              downloadSources = true,
            },
            referencesCodeLens = {
              enabled = true, --Don"t automatically show references
            },
            references = {
              includeDecompiledSources = true,
            },
            saveActions = {
              organizeImports = false,
            },
            signatureHelp = { enabled = true },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
      }
    end,
  },
}
