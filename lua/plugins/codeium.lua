local M = {
  'Exafunction/codeium.vim', branch='main',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

M.config = function()
  vim.keymap.set("i", "<C-j>", function() return vim.fn["codeium#AcceptNextWord"]() end, { expr = true, silent = true })
  vim.keymap.set("i", "<C-l>", function() return vim.fn["codeium#AcceptNextLine"]() end, { expr = true, silent = true })
  vim.keymap.set("i", "<C-Tab>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
  vim.keymap.set('i', '<C-s>', '<Cmd>call codeium#CycleCompletions(1)<CR>', { silent = true })
  vim.keymap.set('i', '<C-a>', '<Cmd>call codeium#CycleCompletions(-1)<CR>', { silent = true })
  vim.keymap.set('i', '<C-x>', '<Cmd>call codeium#Clear()<CR>', { silent = true })
  vim.g.codeium_filetypes_disabled_by_default = true
  vim.g.codeium_filetypes = {
    typescript = true,
    javascript = true,
    javascriptreact = true,
    typescriptreact = true,
    python = true
  }

  -- add codeium status to statusline
  local existing_statusline = vim.opt.statusline:get()
  local codeiumStatus = '%{codeium#GetStatusString()} '
  local codeiumColor = "%#Title#"

  local new_statusline = string.format('%s%s%s',codeiumColor, codeiumStatus, existing_statusline)
  vim.opt.statusline = new_statusline


end

return M
