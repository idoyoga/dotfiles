require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "%.o$", "%.cache$", "%.class$" },
	layout_strategy = "horizontal",
	layout_config = { width = 0.9 },
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-q>"] = "send_to_qflist",
      },
	},
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden", -- Include hidden files
    },
  },
})

-- Speeds up fuzzy matching for large files or directories.
-- Enables advanced sorting and scoring for search results.
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')

vim.keymap.set('n', '<leader>fp', ":Telescope projects<CR>", { desc = "Find projects" })

-- Load Telescope's built-in functions
local builtin = require('telescope.builtin')

-- Helper function to get the parent directory
local function get_parent_dir()
  local cwd = vim.fn.getcwd()
  return vim.fn.fnamemodify(cwd, ":h") -- ":h" gives the parent directory
end

-- Find files in the current working directory
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({
    prompt_title = "< Find Files >",
	 cwd = vim.fn.getcwd(),  -- Restrict to current working directory
    -- cwd = get_parent_dir(),  -- Use parent dir as starting point
    hidden = true,          -- Include hidden files
  })
end, { desc = "Find files in parent directory and subdirectories" })

-- Global search with find files
vim.keymap.set('n', '<leader>o', function()
  require('telescope.builtin').find_files({
    prompt_title = "< Open File >",
    cwd = vim.fn.input("Path: ", vim.fn.getcwd(), "dir"),
    hidden = true, -- Include hidden files
  })
end, { desc = "Find files in any directory" })

-- Live Grep in the current working directory
vim.keymap.set('n', '<leader>lg', function()
  builtin.live_grep({
    prompt_title = "< Live Grep >",
	 cwd = vim.fn.getcwd(),  -- Restrict to current working directory
    -- cwd = get_parent_dir(),  -- Use parent dir as starting point
  })
end, { desc = "Search for text in parent directory and subdirectories" })

-- Global search with Live Grep
vim.keymap.set('n', '<leader>fg', function()
  require('telescope.builtin').live_grep({
    prompt_title = "< Search Content >",
    cwd = vim.fn.input("Path: ", vim.fn.getcwd(), "dir"),
  })
end, { desc = "Search file contents globally" })

-- Find files in git repository
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "Find files in Git repository" })

-- Keybind for workspace symbols
vim.keymap.set('n', '<leader>ws', function()
  builtin.lsp_workspace_symbols({
    prompt_title = "< Workspace Symbols >",
  })
end, { desc = "Search for workspace symbols using LSP" })

-- Browse code symbols from Treesitter
vim.keymap.set('n', '<leader>ts', require('telescope.builtin').treesitter, { desc = "Search symbols with Treesitter" })

-- Find files using the dropdown theme
vim.keymap.set('n', '<leader>fd', function()
  require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
    previewer = false, -- Disable file preview
    layout_config = { width = 0.8, height = 0.5 },
  }))
end, { desc = "Find files (dropdown theme)" })

-- Find neovim sessions
vim.keymap.set('n', '<leader>fs', ":Telescope session-lens<CR>", { desc = "Find sessions" })

-- Find references for symbol
vim.keymap.set('n', '<leader>fr', ":lua vim.lsp.buf.references()<CR>", { desc = "Find references to symbol" })
