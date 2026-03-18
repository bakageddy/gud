vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.number = true
vim.g.relativenumber = true

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.incsearch = true
vim.opt.showcmd = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.ruler = true
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.cmdheight = 1
vim.opt.updatetime = 50

vim.opt.backspace = "eol,indent,start"
vim.opt.completeopt = "menu,menuone,noinsert"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 15
vim.g.colorcolumn = 80

vim.wo.wrap = false
vim.o.laststatus = 3
vim.cmd [[set t_Co=256]]
vim.cmd [[let g:omni_sql_default_compl_type = 'syntax']]
