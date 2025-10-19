require("lazy").setup({

	-- Core utilities
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "andweeb/presence.nvim" },
	{ "Diogo-ss/42-header.nvim" },
	{ "christoomey/vim-tmux-navigator" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- Productivity
	{ "tpope/vim-commentary" },
	{ "lewis6991/gitsigns.nvim" },
	{ "folke/zen-mode.nvim", opts = {} },
	{ "rmagatti/auto-session", config = function()
		require("auto-session").setup({ auto_restore_enabled = false })
	  end,
	},
	{ "ahmedkhalf/project.nvim", config = function()
		require("project_nvim").setup({ manual_mode = false,
		  patterns = { ".git", "Makefile" },
		  detection_methods = { "pattern", "lsp" } })
	  end,
	},
	{ "windwp/nvim-autopairs",
	  event = "InsertEnter",
	  config = true
	},

	-- LSP setup with clangd

-- 	-- Mason core
-- 	{ "williamboman/mason.nvim", config = true },

-- 	-- Mason–LSP bridge (separate entry!)
-- 	{
-- 	  "williamboman/mason-lspconfig.nvim",
-- 	  dependencies = { "neovim/nvim-lspconfig" },
-- 	  config = function()
-- 		require("mason-lspconfig").setup({
-- 		  automatic_installation = false,
-- 		})

-- 		-- Modern handler registration (v2+ API)
-- 		require("mason-lspconfig").setup_handlers({
-- 		  function(server_name)
-- 			vim.lsp.enable(server_name, {
-- 			  capabilities = require("cmp_nvim_lsp").default_capabilities(),
-- 			  on_attach = function(_, bufnr)
-- 				local opts = { buffer = bufnr, silent = true, noremap = true }
-- 				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- 				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
-- 			  end,
-- 			})
-- 		  end,
-- 		  ["clangd"] = function() end,
-- 		})
-- 	  end,
-- 	},

	{
	  "williamboman/mason.nvim",
	  dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
	  config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
		  automatic_installation = false, -- disables implicit LSP auto-config
		  handlers = {
			-- prevent auto-setup for clangd entirely
				["clangd"] = function() end,
				}, -- disables mason-lspconfig handlers entirely
		})
	  end,
	},

	-- Completion & LSP
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-nvim-lsp"} },
	{ "ray-x/lsp_signature.nvim", config = function()
		require('lsp_signature').setup({ floating_window = false, hint_enable = false })
	  end
	},

	-- Treesitter for better syntax highlighting
	{ "nvim-treesitter/nvim-treesitter",
		-- version = "0.9.2",
		config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc" },
            highlight = { enable = true },
			indent = { enable = true } })
		end,
	},

	-- Telescope (Improved Fuzzy Finder)
	{ "nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim"},
	},

	-- Nvim-surround plugin
	{ "kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
		  require("nvim-surround").setup({
			-- Configuration to be implemented soon
		  })
		end,
	  },

	-- Lualine (Status Line)
	{
	  "nvim-lualine/lualine.nvim",
		config = function()
		require("lualine").setup({ options = { theme = "catppuccin" } })
	  end,
	},

	-- File Explorer (nvim-tree)
	{
    "nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = { width = 16 },
            renderer = { group_empty = true },
            filters = { dotfiles = true },
            actions = {
				change_dir = { enable = true },
                open_file = { window_picker = { enable = false } },
            },
		on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
		 -- Default Mappings
        vim.keymap.set("n", "a", api.fs.create, opts("Create File/Directory"))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete File")) -- Delete
        vim.keymap.set("n", "e", api.fs.rename, opts("Rename File")) -- Rename
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open File"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open File"))
        vim.keymap.set("n", "q", api.tree.close, opts("Close Tree"))
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open File (Mouse)"))
		vim.keymap.set("n", "h", api.tree.toggle_hidden_filter, opts("Toggle Hidden Files")) -- Toggle hidden files
        -- Custom Mappings
        vim.keymap.set("n", "m", api.fs.cut, opts("Cut File"))
        vim.keymap.set("n", "p", api.fs.paste, opts("Paste File"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy File"))
        vim.keymap.set("n", "Y", function()
            local node = api.tree.get_node_under_cursor()
            if node and node.absolute_path then
                vim.fn.setreg("+", node.absolute_path)
                vim.notify("Copied: " .. node.absolute_path)
            else
                vim.notify("No file selected or path unavailable!", vim.log.levels.WARN)
            end
        end, opts("Copy Absolute Path"))    end,
        })
    end,
	},

	-- GitHub Copilot
	{ "github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = { ['*'] = false, ['c'] = true, ['cpp'] = true }
			vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
			vim.g.copilot_no_tab_map = true
		end,
	},

	-- Optional: Remove if unnecessary
	-- {"L3MON4D3/LuaSnip"},
	-- {"saadparwaiz1/cmp_luasnip"},
	-- {"hrsh7th/cmp-buffer"},
	-- {"rafamadriz/friendly-snippets"},
})

-- Manual clangd setup (modern API, Neovim 0.11+)
vim.lsp.config('clangd', {
	on_attach = function(client, bufnr)
		-- Kill all other clangd clients except this one
		for _, other_client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			if other_client.name == "clangd" and other_client.id ~= client.id then
				vim.lsp.stop_client(other_client.id)
			end
		end

		print("LSP attached to buffer:", bufnr)
		local opts = { buffer = bufnr, silent = true, noremap = true }

		-- Disable inlay hints if supported
		if vim.lsp.buf.inlay_hint then
			vim.lsp.buf.inlay_hint(bufnr, false)
		end

		-- Smart rename
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Smart go-to-definition
		vim.keymap.set("n", "<leader>gd", function()
			local params = vim.lsp.util.make_position_params(0, "utf-16")
			vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
				if err or not result or vim.tbl_isempty(result) then
					vim.notify("Definition not found", vim.log.levels.WARN)
					return
				end
				if #result == 1 then
					vim.lsp.util.jump_to_location(result[1], "utf-16")
				else
					vim.fn.setqflist({}, ' ', {
						title = 'LSP Definitions',
						items = vim.lsp.util.locations_to_items(result, "utf-16"),
					})
					vim.cmd("copen")
				end
			end)
		end, opts)

		-- Hover
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	end,

	capabilities = { offsetEncoding = { "utf-16" } },

	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--compile-commands-dir=" .. vim.fn.getcwd() .. "/build",
		"--fallback-style=LLVM",
		"--header-insertion=never",
		"--completion-style=detailed",
	},

	filetypes = { "c", "cpp" },
	root_dir = vim.fs.dirname(vim.fs.find({ "compile_commands.json", ".git" }, { upward = true })[1]),
	flags = { allow_incremental_sync = false },
	init_options = {
		clangdFileStatus = false,
		inlayHints = false,
	},
})

-- -- Manual clangd setup (bypasses mason-lspconfig)
-- require("lspconfig").clangd.setup({
-- on_attach = function(client, bufnr)
--   -- Kill all other clangd clients except this one
--   for _, other_client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
--     if other_client.name == "clangd" and other_client.id ~= client.id then
--       vim.lsp.stop_client(other_client.id)
--     end
--   end

--   print("LSP attached to buffer:", bufnr)
--   local opts = { buffer = bufnr, silent = true, noremap = true }

--   -- Disable inlay hints if supported
--   if vim.lsp.buf.inlay_hint then
--     vim.lsp.buf.inlay_hint(bufnr, false)
--   end

--   -- Smart rename
--   vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

--   -- Smart go-to-definition
--   vim.keymap.set("n", "<leader>gd", function()
--     local params = vim.lsp.util.make_position_params(0, "utf-16")
--     vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
--       if err or not result or vim.tbl_isempty(result) then
--         vim.notify("Definition not found", vim.log.levels.WARN)
--         return
--       end
--       if #result == 1 then
--         vim.lsp.util.jump_to_location(result[1], "utf-16")
--       else
--         vim.fn.setqflist({}, ' ', {
--           title = 'LSP Definitions',
--           items = vim.lsp.util.locations_to_items(result, "utf-16"),
--         })
--         vim.cmd("copen")
--       end
--     end)
--   end, opts)

--   -- Hover
--   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- end,
--   capabilities = { offsetEncoding = { "utf-16" } },

--   cmd = {
--     "clangd",
--     "--background-index",
--     "--clang-tidy",
--     "--compile-commands-dir=" .. vim.fn.getcwd() .. "/build",
--     "--fallback-style=LLVM",
--     "--header-insertion=never",
--     "--completion-style=detailed",
--   },

--   filetypes = { "c", "cpp" },
--   root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
--   flags = { allow_incremental_sync = false },
-- 	init_options = {
-- 	  clangdFileStatus = false,  -- disables extra status in command area
-- 	  inlayHints = false,        -- disables inlay hints (parameter info)
-- 	},
-- })

-- 🔧 Configure diagnostics globally (error signs, virtual text, etc.)
vim.diagnostic.config({
  virtual_text = true,   -- inline text for errors/warnings
  signs = true,          -- show E, W, etc. in the sign column
  underline = true,      -- underline problem text
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

local update_file = vim.fn.stdpath("data") .. "/lazy_update_timestamp"

local function should_update_lazy()
    -- Ensure the file exists before reading it
    if vim.fn.filereadable(update_file) == 0 then
        vim.fn.writefile({ "0" }, update_file) -- Create the file if missing
    end

    local last_update = tonumber(vim.fn.readfile(update_file)[1] or "0")
    local current_time = os.time()
    local one_day = 86400 -- Seconds in a day

    return (current_time - last_update > one_day)
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if should_update_lazy() then
            vim.defer_fn(function()
                vim.cmd("Lazy update")
                vim.fn.writefile({ tostring(os.time()) }, update_file) -- Save timestamp
            end, 500) -- Runs after 500ms to avoid slowing startup
        end
    end,
})
