vim.keymap.set("n", "<LEADER>w", vim.cmd.write, {})
vim.keymap.set("n", "<LEADER>q", function () vim.cmd.quit{bang=true} end, {})
vim.keymap.set("n", "<LEADER>sl", ":luafile %<CR>", {})
vim.keymap.set("n", "<LEADER>rb", "<C-^>", {})
vim.keymap.set("n", "<LEADER>on", "<CMD>Neotree toggle<CR>", {})

vim.keymap.set("n", "<LEADER>p", [["+p]], {})
vim.keymap.set("n", [[<LEADER>y]], [["+y]], {})

vim.keymap.set("i", "jj", "<ESCAPE>", { desc = "JJ the best keymap" }) 
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Focus Buffer down" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Focus Buffer up" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Focus Buffer left" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Focus Buffer right" })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
