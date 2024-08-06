vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Custom command to open nvim-tree
vim.cmd([[ command! -nargs=* E NvimTreeToggle ]])

-- Keybinding for header42
vim.api.nvim_set_keymap('n', '<F1>', ':lua require("header42").add_header()<CR>', { noremap = true, silent = true })

-- Enable clipboard support
vim.cmd('set clipboard+=unnamedplus')

require("core.options")
require("core.keymaps")
require("core.plugins")

-- Load plugin-specific configurations
-- Assuming you have files for each plugin inside `plugin_config/`
local plugin_config_dir = vim.fn.stdpath('config') .. '/lua/core/plugin_config/'
local plugin_configs = { 'lualine', 'nvim-tree', 'telescope', 'colorscheme', 'treesitter', 'vim-test', 'completions', 'mason', 'lsp_config', 'gitsigns', 'copilot', 'oil', 'markdown_preview', 'swagger-preview', 'nvim-tree'} -- List your plugin config files here

for _, config in ipairs(plugin_configs) do
  local success, err = pcall(require, 'core.plugin_config.' .. config)
  if not success then
    print('Error loading plugin config: ' .. err)
  end
end
