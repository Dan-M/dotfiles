-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- temporary fix for https://github.com/LazyVim/LazyVim/issues/2005
if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    if vim.lsp.inlay_hint.is_enabled() then
      vim.lsp.inlay_hint.enable(0, false)
    else
      vim.lsp.inlay_hint.enable(0, true)
    end
  end, { desc = "Toggle Inlay Hints" })
end
