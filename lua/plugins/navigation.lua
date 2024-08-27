return {
	--{
	--	"ic-768/quick-files",
	--	name = "quick-files",
	--	config = function()
	--		require("quick-files").setup()
	--	end,
	--},
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
			vim.keymap.set("n", "<leader>h", telescope.help_tags, {})
			vim.keymap.set("n", "<leader>b", telescope.buffers, {})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			vim.keymap.set("n", "<leader>s", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<Leader>w", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<C-g>", function()
				harpoon:list():next()
			end)
			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():prev()
			end)
		end,
	},
	{
		"dzfrias/arena.nvim",
		event = "BufWinEnter",
		config = function()
			vim.keymap.set("n", "<C-t>", ':lua require("arena").toggle()<CR>', { noremap = true, silent = true })

			require("arena").setup({})
		end,
	},
	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup({
				windows = {
					preview = true,
					width_preview = 70,
				},
				mappings = {
					go_in = "",
					go_in_plus = "L",
					go_out = "H",
					go_out_plus = "",
				},

				options = {
					use_as_default_explorer = false,
				},
			})
			local map_split = function(buf_id, lhs, direction)
				local rhs = function()
					-- Make new window and set it as target
					local new_target_window
					local target_window = MiniFiles.get_target_window()
					if not target_window then
						return
					end

					vim.api.nvim_win_call(target_window, function()
						vim.cmd(direction .. " split")
						new_target_window = vim.api.nvim_get_current_win()
					end)

					MiniFiles.set_target_window(new_target_window)
					MiniFiles.go_in({ close_on_file = true })
				end

				-- Adding `desc` will result into `show_help` entries
				local desc = "Split " .. direction
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					-- Tweak keys to your liking
					map_split(buf_id, "gs", "belowright horizontal")
					map_split(buf_id, "gv", "belowright vertical")
					vim.keymap.set("n", "<Esc>", MiniFiles.close, { buffer = buf_id })
				end,
			})

			local minifiles_toggle = function(...)
				if not MiniFiles.close() then
					MiniFiles.open(...)
				end
			end
			-- open file directory
			vim.keymap.set("n", "<leader>d", function()
				minifiles_toggle(vim.api.nvim_buf_get_name(0))
			end)
		end,
	},
}
