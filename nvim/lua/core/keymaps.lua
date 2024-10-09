vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- This is going to get me cancelled
vim.keymap.set("i", "<C-d>", "<Esc>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-d>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
	"n",
	"<leader>ee",
	"oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
	-- ~/.config/nvim/lua/core/keymaps.lua

	-- Define keybindings for LSP commands
	vim.api.nvim_set_keymap('n', '<leader>gd', ':lua vim.lsp.buf.definition()<CR>', opts)               -- Go to definition
	vim.api.nvim_set_keymap('n', '<leader>gi', ':lua vim.lsp.buf.implementation()<CR>', opts)           -- Go to implementation
	vim.api.nvim_set_keymap('n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>', opts)               -- Find references
	vim.api.nvim_set_keymap('n', '<leader>gt', ':lua vim.lsp.buf.type_definition()<CR>', opts)          -- Go to type definition
	vim.api.nvim_set_keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)                   -- Rename symbol
	vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)              -- Code action
	vim.api.nvim_set_keymap('n', '<leader>h', ':lua vim.lsp.buf.hover()<CR>', opts)                     -- Hover information
	vim.api.nvim_set_keymap('n', '<leader>d', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts) -- Show diagnostics
	vim.api.nvim_set_keymap('n', '[d', ':lua vim.lsp.diagnostic.goto_prev()<CR>', opts)                 -- Go to previous diagnostic
	vim.api.nvim_set_keymap('n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>', opts)                 -- Go to next diagnostic
	--
	-- Keybinding for searching with Telescope
--	vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })

	-- Mapping Ctrl + l to move the cursor right in insert mode
	vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })
end)
-- Custom command to open nvim-tree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })

