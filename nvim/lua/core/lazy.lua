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
	  config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
		  check_ts = true, -- Enable Treesitter integration
		  enable_check_bracket_line = false, -- Avoids auto-misplacing brackets
		  ignored_next_char = "[%w%.]", -- Prevents auto-inserting pairs in words
		  fast_wrap = {},
		})

		local Rule = require("nvim-autopairs.rule")

		-- Remove conflicting default rules for `{`
		npairs.clear_rules("{")

		-- Add custom rule to ensure correct `{}` indentation in C
		npairs.add_rules({
		  Rule("{", "}", "c")
			:with_pair(function(opts)
			  local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
			  return prev_char:match("[%s%(%{%[]") ~= nil
			end)
			:with_move(function(opts)
			  return opts.char == "}"
			end)
			:with_cr(function()
			  return true  -- Ensures `{}` is properly formatted when pressing Enter
			end)
			:use_key("{"),
		})
	  end
	}
	,
	
	-- LSP setup with clangd
	{
	  "williamboman/mason.nvim",
	  dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
	  config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
		  ensure_installed = { "clangd" },
		  handlers = {
			function(server_name)
			  require("lspconfig")[server_name].setup({
				on_attach = function(client, bufnr)
				  local opts = { buffer = bufnr, silent = true, noremap = true }
				  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				end,
				capabilities = { offsetEncoding = { "utf-16"} },
				cmd = { 
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--compile-commands-dir=" .. vim.fn.getcwd(), -- Ensure it points to the correct dir
				"--fallback-style=LLVM" -- Ensures a default formatting style
				},
				filetypes = { "c", "cpp" },  -- Ensure clangd runs for C and C++
                root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
				flags = { allow_incremental_sync = false },
			  })
			end,
		  },
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
		version = "0.9.2",
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
