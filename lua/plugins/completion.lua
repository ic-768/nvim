return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")

    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig')['tsserver'].setup {
      capabilities = capabilities
    }

    vim.keymap.set("n", "<C-k>", function()
      vim.api.nvim_feedkeys("viwoeA","n", false)
      cmp.select_next_item()
    end
    )
  end
}
