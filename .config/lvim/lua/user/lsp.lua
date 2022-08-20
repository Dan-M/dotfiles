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

  vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { 'java' })
  local opts = {
    -- cmd = {
    --   '/usr/lib/jvm/java-17-openjdk/bin/java',
    --   '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    --   '-Dosgi.bundles.defaultStartLevel=4',
    --   '-Declipse.product=org.eclipse.jdt.ls.core.product',
    --   '-Dlog.protocol=true',
    --   '-Dlog.level=ALL',
    --   '-Xms1g',
    --   '-Xmx2G',
    --   '--add-modules=ALL-SYSTEM',
    --   '--add-opens',
    --   'java.base/java.util=ALL-UNNAMED',
    --   '--add-opens',
    --   'java.base/java.lang=ALL-UNNAMED',
    --   '-jar',
    --   '/plugins/org.eclipse.equinox.launcher_*.jar',
    --   '-configuration',
    --   'config_linux',
    --   '-data',
    --   '/home/dan/workspace',
    -- },

    -- use only .git as root to have the whole mvn hierarchy in one LSP server
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern '.git'(fname)
    end,
  }
  require('lvim.lsp.manager').setup('jdtls', opts)
end
return M
