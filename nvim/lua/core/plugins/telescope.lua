require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git" }, -- Ignore common folders
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

-- Load Telescope's built-in functions
local builtin = require('telescope.builtin')

-- Helper function to get the parent directory
local function get_parent_dir()
  local cwd = vim.fn.getcwd()
  return vim.fn.fnamemodify(cwd, ":h") -- ":h" gives the parent directory
end

-- Map keybindings
vim.keymap.set('n', 'ff', function()
  builtin.find_files({
    prompt_title = "< Find Files >",
 -- cwd = vim.fn.getcwd(),  -- Restrict to current working directory
    cwd = get_parent_dir(),  -- Use parent dir as starting point
    hidden = true,          -- Include hidden files
  })
end, { desc = "Find files in parent directory and subdirectories" })

vim.keymap.set('n', 'lg', function()
  builtin.live_grep({
    prompt_title = "< Live Grep >",
 -- cwd = vim.fn.getcwd(),  -- Restrict to current working directory
    cwd = get_parent_dir(),  -- Use parent dir as starting point
  })
end, { desc = "Search for text in parent directory and subdirectories" })

vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find files in Git repository" })

-- Keybind for workspace symbols
vim.keymap.set('n', 'ws', function()
  builtin.lsp_workspace_symbols({
    prompt_title = "< Workspace Symbols >",
  })
end, { desc = "Search for workspace symbols using LSP" })
