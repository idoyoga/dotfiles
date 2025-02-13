vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Moves selected lines up/down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- and re-indents them.

vim.keymap.set("n", "J", "mzJ`z") -- Joins current line with next one, preserving cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move content to the right of the cursor down one line
vim.keymap.set("n", "<leader>m", function()
  -- Get the current cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- Get the content of the current line
  local line = vim.fn.getline(row)
  -- Get the leading whitespace (indentation) of the current line
  local leading_whitespace = line:match("^%s*")
  -- Split the line at the cursor position
  local left = line:sub(1, col) -- Content before the cursor
  local right = line:sub(col + 1) -- Content from the cursor onward
  -- Set the current line with only the left part
  vim.fn.setline(row, left)
  -- Append the right part as a new line below, with indentation
  vim.fn.append(row, leading_whitespace .. right)
  -- Move the cursor to the same position in the new line
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end, { desc = "Move content to the right of the cursor down one line" })

-- Add a newline in normal mode below without moving cursor
vim.keymap.set('n', '<leader>n', function()
  vim.api.nvim_buf_set_lines(0, vim.fn.line('.'), vim.fn.line('.'), true, { '' })
end, { desc = 'Add a newline below without moving' })

-- Add a newline in normal mode above without moving cursor
vim.keymap.set('n', '<leader>N', function()
  vim.api.nvim_buf_set_lines(0, vim.fn.line('.') - 1, vim.fn.line('.') - 1, true, { '' })
end, { desc = 'Add a newline above without moving' })

-- greatest remap ever
vim.keymap.set("x", "<leader>P", [["_dP]]) -- Pastes over selected text without overwriting def reg

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])  -- Yanks text to sys clipboard in normal
vim.keymap.set("n", "<leader>Y", [["+Y]])			-- and visual mode

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])	-- Deletes text without overwriting def reg

vim.keymap.set("i", "<C-d>", "<Esc>")

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format) -- Formats current file using LSP formatting


-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz") -- Navigates through quickfix lists while
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz") -- keeping the view centered
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- Same for location lists
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Search and replace for word unter the cursor across the entire file

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- Makes current file exexecutable (great for scripts)

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader><leader>", function()	-- Reloads current nvim config file
	vim.cmd("so")
end)

-- Mapping Ctrl + l to move the cursor right in insert mode
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Custom command to open nvim-tree
vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Pastes the content of the buffer to the next line
vim.keymap.set("n", "<leader>p", "mz:put =@+<CR>`[v`]=``", { noremap = true, silent = true })

-- Toogle ZenMode
vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle Zen Mode" })

-- Paste from system clipboard in normal mode
vim.keymap.set("n", "p", '"+p', { noremap = true, silent = true })  

-- Paste before the cursor
vim.keymap.set("n", "P", '"+P', { noremap = true, silent = true })  


-- Creates a new line below and pastes from the system clipboard
vim.keymap.set("n", "gp", "o<Esc>\"+p", { noremap = true, silent = true })

