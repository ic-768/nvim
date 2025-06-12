return {
	{
		"ic-768/quick-files",
		name = "quick-files",
		config = function()
			require("quick-files").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"isak102/telescope-git-file-history.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"tpope/vim-fugitive",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules", "package%-lock" },
					mappings = {
						n = {
							["<C-s>"] = function(b_nr)
								local actions = require("telescope.actions")
								actions.send_selected_to_qflist(b_nr)
								actions.open_qflist(b_nr)
							end,
						},
					},
				},
				pickers = {
					buffers = {
						sort_lastused = false,
						sort_mru = true,
					},
				},
			})
			require("telescope").load_extension("git_file_history")

			local telescope = require("telescope")
			local telescope_builtin = require("telescope.builtin")

			local start_in_normal = function(picker)
				return function()
					picker({ initial_mode = "normal" })
				end
			end

			vim.keymap.set("n", "<leader><leader>", start_in_normal(telescope_builtin.resume), {})
			vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {})
			vim.keymap.set("n", "<leader>r", telescope_builtin.registers, {})
			vim.keymap.set("n", "<leader>t", telescope_builtin.live_grep, {})
			vim.keymap.set("n", "<leader>g", telescope_builtin.git_status, {})
			vim.keymap.set("n", "<leader>h", telescope.extensions.git_file_history.git_file_history, {})
			vim.keymap.set("n", "<leader>b", start_in_normal(telescope_builtin.buffers), {})
			vim.keymap.set("n", "<leader>k", telescope_builtin.jumplist, {})
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
		"echasnovski/mini.files",
		version = false,
		config = function()
			require("mini.files").setup({
				-- General options
				options = {
					-- Whether to delete permanently or move into module-specific trash
					permanent_delete = true,
					-- Whether to use for editing directories
					use_as_default_explorer = true,
				},
				windows = {
					-- Maximum number of windows to show side by side
					max_number = math.huge,
					-- Whether to show preview of file/directory under cursor
					preview = true,
					-- Width of focused window
					width_focus = 50,
					-- Width of non-focused window
					width_nofocus = 15,
					-- Width of preview window
					width_preview = 40,
				},
				mappings = {
					go_in = "",
					go_in_plus = "L",
					go_out = "H",
					go_out_plus = "",
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
