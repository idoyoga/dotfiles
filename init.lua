vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- Map a key to insert header (replace '<leader>h' with your preferred key mapping)
vim.api.nvim_set_keymap('n', '<F1>', ':lua require("header42").add_header()<CR>', { noremap = true, silent = true })

-- Enable clipboard support
vim.cmd('set clipboard+=unnamedplus')

require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.plugin_config")
