return {
	{ -- gitlinker
		"ruifm/gitlinker.nvim",
		config = function()
			local status_ok, gitlinker = pcall(require, "gitlinker")
			if not status_ok then
				return
			end
			gitlinker.setup({
				opts = {
					-- adds current line nr in the url for normal mode
					add_current_line_on_normal_mode = true,
					-- callback for what to do with the url
					action_callback = require("gitlinker.actions").copy_to_clipboard,
					-- print the url after performing the action
					print_url = true,
				},
				callbacks = {
					["github.com"] = require("gitlinker.hosts").get_github_type_url,
				},
				-- default mapping to call url generation with action_callback
				mappings = "<leader>gy",
			})
		end,
	},
	{ -- git-conflict.nvim
		"akinsho/git-conflict.nvim",
		event = "BufReadPre",
		config = true,
		-- These are the acutal default_mappings. I have them here for reference
		default_mappings = {
			ours = "co",
			theirs = "ct",
			none = "c0",
			both = "cb",
			next = "]x",
			prev = "[x",
		},
	},
}
