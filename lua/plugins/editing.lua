return {
	"ntpeters/vim-better-whitespace",
	"mbbill/undotree",
	"tpope/vim-surround",
	"ap/vim-css-color",
	{
		"tzachar/highlight-undo.nvim",
		opts = {},
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"razak17/tailwind-fold.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "typescriptreact", "javascriptreact" },
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				mappings = { -- Keys to be mapped to their corresponding default scrolling animation
					"<C-u>",
					"<C-d>",
					-- overridden by coc for floating windows
					-- '<C-b>', '<C-f>',
					"<C-y>",
					"<C-e>",
					"zt",
					"zz",
					"zb",
				},
			})
		end,
	},
}
