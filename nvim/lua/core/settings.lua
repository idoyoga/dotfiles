vim.opt.guicursor = ""

vim.opt.nu = true				-- Absolute line numbers
vim.opt.relativenumber = true	-- Relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.cmd [[
  autocmd FileType c setlocal cindent cinoptions=:0,l1,t0,g0,(0
]]

-- vim.opt.colorcolumn = "80"

-- vim.opt.cursorline = true -- Make current line more apparent
