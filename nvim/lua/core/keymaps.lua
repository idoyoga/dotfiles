vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Moves selected lines up/down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- and re-indents them.

vim.keymap.set("n", "J", "mzJ`z") -- Joins current line with next one, preserving cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- Pastes over selected text without overwriting def reg

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])  -- Yanks text to sys clipboard in normal
vim.keymap.set("n", "<leader>Y", [["+Y]])			-- and visual mode

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])	-- Deletes text without overwriting def reg

vim.keymap.set("i", "<C-d>", "<Esc>")

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format) -- Formats current file using LSP formatting

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz") -- Navigates through quickfix lists while
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz") -- keeping the view centered
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- Same for location lists
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Search and replace for word unter the cursor across the entire file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- Makes current file exexecutable (great for scripts)

vim.keymap.set(
	"n",
	"<leader>ee",
	"oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader><leader>", function()	-- Reloads current nvim config file
	vim.cmd("so")
end)

-- Mapping Ctrl + l to move the cursor right in insert mode
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Custom command to open nvim-tree
vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ar', function()
  local word = vim.fn.expand("<cword>")
  local new_word = vim.fn.input("Replace " .. word .. " with: ")
  vim.cmd("args **/*")       -- Load all files into the argument list
  vim.cmd("argdo %s/" .. word .. "/" .. new_word .. "/g | update") -- Replace in all files
end, { desc = "Replace name globally across all files" })

