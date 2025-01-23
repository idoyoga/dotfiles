require("lazy").setup({

	-- Various plugins
	{"mbbill/undotree"},
	{"tpope/vim-fugitive"},
	{"nvim-lualine/lualine.nvim"},
	{"andweeb/presence.nvim"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-buffer"},
	{"hrsh7th/cmp-path"},
	{"saadparwaiz1/cmp_luasnip"},
	{"L3MON4D3/LuaSnip"},
	{"rafamadriz/friendly-snippets"},
	{"Diogo-ss/42-header.nvim"},
	{"tpope/vim-commentary"},
	{"christoomey/vim-tmux-navigator"},
	{"lewis6991/gitsigns.nvim"},
	{"m4xshen/autoclose.nvim"},
	{"nvim-tree/nvim-web-devicons"},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Manage and restore Neovim sessions
	{
	  "rmagatti/auto-session",
	  config = function()
		vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,localoptions"
		require("auto-session").setup({
		  log_level = "info",
		  auto_session_enable_last_session = false,
		  auto_restore_enabled = false,
		  auto_session_suppress_dirs = { "~/", "~/Downloads" },
		})
	  end,
	},

	{
	  "rmagatti/session-lens",
	  dependencies = "rmagatti/auto-session",
	},

	-- Switch between projects using Telescope
	{
	  "ahmedkhalf/project.nvim",
	  config = function()
		require("project_nvim").setup({
		  manual_mode = false, -- Automatically detect projects
		  patterns = { ".git",  "Makefile", "package.json" },
		  detection_methods = { "pattern", "lsp" },
		})
	  end,
	},

	-- Autosave
	{
		"brianhuster/autosave.nvim",
		event="InsertEnter",
		opts = {} -- Configuration here
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim"},
	},

	-- Catppuccin Colourscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		version = "0.9.2",
		config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc" },
            highlight = { enable = true },
			indent = { enable = true },
			})
		end,
	},

	-- LSP Config
	{
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
    config = function()
        -- Setup capabilities for LSP, including cmp-nvim-lsp for autocompletion
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.offsetEncoding = { "utf-16" } -- Required for clangd

        -- Function to define LSP-specific key mappings
        local on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, silent = true, noremap = true }
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts) -- Rename symbol
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)   -- Go to definition
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)         -- Hover documentation
        end

        -- Mason setup
        require("mason").setup()

        -- Mason-LSPConfig setup
        require("mason-lspconfig").setup({
            ensure_installed = { "clangd" }, -- Install clangd via Mason
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
						root_dir = require("lspconfig").util.root_pattern("compile_commands.json", ".git"),
                    })
                end,
            },
        })

        -- Ensure clangd has the correct setup
        require("lspconfig").clangd.setup({
            cmd = {
                "clangd",
                "--background-index",       -- Enable background indexing
                "--clang-tidy",             -- Enable clang-tidy diagnostics
                "--compile-commands-dir=build", -- Set build directory for compile_commands.json
            },
			root_dir = function(fname)
				local util = require("lspconfig.util")
				return util.root_pattern("compile_commands.json", ".git")(fname) or util.path.dirname(fname)
			end,
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
	},

	-- nvim-cmp
	{
	"hrsh7th/nvim-cmp",
	dependencies = {"hrsh7th/cmp-nvim-lsp"},
	},

	-- Nvim Tree
	{
    "nvim-tree/nvim-tree.lua",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = { width = 16 },
            renderer = {
                group_empty = true,
                highlight_opened_files = "none",
            },
            filters = {
                dotfiles = true,
            },
            -- actions = {
            --     change_dir = { enable = true },
            --     open_file = {
            --         window_picker = {
            --             enable = false,
            --         },
            --     },
            -- },
        })
    end,
	},

	-- LSP Signature plugin --
	{
	  'ray-x/lsp_signature.nvim',
	  config = function()
		require('lsp_signature').setup({
		  bind = true,
		  floating_window = false,
		  hint_enable = false,
		})
	  end,
	},

	-- nvim-surround plugin
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
		  require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		  })
		end
	  },

	-- GitHub Copilot plugin
	{
		"github/copilot.vim",
		config = function()
			-- Enable Copilot for C and C++
			vim.g.copilot_filetypes = {
				['*'] = false, -- Disable for all filetypes by default
				['c'] = true,  -- Enable for C
				['cpp'] = true, -- Enable for C++
			}
			  -- Make sure Tab is free for Copilot to use
			vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
			  expr = true,
			  replace_keycodes = false
			})
			vim.g.copilot_no_tab_map = true
		end,
	},
})
