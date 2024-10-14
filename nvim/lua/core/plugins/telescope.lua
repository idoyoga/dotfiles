require("telescope").setup({
  defaults = {
    -- Use ripgrep for searching (respects .gitignore)
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',              -- Include hidden files in the search
      '--glob', '!.git/*',      -- Exclude the .git folder
      '--glob', '!node_modules/*',  -- Exclude node_modules folder
    },
    -- Ignore specific files and directories
    file_ignore_patterns = {
      "node_modules/.*",         -- Ignore node_modules folder
      "%.log$",                  -- Ignore log files
      "%.tmp$",                  -- Ignore temporary files
      "%.git/",                  -- Ignore the .git directory
      "dist/",                   -- Ignore dist folder
      "coverage/",               -- Ignore coverage folder
    },
    -- Other Telescope defaults
    path_display = { "truncate" }, -- Truncate file paths for cleaner display
  },
})

local builtin = require('telescope.builtin')

-- Map keybindings
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({
    prompt_title = "< Find Files >",
    cwd = vim.fn.getcwd(),  -- Restrict to current working directory
    hidden = true,          -- Include hidden files
  })
end, {})

vim.keymap.set('n', '<leader>fg', function()
  builtin.live_grep({
    prompt_title = "< Live Grep >",
    cwd = vim.fn.getcwd(),  -- Restrict to current working directory
  })
end, {})

vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- require("telescope").setup({
-- 	file_ignore_patterns = {
-- 		"node%_modules/.*"
-- 	}
-- })

-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
