vim.pack.add({
	'https://github.com/jlfwong/vim-mercenary',
	'https://github.com/NeogitOrg/neogit',
	'https://github.com/sindrets/diffview.nvim',
})

vim.cmd [[packadd nvim.difftool]]
local _ = require("neogit").setup()
