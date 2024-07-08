local M = {
  "neoclide/coc.nvim",
  branch = "master",
  build = "yarn install --frozen-lockfile",
}

M.config = function() vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
  vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
  vim.keymap.set('n', '<Leader>i', '<Plug>(coc-implementation)', { silent = true })
  vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })
  vim.keymap.set('n', 'g]', '<Plug>(coc-diagnostic-next)', { silent = true })
  vim.keymap.set('n', 'g[', '<Plug>(coc-diagnostic-prev)', { silent = true })
  vim.keymap.set('n', 'gs', '<Plug>(coc-rename)', { silent = true })

  -- Use K to show documentation in preview window
  function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
      vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
      vim.fn.CocActionAsync('doHover')
    else
      vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
  end

  vim.api.nvim_create_user_command('Prettier', function()
    vim.cmd('CocCommand prettier.forceFormatDocument')
  end, { nargs = 0 })

  vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
  vim.keymap.set('n', 'K', ':lua vim.fn.CocActionAsync("doHover")<CR>', { silent = true })
  vim.keymap.set('n', ':E', '<Cmd>CocCommand explorer<CR>', { silent = true })

  vim.keymap.set('i', '<C-k>', 'coc#refresh()', { silent = true, expr = true })
  vim.keymap.set("n", "<C-k>", function()
    vim.api.nvim_feedkeys("viwoeA","n", false)
    vim.fn["coc#refresh"]()
  end
  )

  vim.keymap.set('x', '<leader>ra', '<Plug>(coc-codeaction-selected)', {})
  vim.keymap.set('n', '<leader>ra', '<Plug>(coc-codeaction-cursor)', {})
  vim.keymap.set("x", "<leader>rr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
  vim.keymap.set("n", "<leader>rr", "<Plug>(coc-codeaction-refactor)", { silent = true })

end

return M
