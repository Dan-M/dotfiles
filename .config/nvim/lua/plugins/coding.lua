return {
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
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
		"simrat39/rust-tools.nvim",
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{ "<leader>sv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
		},
		opts = {
			border = "rounded", -- Valid window border style,
			show_unknown_classes = true, -- Shows the unknown classes popup
		},
	},
	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			-- require("telescope").load_extension("import")
		end,
	},
}
