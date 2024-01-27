return {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"folke/neodev.nvim", -- nvim's namespace for lua lsp
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
	},
	{
	  "ray-x/lsp_signature.nvim",
	  event = "VeryLazy",
	  opts = {},
	  config = function(_, opts) require("lsp_signature").setup(opts) end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make"
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",

			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("lualine").setup({
				icons_enabled = true,
				theme = "catppuccin"
			})
		end
	},
	{
		-- cool theme!
		"catppuccin/nvim",

		name="catppuccin",
		priority = 1000,

		config = function()
			vim.cmd "colorscheme catppuccin"
		end
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},
}
