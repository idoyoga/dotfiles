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

	{"nvim-treesitter/nvim-treesitter"},
	{"mbbill/undotree"},
	{"tpope/vim-fugitive"},
	{"nvim-lualine/lualine.nvim"},
--LSP
	{"neovim/nvim-lspconfig"},
	{"williamboman/mason.nvim"},
	{"williamboman/mason-lspconfig.nvim"},
	{"hrsh7th/nvim-cmp"},
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

-- GitHub Copilot Plugin
--    {
--        "github/copilot.vim",
--        config = function()
            -- Optionally, you can add Copilot-specific settings here
--        end
--    },

-- Add presence.nvim plugin
    {
        "andweeb/presence.nvim",
        config = function()
            require("presence"):setup({
                -- Optional configuration settings here
                -- You can specify Neovim activity events, custom client IDs, etc.
    auto_update = true,  -- Enable auto-updating of Discord status
 -- General settings
    neovim_image_text   = "Neovim",    -- Text displayed under the Neovim icon
    main_image          = "file",      -- Main image in Discord presence ("file" or "neovim")

    -- Rich Presence text options
    editing_text        = "Editing %s",-- Text when editing a file
    file_explorer_text  = "Browsing %s",-- Text when browsing a file
    git_commit_text     = "Committing changes",-- Text when making a git commit
    plugin_manager_text = "Managing plugins",-- Text when managing plugins
    reading_text        = "Reading %s", -- Text when in read-only mode
    line_number_text    = "Line %s out of %s", -- Line number text
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
})

