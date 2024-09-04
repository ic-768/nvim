vim.g.gitblame_message_template = "        <author> • <summary> • <date>"
vim.g.gitblame_date_format = "%r"

return {
	"f-person/git-blame.nvim",
	"sindrets/diffview.nvim",
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")
					-- Next/prev git changes
					vim.keymap.set("n", "g}", function()
						if vim.wo.diff then
							vim.cmd.normal({ "g}", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					vim.keymap.set("n", "g{", function()
						if vim.wo.diff then
							vim.cmd.normal({ "g{", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)
				end,
			})
		end,
	},
}
