require("lazy").setup({
	{
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {"nvim-lua/plenary.nvim"}
	},
	{
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = "0.9.2",
		-- build = ":TSUpdate",
		config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc" },
            highlight = { enable = true },
			indent = { enable = true },
			})
		end
	},
	{"mbbill/undotree"},
	{"tpope/vim-fugitive"},
	{"nvim-lualine/lualine.nvim"},
	{"andweeb/presence.nvim"},
	-- {"IogaMaster/neocord"},
--LSP
	-- {"neovim/nvim-lspconfig"},
	-- {"hrsh7th/nvim-cmp"},

    -- LSP Config for C/C++ (clangd)

{
    "neovim/nvim-lspconfig",
    config = function()
        require("lspconfig").clangd.setup({
            cmd = {
                "clangd",
                "--background-index", -- Enables background indexing of the entire project
                "--clang-tidy",       -- Use clang-tidy for diagnostics
                -- Remove or update the directory for compile_commands.json as needed
                -- "--compile-commands-dir=build"
            },
            root_dir = require('lspconfig').util.root_pattern("compile_commands.json", ".git"),
            capabilities = vim.tbl_extend(
                "force",
                require("cmp_nvim_lsp").default_capabilities(),
                { offsetEncoding = { "utf-16" } } -- Ensuring consistent encoding
            ),
            on_attach = function(client, bufnr)
                -- Optional: Any LSP-specific key mappings or settings
            end,
        })
    end
},

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
	                ["<C-k>"] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                },
            })
        end
    },
	{"williamboman/mason.nvim"},
	{"williamboman/mason-lspconfig.nvim"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-buffer"},
	{"hrsh7th/cmp-path"},
	{"saadparwaiz1/cmp_luasnip"},
	{"L3MON4D3/LuaSnip"},
	{"rafamadriz/friendly-snippets"},
	{'Diogo-ss/42-header.nvim'},
	"tpope/vim-commentary",
	"christoomey/vim-tmux-navigator",
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"lewis6991/gitsigns.nvim",
	"m4xshen/autoclose.nvim",
	{
    "nvim-tree/nvim-tree.lua",
    requires = "nvim-tree/nvim-web-devicons", -- Optional, for file icons
    config = function()
      require("nvim-tree").setup {}
    end
  },
	-- LSP Signature plugin --
{
  'ray-x/lsp_signature.nvim',
  config = function()
    require('lsp_signature').setup({
      bind = true,
      floating_window = true,
      hint_enable = false,
    })
  end
},

  -- nvim-surround plugin
  {
    "kylechui/nvim-surround",
--    event = "VeryLazy", -- Optionally lazy-load on specific events
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
