return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>x",
			"<cmd>Trouble diagnostics toggle win = {type='split',position='right'}<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>X",
			"<cmd>Trouble diagnostics toggle win = {type='split',position='right'} filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
	},
}
