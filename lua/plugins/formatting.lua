return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "eslint_d","prettierd" },
        typescript = { "eslint_d","prettierd" },
        javascriptreact = { "eslint_d","prettierd" },
        typescriptreact = { "eslint_d","prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
      },
      format_on_save = {
        lsp_fallback = true,
      },
    })
  end,
}
