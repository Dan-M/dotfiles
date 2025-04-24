return {
	{ --lazydev
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{ -- optional completion source for require statements and module annotations for lazydev
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
	{ -- Mason
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
				-- "java-debug-adapter",
				-- "java-test",
				-- "jdtls",
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
				-- "typescript-language-server",
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
	{ --nvim-lspconfig
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
	},
}
