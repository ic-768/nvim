return {
	{
		"fei6409/log-highlight.nvim",
		config = function()
			require("log-highlight").setup({})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ts_ls",
					"eslint",
					"tailwindcss",
					"emmet_language_server",
					"jsonls",
				},
			})

			require("mason-lspconfig").setup()

			-- automatically install ensure_installed servers
			require("mason-lspconfig").setup_handlers({
				-- Will be called for each installed server that doesn't have
				-- a dedicated handler.
				--
				function(server_name) -- default handler (optional)
					-- https://github.com/neovim/nvim-lspconfig/pull/3232
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})

			vim.keymap.set("n", "g]", function()
				vim.diagnostic.jump({ count = 1 })
			end)
			vim.keymap.set("n", "g[", function()
				vim.diagnostic.jump({ count = -1 })
			end)
			vim.keymap.set("n", "gK", vim.diagnostic.open_float)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),

				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
					--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				end,
			})
		end,
	},
}
