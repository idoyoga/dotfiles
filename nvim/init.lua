local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
vim.keymap.set('n', '<c-n>', ':NvimTreeFindFile<CR>')

require ("joestar")
require ("joestar.plugins")
require ("joestar.lazy")
require ("joestar.remaps")
require ("joestar.settings")
