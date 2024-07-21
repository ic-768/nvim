return {
  {
    "ntpeters/vim-better-whitespace",
    lazy = false,
  },
  {
    "mbbill/undotree",
    lazy = false,
  },
  {
    'tpope/vim-surround',
    lazy = false,
  },
  {
    "karb94/neoscroll.nvim",
    config = function ()
      require('neoscroll').setup({
        mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
          '<C-u>', '<C-d>',
          -- overridden by coc for floating windows
          -- '<C-b>', '<C-f>',
          '<C-y>', '<C-e>',
          'zt', 'zz', 'zb',
        },
      })
    end
  },
  {
    'ap/vim-css-color',
    lazy = false
  },
  {
    'razak17/tailwind-fold.nvim',
    opts= {},
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'typescriptreact', 'javascriptreact' },
  },
  {
    'tzachar/highlight-undo.nvim',
    opts = { },
  },
}
