-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local vim = vim

local function augroup(name)
  return vim.api.nvim_create_augroup("dan-m_" .. name, { clear = true })
end
-- open all folds initially
-- vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
--  group = augroup("open_folds"),
--  callback = function()
--    vim.cmd("normal zR")
--  end,
-- })
