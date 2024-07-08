vim.g.gitblame_message_template = '        <author> • <summary> • <date>'
vim.g.gitblame_date_format = '%r'

return {
  {
    'f-person/git-blame.nvim',
    lazy = false
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
  },

}
