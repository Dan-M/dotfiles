local M = {}

M.config = function()
  local status_ok, neuron = pcall(require, "neuron")

  if not status_ok then
    return
  end
  neuron.setup {
    virtual_titles = true,
    mappings = true,
    run = nil,
    neuron_dir = "~/neuron",
    leader = "gz",
  }
end

lvim.builtin.which_key.mappings["gz"] = {
  name = "Zettelkasten",
  i = { "<cmd>lua require'neuron'.goto_index()<cr>", "Index" },
--  ] = { "require'neuron'.goto_prev_extmark()", "Previous Ext Mark" },
--  [ = { "require'neuron'.goto_next_extmark()", "Next Ext Mark" },
--  <CR> = { "require'neuron'.enter_link(), Show linked note" },
  B = { "<cmd>lua require'neuron/telescope'.find_backlink()<cr>", "Find Backlinks" },
  s = { "<cmd>lua require'neuron'.rib()<cr>", "Serve" },
  t = { "<cmd>lua require'neuron/telescope'.find_tags()<cr>", "Find Tags" },
  z = { "<cmd>lua require'neuron/telescope'.find_zettels()<cr>", "Find Zettels" },

}
return M
