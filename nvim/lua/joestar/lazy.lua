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
})

