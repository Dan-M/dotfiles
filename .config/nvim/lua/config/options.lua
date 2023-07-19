-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local vim = vim
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Closing folds with h
vim.keymap.set("n", "h", function()
  local onIndentOrFirstNonBlank = vim.fn.virtcol(".") <= vim.fn.indent(".") + 1
  local shouldCloseFold = vim.tbl_contains(vim.opt_local.foldopen:get(), "hor")
  if onIndentOrFirstNonBlank and shouldCloseFold then
    local wasFolded = pcall(vim.cmd.normal, "zc")
    if wasFolded then
      return
    end
  end
  vim.cmd.normal({ "h", bang = true })
end, { desc = "h (+ close fold at BoL)" })

-- make search with closed folds better
opt.foldopen:remove({ "search" }) -- no auto-open when searching, since the following snippet does that better
vim.keymap.set("n", "/", "zn/", { desc = "Search & Pause Folds" })
vim.on_key(function(char)
  local key = vim.fn.keytrans(char)
  local searchKeys = { "n", "N", "*", "#", "/", "?" }
  local searchConfirmed = (key == "<CR>" and vim.fn.getcmdtype():find("[/?]") ~= nil)
  if not (searchConfirmed or vim.fn.mode() == "n") then
    return
  end
  local searchKeyUsed = searchConfirmed or (vim.tbl_contains(searchKeys, key))

  local pauseFold = vim.opt.foldenable:get() and searchKeyUsed
  local unpauseFold = not (vim.opt.foldenable:get()) and not searchKeyUsed
  if pauseFold then
    vim.opt.foldenable = false
  elseif unpauseFold then
    vim.opt.foldenable = true
    vim.cmd.normal("zv") -- after closing folds, keep the *current* fold open
  end
end, vim.api.nvim_create_namespace("auto_pause_folds"))
