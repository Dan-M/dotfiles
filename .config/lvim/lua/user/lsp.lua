local M = {}
M.config = function()
  local formatters = require 'lvim.lsp.null-ls.formatters'
  formatters.setup {
    {
      exe = 'prettierd',
      filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact',
        'javascript.jsx', 'typescript.tsx' },
    },
    {
      exe = 'stylua',
      filetypes = { 'lua' },
    },
  }

  local linters = require 'lvim.lsp.null-ls.linters'
  linters.setup {
    {
      exe = 'eslint_d',
      filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact',
        'javascript.jsx', 'typescript.tsx' },
    },
    {
      exe = 'luacheck',
      filetypes = { 'lua' },
    },
  }

  -- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { 'jdtls' })
  -- local opts = {
  --   -- use only .git as root to have the whole mvn hierarchy in one LSP server
  --   root_dir = function(fname)
  --     return require('lspconfig').util.root_pattern '.git'(fname)
  --   end,
  -- }
  -- require('lvim.lsp.manager').setup('jdtls', opts)

end
return M
