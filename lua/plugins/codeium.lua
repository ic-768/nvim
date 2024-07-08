local M = {
  'Exafunction/codeium.vim', branch='main',
  lazy = false
}

M.config = function()
  vim.keymap.set('i', '<script><silent><nowait><expr> <tab>', 'codeium#Accept()', { silent = true, nowait = true, expr = true })
  vim.keymap.set('i', '<script><silent><nowait><expr> <C-i>', 'codeium#AcceptNextWord()', { silent = true, nowait = true, expr = true })
  vim.keymap.set('i', '<script><silent><nowait><expr> <C-l>', 'codeium#AcceptNextLine()', { silent = true, nowait = true, expr = true })
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
