# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim), a starter template that provides a comprehensive Neovim setup with lazy-loaded plugins managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Architecture

### Entry Point & Plugin System

- **init.lua**: Single-line bootstrap that loads `config.lazy`
- **lua/config/lazy.lua**: Sets up lazy.nvim plugin manager, bootstraps installation if needed, and configures plugin loading behavior
  - Automatically clones lazy.nvim on first run
  - Loads LazyVim base plugins via `{ "LazyVim/LazyVim", import = "lazyvim.plugins" }`
  - Imports all user plugins from `lua/plugins/` directory
  - Checker enabled to detect plugin updates (without notifications)

### Configuration Structure

LazyVim follows a convention-based structure where files are automatically loaded:

- **lua/config/options.lua**: Neovim options (extends LazyVim defaults)
- **lua/config/keymaps.lua**: Custom keybindings (extends LazyVim defaults)
- **lua/config/autocmds.lua**: Autocommands (extends LazyVim defaults)
- **lua/plugins/**: Each `.lua` file defines plugin specs (see plugin customization below)

### Installed LazyVim Extras

The following extra modules are enabled (see `lazyvim.json`):
- **AI Tools**: avante, claudecode, copilot
- **Coding**: yanky (yank history)
- **Editor**: fzf, harpoon2, mini-files
- **Formatting**: biome, prettier
- **Languages**: ansible, docker, git, json, markdown, tailwind, toml, typescript
- **Linting**: eslint
- **UI**: mini-animate
- **Utilities**: gh (GitHub CLI integration)

### Plugin Customization Pattern

Plugins are customized by creating spec files in `lua/plugins/`. Each file returns a table (or array of tables) with plugin configurations. LazyVim uses lazy.nvim's plugin spec format:

1. **Add new plugins**: `{ "author/plugin-name" }`
2. **Override LazyVim plugin options**: Target the plugin name and provide `opts` (merged) or `opts = function()` (replaced)
3. **Disable plugins**: `{ "plugin-name", enabled = false }`
4. **Add dependencies**: Use `dependencies = { ... }`
5. **Add/override keymaps**: Use `keys = { ... }`

The `lua/plugins/example.lua` file contains extensive commented examples (currently disabled with `if true then return {} end`).

## Code Formatting

- **Lua formatter**: stylua
- **Config**: `stylua.toml` specifies 2-space indentation and 120 column width
- **Format command**: `stylua .` (formats all Lua files)

## Key Concepts

### Plugin Loading Strategy

- LazyVim plugins are lazy-loaded by default (on events, commands, keys, etc.)
- Custom plugins in `lua/plugins/` are NOT lazy-loaded by default (`lazy = false` in lazy.lua)
- To make custom plugins lazy-loaded, set `lazy = true` in the plugin spec

### Configuration Override Pattern

LazyVim provides default configurations that can be extended rather than replaced:
- Options, keymaps, and autocmds: Add to the respective files in `lua/config/`
- Plugin options: Use `opts` for merging or `opts = function(_, opts)` to extend
- To remove LazyVim defaults, use the API (e.g., `vim.api.nvim_del_augroup_by_name()`)

### LazyVim Plugin Extras System

Extras are pre-configured plugin bundles that can be enabled in `lazyvim.json`. Each extra typically includes:
- The main plugin(s)
- LSP/treesitter configuration
- Recommended keybindings
- Integration with other LazyVim features

## Development Notes

- This config uses Lua LSP via neoconf/neodev (see `.neoconf.json`)
- The base LazyVim config provides sensible defaults for most workflows
- Custom modifications should be minimal and focused on personal preferences
- When troubleshooting, check LazyVim's upstream defaults first:
  - [Default options](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua)
  - [Default keymaps](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)
  - [Default autocmds](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua)
