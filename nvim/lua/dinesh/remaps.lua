vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>", {})
vim.keymap.set("n", "<LEADER>w", vim.cmd.write, {})
vim.keymap.set("n", "<LEADER>q", function () vim.cmd.quit{bang=true} end, {})

vim.keymap.set("n", "<LEADER>sl", ":luafile %<CR>", {})
vim.keymap.set("n", "<LEADER>py", ":!python3 %<CR>", {})

vim.keymap.set("n", "<LEADER>ps", vim.cmd.PackerSync, {})
vim.keymap.set("n", "<LEADER>pc", vim.cmd.PackerClean, {})

vim.keymap.set("n", "<LEADER>rb", "<C-^>", {})
vim.keymap.set("n", "<LEADER>on", "<CMD>Neotree toggle<CR>", {})

vim.keymap.set("n", "<LEADER>p", [["+p]], {})

vim.keymap.set("n", "<UP>", "<NOP>", {})
vim.keymap.set("n", "<DOWN>", "<NOP>", {})
vim.keymap.set("n", "<LEFT>", "<NOP>", {})
vim.keymap.set("n", "<RIGHT>", "<NOP>", {})

vim.keymap.set("i", "<UP>", "<NOP>", {})
vim.keymap.set("i", "<DOWN>", "<NOP>", {})
vim.keymap.set("i", "<LEFT>", "<NOP>", {})
vim.keymap.set("i", "<RIGHT>", "<NOP>", {})

vim.keymap.set("n", "<LEADER>j", ":wincmd j<CR>", {})
vim.keymap.set("n", "<LEADER>h", ":wincmd h<CR>", {})
vim.keymap.set("n", "<LEADER>l", ":wincmd l<CR>", {})
vim.keymap.set("n", "<LEADER>k", ":wincmd k<CR>", {})
