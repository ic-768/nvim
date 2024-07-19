return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter','nvim-tree/nvim-web-devicons' },
    config = function()
      require('render-markdown').setup({})
    end,
  }
}
