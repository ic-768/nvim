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
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- up arrow saves
vim.api.nvim_set_keymap("n", "<Up>", ":w<CR>", { noremap = true, silent = true })
-- right arrow saves
vim.api.nvim_set_keymap("n", "<Right>", ":q<CR>", { noremap = true, silent = true })
-- toggle tailwind class visibility
vim.api.nvim_set_keymap("n", "<C-t>", ":TailwindFoldToggle<CR>", { noremap = true, silent = true })
-- toggle last window
vim.keymap.set("n", "<Backspace>", "<C-^>", { noremap = true, silent = true })
-- add className to an html tag
vim.api.nvim_set_keymap(
	"n",
	"<leader>c",
	[[:s/\(<\w*\)\(\_.\{-}\)/\1 className=""\2/e<CR>:noh<CR>f"a]],
	{ noremap = true, silent = true }
)
-- set current file as working directory
vim.api.nvim_create_user_command("SetCwd", function()
	vim.cmd("cd %:p:h")
end, {})

local o = vim.opt
o.scrolloff = 6
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
-- don't auto-resize all windows when splitting/closing panes
o.equalalways = false
-- so greek keyboard works with actions
o.langmap =
	"ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz"

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

-- concatenate
vim.keymap.set("v", "<leader>c", function()
	-- Cut
	vim.cmd('normal! "+d')
	local selected_text = vim.fn.getreg("+")

	-- Concatenate with comma
	local concatenated = selected_text:gsub("\n", ",")

	-- Copy to clipboard
	vim.fn.setreg("+", concatenated)
end, { noremap = true, silent = true })

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
})

-- browser search
local browser_search = function(query)
	query = query:gsub(" ", "+")
	local url = "https://search.brave.com/" .. "search?q=" .. query
	os.execute("xdg-open '" .. url .. "' > /dev/null 2>&1 &")
end

vim.api.nvim_create_user_command("BrowserSearch", function(opts)
	browser_search(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("BrowserSearchVisual", function()
	local lines = vim.fn.getline("'<", "'>")
	local query = type(lines) == "table" and table.concat(lines, " ") or lines
	browser_search(query)
end, { range = true })

vim.keymap.set("n", "gb", ":BrowserSearch ", { noremap = true, silent = true })
vim.keymap.set("v", "gs", ":'<,'>BrowserSearchVisual<CR>", { noremap = true, silent = true })

-- copy path to clipboard
local copy_path_to_clipboard = function()
	vim.api.nvim_command('let @+ = expand("%:p")')
end

vim.keymap.set("n", "<leader>p", copy_path_to_clipboard, { noremap = true, silent = true })
