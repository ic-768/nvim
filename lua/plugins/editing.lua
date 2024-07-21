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
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require("neo-tree").setup({
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["s"] = "open_split",
          ["S"] = "open_vsplit",
          ["l"] = "open", -- TODO doesn't work :\
        },
        filesystem={
          follow_current_file = {
            enabled = false
          }
        }})
        vim.keymap.set('n', ':E', '<Cmd>Neotree toggle<CR>')
      end
    }
  }
