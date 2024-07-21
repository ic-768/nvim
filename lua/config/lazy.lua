-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set('n', '<Backspace>', '<C-^>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
 'n',
 '<leader>c',
 [[:s/\(<\w*\)\(\_.\{-}\)/\1 className=""\2/e<CR>:noh<CR>f"a]],
 { noremap = true, silent = true }
)


local o = vim.opt
o.compatible = false
o.linebreak = true
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.nu = true
o.visualbell = true
o.clipboard = "unnamedplus"
o.tabstop = 2
o.shiftwidth = 2
o.mouse = "a"
o.ve = "all" --freely move cursor
o.relativenumber = true
o.expandtab = true

-- For coc
o.updatetime = 300
o.signcolumn = "yes"

local function git_branch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  if string.len(branch) > 0 then
    return branch
  else
    return ":"
  end
end
local function statusline()
  local set_color_1 = "%#BGadd8e6#"
  local branch = git_branch()
  local set_color_2 = "%#Constant#"
  local file_name = " %f"
  local modified = "%m"
  local align_right = "%="
  local filetype = " %y"
  local percentage = " %p%%"
  local linecol = " %l:%c"

  return string.format(
  "%s %s %s%s%s%s%s%s%s",
  set_color_1,
  branch,
  set_color_2,
  file_name,
  modified,
  align_right,
  filetype,
  percentage,
  linecol
  )
end

vim.opt.statusline = vim.opt.statusline + statusline()

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
})
