return {
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
				},
				blank = {
					enable = true,
					chars = {
						"․",
						"⁚",
						"⁖",
						"⁘",
						"⁙",
					},
					style = {
						"#666666",
						"#555555",
						"#444444",
						"#806d9c",
					},
				},
			})
		end,
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			require("marks").setup({
				default_mappings = false,
			})
		end,
	},
	"ntpeters/vim-better-whitespace",
	"ap/vim-css-color",
	"tpope/vim-surround",
	"mbbill/undotree",
	{
		"echasnovski/mini.map",
		version = false,
		config = function()
			local MiniMap = require("mini.map")
			MiniMap.setup()
			vim.keymap.set("n", "<leader>o", MiniMap.toggle)
		end,
	},
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
