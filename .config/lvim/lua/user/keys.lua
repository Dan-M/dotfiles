local M = {}
M.config = function()
  -- keymappings [view all the defaults by pressing <leader>Lk]
  lvim.leader = "space"


  -- mappings
  lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
  lvim.keys.normal_mode["<A-j>"] = ":m .+1<CR>=="
  lvim.keys.normal_mode["<A-k>"] = ":m .-2<CR>=="
  lvim.keys.normal_mode["bd"] = ":BufferKill<CR>"
  lvim.keys.normal_mode["bo"] = ":BufferLineCloseLeft<CR>; BufferLineCloseRight<CR>"
  lvim.keys.normal_mode["tf"] = ":TestFile<CR>"
  lvim.keys.normal_mode["<A-j>"] = ":m .+1<CR>=="
  lvim.keys.normal_mode["<A-t>"] = ":ToggleTerm<CR>"

  -- harpoon
  lvim.keys.normal_mode["<leader>ja"] = "<Cmd> lua require('harpoon.mark').add_file()<CR>"
  lvim.keys.normal_mode["<leader>jl"] = ":Telescope harpoon marks<CR>"
  lvim.keys.normal_mode["<leader>jn"] = "<Cmd> lua require('harpoon.ui').nav_next()<CR>"
  lvim.keys.normal_mode["<leader>jp"] = "<Cmd> lua require('harpoon.ui').nav_prev()<CR>"
  -- Which keys
  lvim.builtin.which_key.mappings.l.d = { "<cmd>TroubleToggle<cr>", "Diagnostics" }
  lvim.builtin.which_key.mappings.l.R = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
  lvim.builtin.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
  lvim.builtin.which_key.mappings.g.n = { "<cmd>Neogit<cr>", "Neogit" }
  lvim.builtin.which_key.mappings["t"] = {
    name = "Test",
    f = { "<cmd>TestFile<cr>", "Test File" },
    n = { "<cmd>TestNearest<cr>", "Test Nearest" },
  }
  lvim.builtin.which_key.mappings["o"] = {
    name = "Octo Github",
    p = { "<cmd>Octo pr list<cr>", "List PRs" },
    i = { "<cmd>Octo issue list <cr>", "List Issues" },
  }


end

return M
