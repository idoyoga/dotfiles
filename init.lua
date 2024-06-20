-- Set tabstop to 4 spaces
vim.o.tabstop = 4
-- Set shiftwidth to 4 spaces
vim.o.shiftwidth = 4

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

vim.api.nvim_set_keymap('n', '<C-c>', ':NvimTreeClose<CR>', { noremap = true, silent = true })

require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.plugin_config")
