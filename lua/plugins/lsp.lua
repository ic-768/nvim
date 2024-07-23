return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "tsserver", "eslint", "tailwindcss", "pyright", "lua_ls" },
		})

		require("mason-lspconfig").setup()

		-- automatically install ensure_installed servers
		require("mason-lspconfig").setup_handlers({
			-- Will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({})
			end,
		})

		vim.keymap.set("n", "g]", vim.diagnostic.goto_next)
		vim.keymap.set("n", "g[", vim.diagnostic.goto_prev)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),

			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gs", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
				--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
			end,
		})
	end,
}
