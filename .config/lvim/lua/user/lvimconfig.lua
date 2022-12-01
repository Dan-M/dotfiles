local M = {}
M.config = function()
  -- configuration of lvim builtin
  lvim.builtin.alpha.active = true
  lvim.builtin.terminal.active = true
  lvim.builtin.nvimtree.side = "left"
--  lvim.builtin.nvimtree.show_icons.git = 0

  lvim.builtin.treesitter.ensure_installed = "all"
  lvim.builtin.treesitter.ignore_install = { "haskell", "hlsl" }
  lvim.builtin.treesitter.highlight.enabled = true

  -- lvim.builtin.project.detection_methods = { "pattern", "lsp" }
  -- lvim.builtin.project.patterns = { "package.json", ".git" }

  -- Telescope ignore patterns
  lvim.builtin.telescope.defaults.file_ignore_patterns = {
    "%.lock",
    "%.ipynb",
    "node_modules/*",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    ".git/",
    "%.webp",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "node_modules/",
    "target/",
  }
  lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, 'howdoi');
    pcall(telescope.load_extension, 'harpoon');
    -- any other extensions loading
  end
end
return M;
