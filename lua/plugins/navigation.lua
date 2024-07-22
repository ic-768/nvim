return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults={
          file_ignore_patterns = { "node_modules","package%-lock" }
        }
      }

      local telescope = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', telescope.resume, {})
      vim.keymap.set('n', '<leader>f', telescope.find_files, {})
      vim.keymap.set('n', '<leader>r', telescope.registers, {})
      vim.keymap.set('n', '<leader>t', telescope.live_grep, {})
      vim.keymap.set('n', '<leader>g', telescope.git_status, {})
      vim.keymap.set('n', '<leader>b', telescope.buffers, {})

    end
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = function()

      -- harpoon
      vim.keymap.set('n', '<Leader>s', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>w', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<C-g>', ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<C-h>', ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })


    end
  },
  {
    "dzfrias/arena.nvim",
    event = "BufWinEnter",
    config = function()


      vim.keymap.set('n', '<C-t>', ':lua require("arena").toggle()<CR>', { noremap = true, silent = true })

      require('arena').setup({
        keybinds = {
          -- same as coc-explorer
          ["s"] = require("arena").action(function(bufnr, info)
            vim.cmd({
              cmd = "split",
              args = { vim.fn.bufname(bufnr) },
              mods = { horizontal = true },
            })
            vim.fn.cursor(info.lnum, 0)
          end),
          ["v"] = require("arena").action(function(bufnr, info)
            vim.cmd({
              cmd = "split",
              args = { vim.fn.bufname(bufnr) },
              mods = { vertical = true },
            })
            vim.fn.cursor(info.lnum, 0)
          end)
        },
      })


    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    config = function ()
      require("window-picker").setup({
        highlights = {
          statusline = {
            focused = {
              fg = '#ededed',
              bg = '#e35e4f',
              bold = true,
            },
            unfocused = {
              fg = '#ffffff',
              bg = '#000000',
              bold = true,
            },
          },
        }
      })

      require("neo-tree").setup({
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        window = {
          mappings = {
            ["l"] = "open_with_window_picker",
            ["h"] = "close_node",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
          },
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      })
      vim.keymap.set('n', ':E', '<Cmd>Neotree toggle reveal <CR>')
    end
  }
}
