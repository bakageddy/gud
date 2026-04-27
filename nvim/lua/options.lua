vim.o.termguicolors = true

-- backup/undodir
local undodir = vim.fn.expand("~/.config/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = undodir

-- appearance
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.cmdheight = 1
vim.o.showmode = false
vim.o.laststatus = 3

vim.o.updatetime = 5000
vim.o.timeoutlen = 500
vim.o.autoread = true
vim.o.autowrite = false
vim.o.errorbells = false

vim.o.splitbelow = true
vim.o.splitright = true

-- tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.autoindent = true

-- search
vim.o.incsearch = true
vim.o.hlsearch = false

-- complete
vim.o.completeopt = "menu,menuone,noinsert"

-- misc
vim.o.lazyredraw = true
vim.o.hidden = true
vim.o.backspace = "indent,eol,start"
vim.o.clipboard = "unnamedplus"
vim.o.encoding = "UTF-8"
vim.o.maxmempattern = 20000

vim.o.wildmenu = true
vim.o.redrawtime = 10000

vim.g.mapleader = " "
vim.g.maplocalleader = " "
