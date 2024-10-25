return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			local JS = { "eslint_d", "prettierd", "rustywind" }

			conform.setup({
				formatters_by_ft = {
					javascript = JS,
					typescript = JS,
					javascriptreact = JS,
					typescriptreact = JS,
					css = { "prettierd" },
					scss = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					python = { "ruff_organize_imports", "ruff_format" },
					lua = { "stylua" },
				},
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { lsp_format = "fallback", timeout_ms = 5000 }
				end,
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, { desc = "Re-enable autoformat-on-save" })
		end,
	},
	{
		"2nthony/sortjson.nvim",
		cmd = {
			"SortJSONByAlphaNum",
			"SortJSONByAlphaNumReverse",
			"SortJSONByKeyLength",
			"SortJSONByKeyLengthReverse",
		},
		-- options with default values
		opts = {
			jq = "jq", -- jq command, you can try `jaq` `gojq` etc.
			log_level = "WARN", -- log level, see `:h vim.log.levels`, when parsing json failed
		},
	},
}
