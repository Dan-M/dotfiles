-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local go = vim.g
local opt = vim.opt

opt.inccommand = "split"

-- Root dir detection
go.root_spec = {
	"lsp",
	{ ".git", "lua", ".obsidian", "package.json", "Makefile", "go.mod", "cargo.toml", "pyproject.toml", "src" },
	"cwd",
}
-- Smoothscroll
if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end
