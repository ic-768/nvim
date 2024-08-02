return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules", "package%-lock" },
				},
			})

			local telescope = require("telescope.builtin")
			vim.keymap.set("n", "<leader><leader>", telescope.resume, {})
			vim.keymap.set("n", "<leader>f", telescope.find_files, {})
			vim.keymap.set("n", "<leader>r", telescope.registers, {})
			vim.keymap.set("n", "<leader>t", telescope.live_grep, {})
			vim.keymap.set("n", "<leader>g", telescope.git_status, {})
			vim.keymap.set("n", "<leader>b", telescope.buffers, {})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- harpoon
			vim.keymap.set(
				"n",
				"<Leader>s",
				':lua require("harpoon.mark").add_file()<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<Leader>w",
				':lua require("harpoon.ui").toggle_quick_menu()<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<C-g>", ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })
			vim.keymap.set("n", "<C-h>", ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })
		end,
	},
	{
		"dzfrias/arena.nvim",
		event = "BufWinEnter",
		config = function()
			vim.keymap.set("n", "<C-t>", ':lua require("arena").toggle()<CR>', { noremap = true, silent = true })

			require("arena").setup({
				keybinds = {
					-- same as coc-explorer
					["s"] = require("arena").action(function(bufnr, info)
						vim.cmd({
							cmd = "split",
							args = { vim.fn.bufname(bufnr) },
							mods = { horizontal = true },
						})
						vim.fn.cursor(info.lnum, 0)
					end),
					["v"] = require("arena").action(function(bufnr, info)
						vim.cmd({
							cmd = "split",
							args = { vim.fn.bufname(bufnr) },
							mods = { vertical = true },
						})
						vim.fn.cursor(info.lnum, 0)
					end),
				},
			})
		end,
	},
	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup()
			local minifiles_toggle = function(...)
				if not MiniFiles.close() then
					MiniFiles.open(...)
				end
			end
			-- open working directory
			vim.keymap.set("n", ":E", minifiles_toggle)
			-- open file directory
			vim.keymap.set("n", ":F", function()
				minifiles_toggle(vim.api.nvim_buf_get_name(0))
			end)
		end,
	},
}
