return {
  {
    "williamboman/mason.nvim",
    lazy=false,
    dependencies={
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {'tsserver','eslint','pyright'},
        automatic_installation = true,
      })

      require("lspconfig").tsserver.setup{}
      require("lspconfig").eslint.setup{}
      require("lspconfig").pyright.setup{}

      vim.keymap.set("n", "g]", vim.diagnostic.goto_next)
      vim.keymap.set("n", "g[", vim.diagnostic.goto_prev)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),

        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gs', vim.lsp.buf.rename,opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
        end,
      })
    end
  },
  {
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
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
}
