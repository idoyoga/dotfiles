vim.opt.guicursor = ""

vim.opt.nu = true				-- Absolute line numbers
vim.opt.relativenumber = true	-- Relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.hidden = true  -- Allow buffers to be hidden without being saved
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard by default

vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

-- Automatically create undo points after these keys
vim.api.nvim_set_keymap('i', '<Space>', '<Space><C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ';', ';<C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ':', ':<C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<CR>', '<CR><C-g>u', { noremap = true, silent = true })

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- vim.opt.colorcolumn = "80"

-- vim.opt.cursorline = true -- Make current line more apparent
