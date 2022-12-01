-- excluded servers:
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

local M = {}
M.config = function()
  local formatters = require 'lvim.lsp.null-ls.formatters'
  formatters.setup {
    {
      exe = 'prettierd',
      filetypes = {
        'typescript',
        'typescriptreact',
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript.tsx',
      },
    },
    {
      exe = 'stylua',
      filetypes = { 'lua' },
    },
    {
      exe = 'shfmt',
      filetypes = { 'sh' },
    },
  }

  local linters = require 'lvim.lsp.null-ls.linters'
  linters.setup {
    {
      exe = 'eslint_d',
      filetypes = {
        'typescript',
        'typescriptreact',
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript.tsx',
      },
    },
    {
      exe = 'luacheck',
      filetypes = { 'lua' },
    },
    {
      exe = 'shellcheck',
      filetypes = { 'sh' },
    },
  }

end
return M
