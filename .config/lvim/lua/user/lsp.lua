-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    exe = "eslint",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

-- THIS DOESNT WORK FOR SOME UNKNOWN REASON
-- vim.list_extend(lvim.lsp.override, { "java" })
-- local opts = {
--   -- use only .git as root to have the whole mvn hierarchy in on LSP server
--   root_dir = require('jdtls.setup').find_root({ ".git" })
-- }
-- require("lvim.lsp.manager").setup("java", opts)

