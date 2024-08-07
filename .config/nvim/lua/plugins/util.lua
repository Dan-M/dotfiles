return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = {
			defaults = {
				file_ignore_patterns = { "node_modules", "target", "build" },
				prompt_prefix = " ",
				selection_caret = " ",
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						preview_cutoff = 0.2,
						preview_height = 0.4,
					},
					height = 0.9,
					width = 0.9,
				},
				mappings = {
					i = {
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions.layout").toggle_preview(...)
						end,
					},
					n = {
						["j"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["k"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["gg"] = function(...)
							return require("telescope.actions").move_to_top(...)
						end,
						["G"] = function(...)
							return require("telescope.actions").move_to_bottom(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions.layout").toggle_preview(...)
						end,
					},
				},
			},
			extensions = {},
		},
		keys = {
			{
				"<leader>sx",
				"<CMD>Telescope resume<CR>",
				desc = "Resume last search",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("import")
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
		opts = {
			{
				yank_register = "+",
				edit_with_instructions = {
					diff = false,
					keymaps = {
						accept = "<C-y>",
						toggle_diff = "<C-d>",
						toggle_settings = "<C-o>",
						cycle_windows = "<Tab>",
						use_output_as_input = "<C-i>",
					},
				},
				chat = {
					welcome_message = "Welcome",
					loading_text = "Loading, please wait ...",
					question_sign = "", -- 🙂
					answer_sign = "ﮧ", -- 🤖
					max_line_length = 120,
					sessions_window = {
						border = {
							style = "rounded",
							text = {
								top = " Sessions ",
							},
						},
						win_options = {
							winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
						},
					},
					keymaps = {
						close = { "<C-c>" },
						yank_last = "<C-y>",
						yank_last_code = "<C-k>",
						scroll_up = "<C-u>",
						scroll_down = "<C-d>",
						toggle_settings = "<C-o>",
						new_session = "<C-n>",
						cycle_windows = "<Tab>",
						select_session = "<Space>",
						rename_session = "r",
						delete_session = "d",
					},
				},
				popup_layout = {
					relative = "editor",
					position = "50%",
					size = {
						height = "80%",
						width = "80%",
					},
				},
				popup_window = {
					filetype = "chatgpt",
					border = {
						highlight = "FloatBorder",
						style = "rounded",
						text = {
							top = " ChatGPT ",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				popup_input = {
					prompt = "  ",
					border = {
						highlight = "FloatBorder",
						style = "rounded",
						text = {
							top_align = "center",
							top = " Prompt ",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
					submit = "<C-Enter>",
				},
				settings_window = {
					border = {
						style = "rounded",
						text = {
							top = " Settings ",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				openai_params = {
					model = "gpt-3.5-turbo",
					frequency_penalty = 0,
					presence_penalty = 0,
					max_tokens = 300,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				openai_edit_params = {
					model = "code-davinci-edit-001",
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				actions_paths = {},
				predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
			},
		},
	},
	{
		"chrisgrieser/nvim-origami",
		event = "BufReadPost", -- later or on keypress would prevent saving folds
		opts = true, -- needed even when using default config
	},

	-- Get infos about diagnostic from chatgpt or search for it
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			openai_model_id = "gpt-4",
		},
		keys = {
			{
				"gw",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"gW",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},
}
