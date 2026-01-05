return {
  {
    "nvim-neotest/neotest",
    dependencies = { "marilari88/neotest-vitest" },
    opts = {
      adapters = {
        ["neotest-vitest"] = {
          -- Custom function to find the package root (replaces the broken require)
          cwd = function(path)
            -- Search upward for package.json or vitest config
            local root_file = vim.fs.find({ "package.json", "vitest.config.ts", "vitest.config.js" }, {
              upward = true,
              path = path,
              stop = vim.loop.os_homedir(), -- Stop searching at home dir
            })[1]

            -- Return the directory of the found file, or default to current working directory
            return root_file and vim.fs.dirname(root_file) or vim.fn.getcwd()
          end,

          -- Optional: Filter out node_modules for performance
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
        },
      },
    },
  },
}
