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
vim.opt.clipboard = "unnamedplus"
vim.opt.tags = "./tags,./.tags,./.git/tags,tags"

require ("core")
require ("core.plugins")
require ("core.lazy")
require ("core.keymaps")
require ("core.settings")
